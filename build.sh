CHOOSE_ROS_DISTRO=humble

chmod 777 ros_entrypoint.sh
chmod 777 ros2_setup_scripts_ubuntu.sh

docker build -t ros2docker:$CHOOSE_ROS_DISTRO .
