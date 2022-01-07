USER_NAME=matomato
WORKSPACE=workspace/github/ros2docker/ros2_ws
CHOOSE_ROS_DISTRO=galactic

docker run --rm -it --privileged \
        --gpus all \
	--net=host \
        --device=/dev/ttyUSB0:/dev/ttyUSB0 \
        --device=/dev/dri/renderD128:/dev/dri/renderD128 \
        --device=/dev/dri/card0:/dev/dri/card0 \
        --user 1000:109 \
        --group-add 44 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /etc/localtime:/etc/localtime \
        -v /home/$USER_NAME/$WORKSPACE:/home/developer/ros2_ws \
        -e DISPLAY=$DISPLAY \
        --name glvnd \
        ros2docker:$CHOOSE_ROS_DISTRO
