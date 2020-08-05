#!/bin/bash


apt install -y python3-pip \
   apt-transport-https \
   ca-certificates \
   curl \
   gnupg-agent \
   gnupg2 \
   software-properties-common


#  Add docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

#  Add kubernetes GPG key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

#  Add docker repository
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" \
    | tee -a /etc/apt/sources.list.d/kubernetes.list


apt update && apt upgrade

apt install -y docker-ce docker-ce-cli containerd.io kubectl kubelet kubeadm
apt-mark hold kubelet kubeadm kubectl


ufw enable
ufw allow ssh
ufw allow 6443  #  Kubernetes API server
ufw allow 2379
ufw allow 2380
ufw allow 10250
ufw allow 10251
ufw allow 10252
ufw allow 30000:32767/tcp


sed -i 's/ENABLED=no/ENABLED=yes/' /etc/ufw/ufw.conf



#  Extend the filesystem to 100% of the disk
lvextend -l 100%FREE /dev/ubuntu-vg/ubuntu-lv

resize2fs /dev/ubuntu-vg/ubuntu-lv

apt install -y quota

mkdir /k8s



#  disable swap

swapoff -a; sed -i '/swap/d' /etc/fstab


#  Copy docker daemon config
cp daemon.json /etc/docker

mkdir -p /etc/systemd/system/docker.service.d

systemctl daemon-reload
systemctl restart docker
systemctl enable docker

