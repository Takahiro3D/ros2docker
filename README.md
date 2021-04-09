 ros2docker
 ===

# 1. install

## 1.1 install docker

https://docs.docker.com/engine/install/

## 1.2 install nvidia-docker2

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker

# 2. build

```bash
sh build.sh
```

# 3. run

Set `USER_NAME` and `WORKSPACE` in run.sh before running.

```bash:run.sh
USER_NAME=matomato
WORKSPACE=workspace/github/ros2docker/ros2_ws
```

Run as follows:
```bash:
sh run.sh
```

