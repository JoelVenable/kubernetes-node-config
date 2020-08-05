

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
