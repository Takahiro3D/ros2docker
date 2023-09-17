#!/usr/bin/env bash
set -eu

# REF: https://index.ros.org/doc/ros2/Installation/Linux-Install-Debians/
# by Open Robotics, licensed under CC-BY-4.0
# source: https://github.com/ros2/ros2_documentation

# REF: https://github.com/Tiryoh/ros2_setup_scripts_ubuntu/blob/master/run.sh
# by https://github.com/Tiryoh, Apache-2.0 License

# REF https://gbiggs.github.io/rosjp_ros2_intro/computer_prep_linux.html

CHOOSE_ROS_DISTRO=humble # or dashing
INSTALL_PACKAGE=desktop # or ros-base

export DEBIAN_FRONTEND=noninteractive

# Set ROS2 env values
source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash

sudo apt-get update



# Set ROS2 env values
source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash

echo "success installing ROS2 $CHOOSE_ROS_DISTRO"
echo "Run 'source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash'"