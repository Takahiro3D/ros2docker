FROM amd64/ubuntu:focal
LABEL maintainer="Dorebom<dorebom.b@gmail.com>"

ENV ROS_DISTRO foxy
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
            sudo \
            lsb-release \
            locales \
            bash-completion \
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

# Install ROS2
COPY ./ros2_setup_scripts_ubuntu.sh /home/developer/ros2_setup_scripts_ubuntu.sh
RUN sed -e 's/^\(CHOOSE_ROS_DISTRO=.*\)/#\1\nCHOOSE_ROS_DISTRO=$ROS_DISTRO/g' -i ros2_setup_scripts_ubuntu.sh
RUN ./ros2_setup_scripts_ubuntu.sh && \
    sudo rm -rf /var/lib/apt/lists/*
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]