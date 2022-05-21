#!/bin/bash

source $(dirname $0)/.env
WS_NAME=`echo $(basename $(cd $(dirname $0)/../; pwd)) | sed -e 's/-/_/g'`

if [[ "$(uname -r)" == *microsoft* ]]; then
  HOST_IP=`ipconfig.exe | grep IPv4 | grep -v 172 | cut -d: -f2 | awk '{ print $1}' | sed 's/\r//g'`
  DISPLAY=${HOST_IP}:0.0
fi

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
  --name $WS_NAME-dev \
  $DOCKER_IMG:dev_$WS_NAME /bin/sh -c "while : ; do sleep 3; done"
