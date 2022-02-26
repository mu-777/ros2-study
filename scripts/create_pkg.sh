#!/bin/bash

function usage() {
cat << _EOT_

Usage:
  $ ./create_pkg.sh [OPTION] cpp_or_py package_name node_name [dependences...]
Description:
  Create new ros2 package
Options:
  -h, --help		Show this help message
	
Arguments:
  cpp_or_py		"cpp" or "py" (default: cpp)
  package_name		package name (ros/<ws>/src/[package_name]/...)
  node_name		node name (ros/<ws>/src/[package_name]/src/[node_name]...)
  dependences...	Depended packages (e.g. rclcpp rclpy example_interfaces common_interfaces tf2... )

_EOT_
exit 1
}

case "$1" in
"-h" | "--help" ) 
  usage
  ;;
esac

BUILD_TYPE="ament_cmake"
if [ $1 == "py" ]; then
  BUILD_TYPE="ament_python"
fi
PACKAGE_NAME=$2
NODE_NAME=$3

WS_DIR=$(cd $(dirname $0);cd ..;pwd)
DEPENDENCES_ARGS=""
if [ $# -ge 4 ]; then
  DEPENDENCES_ARGS="--dependencies ${@:4}"
fi

source "/opt/ros/$ROS_DISTRO/setup.bash"

# https://docs.ros.org/en/foxy/Tutorials/Creating-Your-First-ROS2-Package.html
mkdir -p $WS_DIR/src
pushd $WS_DIR/src > /dev/null
ros2 pkg create $PACKAGE_NAME \
  --build-type $BUILD_TYPE \
  --node-name $NODE_NAME \
  $DEPENDENCES_ARGS
popd > /dev/null

pushd $WS_DIR > /dev/null
rosdep update
rosdep install -i --from-path src --rosdistro $ROS_DISTRO -y
colcon build --symlink-install --packages-select $PACKAGE_NAME
popd > /dev/null

source $WS_DIR/install/setup.bash

cat << _EOT_

Update <description> and <license> in $WS_DIR/src/$PACKAGE_NAME/package.xml
And try \`ros2 run $PACKAGE_NAME $NODE_NAME\` to run!

_EOT_