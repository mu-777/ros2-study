#!/bin/bash

# dev or rel
BUILD_TYPE_DEV=dev
BUILD_TYPE=${1:-$BUILD_TYPE_DEV}

TARGET_DF=./Dockerfile.rel
DOCKER_CTX=..
DOCKER_TAG=rel_`echo $(basename $(cd $(dirname $0)/../; pwd)) | sed -e 's/-/_/g'`
if [ $BUILD_TYPE = $BUILD_TYPE_DEV ]; then
  TARGET_DF=./Dockerfile.dev
  DOCKER_CTX=.
  DOCKER_TAG="foxy_dev"
fi

(
  cd $(dirname $0)  
  docker build -t mu777/ros2:$DOCKER_TAG -f $TARGET_DF $DOCKER_CTX
)
