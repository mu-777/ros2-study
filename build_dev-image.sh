#!/bin/bash

(
  cd ros2_docker
  bash build_image.sh
)

docker build -t mu777/ros2:foxy_dev .