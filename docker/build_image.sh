#!/bin/bash

source $(dirname $0)/.env
WS_NAME=`echo $(basename $(cd $(dirname $0)/../; pwd)) | sed -e 's/-/_/g'`

# dev or rel
BUILD_TYPE_DEV=dev
BUILD_TYPE=${1:-$BUILD_TYPE_DEV}

TARGET_DF=./Dockerfile.rel
DOCKER_CTX=..
DOCKER_TAG=rel_$WS_NAME
if [ $BUILD_TYPE = $BUILD_TYPE_DEV ]; then
  TARGET_DF=./Dockerfile.dev
  DOCKER_CTX=.
  DOCKER_TAG=dev_$WS_NAME
fi

(
  cd $(dirname $0)  
  docker build -t $DOCKER_IMG:$DOCKER_TAG -f $TARGET_DF $DOCKER_CTX
)
