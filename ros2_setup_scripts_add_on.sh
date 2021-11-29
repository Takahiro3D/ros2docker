#!/usr/bin/env bash
set -eu

# REF: https://index.ros.org/doc/ros2/Installation/Linux-Install-Debians/
# by Open Robotics, licensed under CC-BY-4.0
# source: https://github.com/ros2/ros2_documentation

# REF: https://github.com/Tiryoh/ros2_setup_scripts_ubuntu/blob/master/run.sh
# by https://github.com/Tiryoh, Apache-2.0 License

# REF https://gbiggs.github.io/rosjp_ros2_intro/computer_prep_linux.html

CHOOSE_ROS_DISTRO=galactic # or dashing
INSTALL_PACKAGE=desktop # or ros-base

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update

sudo apt-get install -yq \
		libgazebo11-dev \
		gazebo11 \
		ros-$CHOOSE_ROS_DISTRO-gazebo-ros-pkgs

#　sudo apt-get install -yq \
#		ros-$CHOOSE_ROS_DISTRO-dynamixel-sdk \
#		ros-$CHOOSE_ROS_DISTRO-turtlebot3-msgs \
#		ros-$CHOOSE_ROS_DISTRO-turtlebot3 \
#		ros-$CHOOSE_ROS_DISTRO-turtlebot3-simulations

sudo apt-get install -yq \
		lsb-release \
		wget \
		gnupg

sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install -yq \
		ignition-citadel \
		ros-$CHOOSE_ROS_DISTRO-ros-ign

sudo apt-get install -yq \
		ros-$CHOOSE_ROS_DISTRO-joy \
        ros-$CHOOSE_ROS_DISTRO-teleop-twist-joy \
        ros-$CHOOSE_ROS_DISTRO-teleop-twist-keyboard

sudo apt-get install -yq \
		ros-$CHOOSE_ROS_DISTRO-navigation2 \
		ros-$CHOOSE_ROS_DISTRO-nav2-bringup \
        ros-$CHOOSE_ROS_DISTRO-slam-toolbox

# Add ROS2 env values in bash
grep -F "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" ~/.bashrc ||
echo "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" >> ~/.bashrc

echo "export XDG_RUNTIME_DIR=/some/directory/you/specify" >> ~/.bashrc 
echo "export RUNLEVEL=3" >> ~/.bashrc

echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/ros2_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models' >> ~/.bashrc
echo 'export TURTLEBOT3_MODEL=waffle' >> ~/.bashrc
source ~/.bashrc

set +u

# Set ROS2 env values
source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash

echo "success installing ROS2 $CHOOSE_ROS_DISTRO"
echo "Run 'source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash'"