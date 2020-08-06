

# Bootstrap Kubernetes nodes

Insert the Ubuntu 18.04 server ISO.  During installation, select the following options:

1.  Entire disk, using LVM
2.  Hostname: k8s-node_ (_ is the node number)
3.  Username: `joel`
4.  Password: *my easy to remember password*
5.  Network: 
    - IP address: 10.0.55.10x (match the node number)
    - Gateway: 10.0.55.1
    - Nameservers: 10.0.55.1
6.  Enable SSH
7.  Select `Docker` on the postinstall additions.


## After installation

```
chmod +x install.sh
sudo ./install.sh
```


## On master node

```
kubeadm init --pod-network-cidr=10.0.88.0/24
mkdir -p ~/.kube
sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config
sudo chown $(id -u): $(id -g) ~/.kube/config
```

Install Calico
```
kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml

wget https://docs.projectcalico.org/manifests/custom-resources.yaml

sed -i 's|192.168.0.0/16|10.0.88.0/24|' custom-resources.yaml

kubectl create -f custom-resources.yaml

kubectl taint nodes --all node-role.kubernetes.io/master-
```


## On worker nodes

Copy `kubeadm join` command from output of `kubeadm init` on master node.