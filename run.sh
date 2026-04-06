#!/bin/sh
set -e

# GitHub Docker actions set input "app-token" as env INPUT_APP-TOKEN. Shells cannot use $INPUT_APP-TOKEN (hyphen).
_hyphen_app_token=$(printenv 'INPUT_APP-TOKEN' 2>/dev/null || true)
INPUT_APP_TOKEN="${INPUT_APP_TOKEN:-${_hyphen_app_token}}"

INPUT_PASSWORD="${INPUT_PASSWORD:-}"
INPUT_IMAGE="${INPUT_IMAGE:-}"
INPUT_BRANCH="${INPUT_BRANCH:-}"

if [ -z "${INPUT_SERVER}" ]; then
  echo "Please add your Caprover URL."
  exit 1
fi
if [ -z "${INPUT_APPNAME}" ]; then
  echo "Please add your Caprover application name."
  exit 1
fi

if [ -n "${INPUT_APP_TOKEN}" ]; then
  if [ -n "${INPUT_IMAGE}" ]; then
    caprover deploy --caproverUrl "${INPUT_SERVER}" --appToken "${INPUT_APP_TOKEN}" --appName "${INPUT_APPNAME}" -i "${INPUT_IMAGE}"
  else
    caprover deploy --caproverUrl "${INPUT_SERVER}" --appToken "${INPUT_APP_TOKEN}" --appName "${INPUT_APPNAME}" -b "${INPUT_BRANCH}"
  fi
else
  if [ -z "${INPUT_PASSWORD}" ]; then
    echo "Please add your Caprover password, or set app-token for CapRover Pro (OTP) deployments."
    exit 1
  fi
  if [ -n "${INPUT_IMAGE}" ]; then
    caprover deploy -h "${INPUT_SERVER}" -p "${INPUT_PASSWORD}" -a "${INPUT_APPNAME}" -i "${INPUT_IMAGE}"
  else
    caprover deploy -h "${INPUT_SERVER}" -p "${INPUT_PASSWORD}" -a "${INPUT_APPNAME}" -b "${INPUT_BRANCH}"
  fi
fi
