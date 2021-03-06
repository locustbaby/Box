#!/bin/bash

#env
Eshome=/opt/eshome
ES_url=ftp://y@192.168.241.12/17liucf/ES
software=`curl -l $ES_url/package/`
soft_dir=`$software |awk -F '.zip' '{print $1}'`

function get_conf()
{
	#read -p "Pls "
	wget -x ./download/conf/ -r -nd -m $ES_url -P ./download/conf/
	wget -x ./download/package/ -r -nd -m $ES_url -P ./download/package/
	#wget ftp://17liucf/ES/package/*
}

#modify the sysctl.conf
function sys_modify()
{
	ssh root@$ip "cd /etc/ && cp ./sysctl.conf ./sysctl.conf.bak && cat>>sysctl.conf<<EOF
net.ipv4.tcp_timestamps=0
net.ipv4.tcp_tw_reuse=1
net.ipv4.tcp_tw_recycle=1
net.ipv4.tcp_fin_timeout=30
net.ipv4.tcp_keepalive_time=300
net.ipv4.tcp_max_syn_backlog=8192
net.ipv4.ip_local_port_range = 5000    65000
net.core.rmem_max=16777216
net.core.wmem_max=16777216
net.ipv4.tcp_rmem=4096 87380 16777216
net.ipv4.tcp_wmem=4096 65536 16777216
net.core.netdev_max_backlog=3000
EOF
"
        ssh root@$ip "cd /etc/security/limits.d/ && cp ./90-nproc.conf ./90-nproc.conf.bak && cat>>90-nproc.conf<<EOF
* soft nofile 51200
* hard nofile 51200
* soft nproc 11000
* hard nproc 11000
EOF
"
ssh root@$ip "sysctl -p"
}

#download the package and upload the script
function Esinstall()
{
	ssh root@$ip "mkdir $Eshome && cd $Eshome && wget -r -nd -m $ES_url/package/ && unzip ./$software && rm ./$software"
}
function up_file()
{
	#Down the conf by wget
	#ssh root@$ip "cd $Eshome/$soft_dir && wget -c $ES_url/config/"
	#Up the conf by scp
	scp ./download/conf/* root@$ip:$Eshome/$soft_dir/config/
} 

function chage()
{
	ssh root@$ip "chown -R opsuser:opsuser $EShome && chmod +x $EShome/$soft_dir/bin/*.sh && chmod +x $EShome/$soft_dir/bin/elasticsearch"
}

function launch()
{
	ssh opsuser@$ip "$EShome/$soft_dir/bin/elasticsearch -p .espidfile -d"
}

for ip in `cat ./ip.conf`
do
	get_conf
	sys_modify
	Esinstall
	up_file
	change
	launch
done




ESinstall

#!/bin/bash

#
#standalone_log=/opt/wildfly/standalone/log/
#standalone_conf=/opt/wildfly/standalone/configuration/
#domain_log=/opt/jboss/domain/servers/*server*/
#domain_conf=

#choose the ftpserver
function pick_ftp()
{
read -p $'0, 192.168.241.12\x0a1, 10.24.75.166 \x0aPls select a FTP :' id
if [ $id ];then
	ftpip=10.24.75.166
	echo "ftp 10.24.75.166"
else 
	ftpip=192.168.241.12
fi
}

#Input the filename
function Input()
{
read -p "Pls Input the File or Type :" profile
#return $profile
}

#
function Get_file()
{
	ssh jbossuser@$ip "
for conf in `find /opt/ -name $profile 2>/dev/null`
do
	server_id=`$conf |awk -F '/' '{print $6}'`
	ftp -inv 192.168.241.12 <<!
user 
bin
prom
put $conf $ip"_"$server_id
!
done
"
	#scp jbossuser@$ip:$conf_dir ./
}

#Upload from local
function Upload()
{
ftp -inv $ftpip <<!
user 
bin
cd 17liucf/cache/
put $profile
!
}

if [ $profile == standalone.xml ];then
	
elif

if


get——file

