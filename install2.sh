. /etc/os-release



sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/testing:/cri-o:/1.18/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:testing:cri-o:1.18.list"
wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:testing:cri-o:1.18/xUbuntu_18.04/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update
sudo apt-get install cri-o

systemctl daemon-reload
systemctl start crio