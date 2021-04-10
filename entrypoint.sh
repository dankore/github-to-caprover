#!/bin/sh

if [[ -z ${INPUT_SERVER} ]]; then
  echo "Please add your Caprover URL."
  exit 1
fi
if [[ [[ -z ${INPUT_PASSWORD} ]]; then
  echo "Please add your Caprover password."
  exit 1
fi
if [[ -z ${INPUT_APPNAME} ]]; then
  echo "Please add your Caprover application name."
  exit 1
fi

if [ x$INPUT_IMAGE != x ]
then
  caprover deploy -h $INPUT_SERVER -p $INPUT_PASSWORD -a $INPUT_APPNAME -i $INPUT_IMAGE
else
  caprover deploy -h $INPUT_SERVER -p $INPUT_PASSWORD -a $INPUT_APPNAME -b $INPUT_BRANCH
fi