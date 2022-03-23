## Based on: https://github.com/athackst/dockerfiles/blob/main/ros2/galactic.Dockerfile

FROM ubuntu:20.04 AS base

# ENV DEBIAN_FRONTEND=noninteractive

# Install language
RUN apt-get update && apt-get install -y locales \
  && locale-gen en_US.UTF-8 \
  && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*
ENV LANG en_US.UTF-8


# Install timezone
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y tzdata \
  && dpkg-reconfigure --frontend noninteractive tzdata \
  && rm -rf /var/lib/apt/lists/*

# Install ROS2
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    sudo \
  && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
  
  
# install ros-base
RUN apt-get update && apt-get install -y ros-galactic-ros-base \ 
    && rm -rf /var/lib/apt/lists/*


## install additional packages necessary
RUN apt-get update && apt-get install -y ros-galactic-demo-nodes-cpp \
    && rm -rf /var/lib/apt/lists/*


ENV ROS_DISTRO=galactic
ENV AMENT_PREFIX_PATH=/opt/ros/galactic
ENV COLCON_PREFIX_PATH=/opt/ros/galactic
ENV LD_LIBRARY_PATH=/opt/ros/galactic/lib
ENV PATH=/opt/ros/galactic/bin:$PATH
ENV PYTHONPATH=/opt/ros/galactic/lib/python3.8/site-packages
ENV ROS_PYTHON_VERSION=3
ENV ROS_VERSION=2
ENV DEBIAN_FRONTEND=

SHELL ["/bin/bash", "-c"]

COPY ros_entrypoint.sh /

ENTRYPOINT [ "/ros_entrypoint.sh" ]


# give bash command
CMD ["bash"]