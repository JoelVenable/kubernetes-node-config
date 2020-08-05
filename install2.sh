. /etc/os-release

modprobe overlay
modprobe br_netfilter

cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system

add-apt-repository ppa:projectatomic/ppa -y && apt update

cat > /etc/apt/sources.list.d/projectatomics.list <<EOF
deb http://ppa.launchpad.net/projectatomic/ppa/ubuntu bionic main
deb-src http://ppa.launchpad.net/projectatomic/ppa/ubuntu bionic main
EOF

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8BECF1637AD8C79D

apt update

apt install -y cri-o-1.18

