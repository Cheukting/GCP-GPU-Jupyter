#!/bin/bash
echo "Checking for CUDA and installing."
# Check for CUDA and try to install.
if ! dpkg-query -W cuda-8-0; then
  # The 16.04 installer works with 16.10.
  curl -O https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
  dpkg -i ./cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
  apt-get update
  apt-get install cuda-8-0 -y
fi
# Enable persistence mode
nvidia-smi -pm 1

#export LD_LIBRARY_PATH=/usr/local/cuda/lib64/

# Install docker
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh

# Install nvidia-container-runtime
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  tee /etc/apt/sources.list.d/nvidia-docker.list
apt-get update

# Install nvidia-docker2 and reload the Docker daemon configuration
apt-get install -y nvidia-docker2
pkill -SIGHUP dockerd

# Pull and run docker image
docker pull cheukting/coursera-aml-docker
docker run --runtime=nvidia -d -p 80:8080 --name coursera-aml-1 cheukting/coursera-aml-docker