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
    caprover deploy --caproverUrl "${SERVER}" --appToken "${APP_TOKEN}" --appName "${APPNAME}" -i "${IMAGE}"
  else
    caprover deploy --caproverUrl "${SERVER}" --appToken "${APP_TOKEN}" --appName "${APPNAME}" -b "${BRANCH}"
  fi
else
  if [ -z "${PASSWORD}" ]; then
    echo "Please add your Caprover password, or set app_token for CapRover Pro (OTP) deployments."
    exit 1
  fi
  if [ -n "${IMAGE}" ]; then
    caprover deploy -h "${SERVER}" -p "${PASSWORD}" -a "${APPNAME}" -i "${IMAGE}"
  else
    caprover deploy -h "${SERVER}" -p "${PASSWORD}" -a "${APPNAME}" -b "${BRANCH}"
  fi
fi
