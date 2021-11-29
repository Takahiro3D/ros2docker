 ros2docker
 ===

# 1. install

## 1.1 install docker

https://docs.docker.com/engine/install/

## 1.2 install nvidia-docker2

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker

# 2. build

Build as follows:

```sh
sh build.sh
```

# 3. run

Set `USER_NAME` and `WORKSPACE` in run.sh before running as follows:

```sh:run.sh
USER_NAME=<host_user name>
WORKSPACE=<host_directory>

docker run --rm -it --privileged \
        --gpus all \
        --device=/dev/ttyUSB0:/dev/ttyUSB0 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /etc/localtime:/etc/localtime \
        -v /home/$USER_NAME/$WORKSPACE:/home/developer/ros2_ws \
        -e DISPLAY=$DISPLAY \
        --name glvnd \
        ros2docker:galactic
```
where, `--device=/dev/ttyUSB0:/dev/ttyUSB0` means an optional command to use usb device on host side.

Run as follows:

```sh
sh run.sh
```

# Cited

- https://github.com/Tiryoh/docker-ros2-desktop-vnc
- https://github.com/Tiryoh/ros2_setup_scripts_ubuntu
- https://qiita.com/tomp/items/50081b99df7963462488