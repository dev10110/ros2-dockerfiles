# ros2-docker

Simple docker file, which basically follows installation steps of ros-galactic to produce the docker image. 

## Usage
git clone  this repo
run `docker build -t ros2 .`
this will create a docker image, tagged with `ros2`

now you can run `docker run -it --rm --net=host --pid=host ros2`

This will launch the container, and provide the ubuntu 20.04 environment with ros2-galactic-base installed. 

It only sources `/opt/ros/galactic/setup.bash`, you will need to source your repo. 