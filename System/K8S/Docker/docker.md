#### docker

```shell
#Docker
#Ubuntu
#remove the old 
sudo apt-get remove docker docker-engine docker.io

#From ubuntu 14.04 , Some kernel modules has been removed .
#install AUFS
sudo apt-get update
sudo apt-get install \
linux-image-extra-$(uname -r) \
linux-image-extra-virtual

#apt
sudo apt-get update
sudo apt-get install \
apt-transport-https \
ca-certificates \
curl \
software-properties-common

#ali
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
"deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
$(lsb_release -cs) \
stable"
#
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
#install Docker CE
sudo apt-get update
sudo apt-get install docker-ce

#install by shell
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh --mirror Aliyun
#16.04 start the docker
sudo systemctl enable docker
sudo systemctl start docker
#14.04
sudo service docker start
#docker users
sudo groupadd docker
sudo usermod -aG docker $USER

#docker speed up
vi /etc/systemd/system/multi-user.target.wants/docker.service
ExecStart=/usr/bin/dockerd --registry-mirror=https://jxus37ad.mirror.aliyuncs.com
sudo systemctl daemon-reload
sudo systemctl restart docker

#use docker
docker pull --help
docker run -it --rm ubuntu:14.04 bash
#list images
docker images
#xuxuan image
docker images -f dangling=true
#delete the xuxuan image
docker rmi $(docker images -q -f dangling=true)

#mid image
docker images -a
docker images ubuntu
docker images ubuntu:16.04
docker images -f since=mongo:3.2
docker images -f label=com.example.version=0.1

#docker list ID
docker images -q
#docker list by format
docker images --format "{{.ID}}: {{.Repository}}"
docker images --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}"

#commit
docker commit \
--author "Tao Wang <twang2218@gmail.com>" \
--message "修改了默认网页" \
webserver \
nginx:v2
#
docker run --name web2 -d -p 81:80 nginx:v2

```

