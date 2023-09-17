#FROM nvidia/cudagl:11.2.0-devel-ubuntu20.04
FROM amd64/ubuntu:jammy
LABEL maintainer="Dorebom<dorebom.b@gmail.com>"

ENV ROS_DISTRO humble
ENV USER_NAME developer

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q && \
    apt-get upgrade -yq && \
    apt-get install -yq \
            wget \
            curl \
            git \
            build-essential \
            vim \
            nano \
            sudo \
            lsb-release \
            locales \
            bash-completion \
            glmark2 \
            tzdata && \
    rm -rf /var/lib/apt/lists/*

# Add user account
RUN useradd -m -d /home/${USER_NAME} ${USER_NAME} \
        -p $(perl -e 'print crypt("${USER_NAME}", "robot"),"\n"') && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN locale-gen en_US.UTF-8
USER ${USER_NAME}
WORKDIR /home/${USER_NAME}
ENV HOME=/home/${USER_NAME}
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# Install ROS2 packages and setting
COPY ./ros2_setup_scripts_ubuntu.sh /home/developer/ros2_setup_scripts_ubuntu.sh
RUN sed -e 's/^\(CHOOSE_ROS_DISTRO=.*\)/#\1\nCHOOSE_ROS_DISTRO=$ROS_DISTRO/g' -i ros2_setup_scripts_ubuntu.sh
RUN ./ros2_setup_scripts_ubuntu.sh && \
    sudo rm -rf /var/lib/apt/lists/*
COPY ./ros_entrypoint.sh /

RUN sudo apt-get update -q && \
    sudo apt-get upgrade -yq && \
    sudo apt-get install -yq \
            python3.10-dev\
            python3-pip

# Install micro XRCE-DDS Agent
RUN git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git
WORKDIR /home/${USER_NAME}/Micro-XRCE-DDS-Agent
#RUN ls
RUN git checkout -b v1.3.0 refs/tags/v1.3.0
RUN mkdir build
WORKDIR /home/${USER_NAME}/Micro-XRCE-DDS-Agent/build
RUN cmake .. && \
    make && \
    sudo make install
RUN sudo ldconfig /usr/local/lib/

RUN pip3 install --upgrade pip
RUN pip3 install Pyserial

WORKDIR /home/${USER_NAME}
# Install ROS2 add-on packages and setting

RUN sudo apt-get update -q && \
    sudo apt-get upgrade -yq

# Add On
RUN sudo apt-get update -q &&\
    sudo apt-get install -yq \
		lsb-release \
		wget \
		gnupg

#RUN sudo apt-get update -q &&\
#    sudo apt-get install -yq \
#        ros-$ROS_DISTRO-gazebo-*

RUN sudo apt-get update -q &&\
    sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg &&\
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null

RUN sudo apt update -q && \
    sudo apt install -yq \
        ros-$ROS_DISTRO-simulation
        #gz-garden

RUN sudo apt update -q &&\
    sudo apt install -yq \
        ros-$ROS_DISTRO-cartographer \
        ros-$ROS_DISTRO-cartographer-ros \
        ros-$ROS_DISTRO-navigation2 \
        ros-$ROS_DISTRO-nav2-bringup

# End Add On

COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/bin/bash"]