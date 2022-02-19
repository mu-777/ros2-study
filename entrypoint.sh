#!/bin/bash

/ros_entrypoint.sh

UNAME=`whoami`
if [ $UNAME != root ];then
  exec "$@"
else
  UNAME=rosuser
  USER_ID=60001
  GROUP_ID=60001
  echo "Start as \"$UNAME\"(UID: $USER_ID, GID: $GROUP_ID)"
  useradd -u $USER_ID -o -m $UNAME
  groupmod -g $GROUP_ID $UNAME
  export HOME=/home/$UNAME
  exec `which gosu` $UNAME "$@"
fi

