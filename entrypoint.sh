#!/bin/bash

/ros_entrypoint.sh

UNAME=`whoami`
EXEC_CMD=""
if [ $UNAME != root ];then
  sudo chown $UNAME:$UNAME /home/$UNAME
else
  UNAME=rosuser
  USER_ID=60001
  GROUP_ID=60001
  echo "Start as \"$UNAME\"(UID: $USER_ID, GID: $GROUP_ID)"
  useradd -u $USER_ID -o -m $UNAME
  groupmod -g $GROUP_ID $UNAME
  export HOME=/home/$UNAME
  EXEC_CMD="`which gosu` $UNAME"
fi

cat << '_EOS_' > $HOME/.bashrc
# /etc/profile works only in `bash -l`
source /usr/share/bash-completion/bash_completion

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\[\033[01;32m\]ros2ctr:\[\033[01;34m\]\w\[\033[30m\]$(__git_ps1)\[\033[00m\] \$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@ros2ctr:\w$(__git_ps1) \$ '
fi

source "/opt/ros/$ROS_DISTRO/setup.bash"
_EOS_

exec $EXEC_CMD "$@"