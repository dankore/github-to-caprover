#!/bin/sh
set -eu

# Prefer Docker action positional args (reliable), fallback to INPUT_* env vars.
SERVER="${1:-${INPUT_SERVER:-}}"
PASSWORD="${2:-${INPUT_PASSWORD:-}}"
APP_TOKEN="${3:-${INPUT_APP_TOKEN:-}}"
APPNAME="${4:-${INPUT_APPNAME:-}}"
BRANCH="${5:-${INPUT_BRANCH:-}}"
IMAGE="${6:-${INPUT_IMAGE:-}}"

if [ -z "${SERVER}" ]; then
  echo "Please add your Caprover URL."
  exit 1
fi
if [ -z "${APPNAME}" ]; then
  echo "Please add your Caprover application name."
  exit 1
fi

if [ -n "${APP_TOKEN}" ]; then
  if [ -n "${IMAGE}" ]; then
    set -- caprover deploy --caproverUrl "${SERVER}" --appToken "${APP_TOKEN}" --appName "${APPNAME}" -i "${IMAGE}"
  else
    set -- caprover deploy --caproverUrl "${SERVER}" --appToken "${APP_TOKEN}" --appName "${APPNAME}" -b "${BRANCH}"
  fi
else
  if [ -z "${PASSWORD}" ]; then
    echo "Please add your Caprover password, or set app_token for CapRover Pro (OTP) deployments."
    exit 1
  fi
  if [ -n "${IMAGE}" ]; then
    set -- caprover deploy -h "${SERVER}" -p "${PASSWORD}" -a "${APPNAME}" -i "${IMAGE}"
  else
    set -- caprover deploy -h "${SERVER}" -p "${PASSWORD}" -a "${APPNAME}" -b "${BRANCH}"
  fi
fi

# The caprover CLI prints "Something bad happened" and still exits 0 when the server refuses a
# deploy (for example 429 "Another operation still in progress"), so its output decides the
# result. A busy server is retried a few times; any other error fails the step.
ATTEMPTS="${CAPROVER_DEPLOY_ATTEMPTS:-4}"
WAIT="${CAPROVER_DEPLOY_RETRY_SECONDS:-30}"
LOG=/tmp/caprover-deploy.log
attempt=1
while :; do
  echo 0 > /tmp/caprover-deploy.rc
  { "$@" || echo $? > /tmp/caprover-deploy.rc; } 2>&1 | tee "$LOG"
  status="$(cat /tmp/caprover-deploy.rc)"
  if [ "$status" -eq 0 ] && ! grep -q -i -e "something bad happened" -e "deploy failed" "$LOG"; then
    exit 0
  fi
  if grep -q -i -e "another operation still in progress" -e "429" "$LOG" && [ "$attempt" -lt "$ATTEMPTS" ]; then
    echo "CapRover is busy with another operation; retrying in ${WAIT}s (attempt $((attempt + 1)) of ${ATTEMPTS})."
    attempt=$((attempt + 1))
    sleep "$WAIT"
    continue
  fi
  echo "::error::CapRover deploy of ${APPNAME} failed (see the output above)."
  exit 1
done
