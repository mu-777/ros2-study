#!/bin/bash

if [ -e $DISPLAY ]; then 
  echo "Not found DISPLAY envvar"
else
  echo "You should run x11 server(with no RANDR) for GUI applications(rviz, rqt)"
fi

docker run --rm -itd \
  -v /etc/group:/etc/group:ro \
  -v /etc/passwd:/etc/passwd:ro \
  -v /etc/shadow:/etc/shadow:ro \
  -v $HOME/.vscode-server:$HOME/.vscode-server \
  -u $(id -u $USER):$(id -g $USER) \
  -v ${PWD}:${PWD} \
  -w ${PWD} \
  -e DISPLAY=${DISPLAY} \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --name ros2-study-dev \
  mu777/ros2:foxy_dev /bin/sh -c "while : ; do sleep 3; done"
