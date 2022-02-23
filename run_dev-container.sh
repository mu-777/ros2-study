#!/bin/bash

docker run --rm -itd \
  -v /etc/group:/etc/group:ro \
  -v /etc/passwd:/etc/passwd:ro \
  -v /etc/shadow:/etc/shadow:ro \
  -u $(id -u $USER):$(id -g $USER) \
  -v ${PWD}:${PWD} \
  -w ${PWD} \
  --name ros2-study-dev \
  mu777/ros2:foxy_dev /bin/sh -c "while :; do sleep 10; done"
