#!/bin/bash

(
  cd $(dirname $0)  
  docker build -t mu777/ros2:foxy_dev -f ./Dockerfile .
)
