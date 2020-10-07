#!/bin/bash

rosdep_list=./rosdep.list

mpi_workspace=~/projects/mpi_system_baxter/workspace/


# Installing ros

echo "########### installing ros #############"

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

sudo apt update

sudo apt install ros-melodic-desktop-full


# setup bash for ros
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc

source /opt/ros/melodic/setup.bash

# install rosdep
sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential

# init rosdep
sudo rosdep init
rosdep update



#### install eigen version 3.2

cd $mpi_workspace/src


wget http://bitbucket.org/eigen/eigen/get/3.2.10.tar.bz2

tar -xf 3.2.10.tar.bz2
cd eigen-eigen-b9cd8366d4e8
mkdir build
cd build
cmake ..
sudo make install

rm -r 3.2.10.tar*
rm -r eigen-eigen-b9cd8366d4e8

cd $mpi_workspace

rm -r devel
rm -r build
rm src/CMakeLists.txt



# install other libs

echo "########### installing other libs #############"
sudo apt-add-repository ppa:dartsim/ppa -y
#sudo apt-get update  # not necessary since Bionic

sudo apt-get install  libadmesh-dev libfftw3-dev libdart6-all-dev libgoogle-glog-dev

cd /tmp/

wget http://de.archive.ubuntu.com/ubuntu/pool/universe/e/einspline/libeinspline-dev_0.9.2-2_amd64.deb
wget http://de.archive.ubuntu.com/ubuntu/pool/universe/e/einspline/libeinspline0_0.9.2-2_amd64.deb

sudo dpkg -i libeinspline0_0.9.2-2_amd64.deb
sudo dpkg -i libeinspline-dev_0.9.2-2_amd64.deb





# install rosdeps for project

sudo apt install $(cat $rosdep_list )


