#!/bin/sh

if [ x$INPUT_IMAGE != x ]
then
  caprover deploy -h $INPUT_SERVER -p $INPUT_PASSWORD -a $INPUT_APPNAME -i $INPUT_IMAGE
else
  caprover deploy -h $INPUT_SERVER -p $INPUT_PASSWORD -a $INPUT_APPNAME -b $INPUT_BRANCH
fi