#!/bin/bash

Zk_url=ftp://deploy:extdeploy@192.168.241.12/17liucf/Zk
software=`curl -l $Zk_url/package/`
soft_dir=`echo $software|awk -F '.tar' '{print $1}'`
i=1
#echo $Zk_url
#echo $software
#echo $soft_dir

function connect()
{
	ssh -o ConnectTimeout=3 -o ConnectionAttempts=3 -o PasswordAuthentication=no -o StrictHostKeyChecking=no root@$ip "--------------ES By Nobody------------------"
}
function Zk_down()
{
	#ssh root@$ip "cd /opt/ && rm zook* -rf && rm zkdata* -rf "
	ssh root@$ip "cd /opt/ && wget -r -nd -m $Zk_url/package/ && tar zxf ./$software && rm ./$software -f && mkdir -p ./zkdata/$soft_dir/data ./zkdatalog/$soft_dir/datalog"
}
function Zk_conf()
{
	#New
	ssh root@$ip "
cat>>/opt/$soft_dir/conf/zoo.cfg<<!
server.1=10.245.68.82:2888:3888
server.2=10.245.68.83:2888:3888
server.3=10.245.68.84:2888:3888
!
"
#ssh root@$ip "cd /opt/$soft_dir/conf/ && wget -c $Zk_url/conf/"
}
function Zk_start()
{
	ssh root@$ip "chown -R opsuser:opsuser /opt/zook* /opt/zkdata*"
    ssh opsuser@$ip "/opt/$soft_dir/bin/zkServer.sh stop;/opt/$soft_dir/bin/zkServer.sh start"
}
for ip in `cat ip.conf`
do
	connect || echo "root Failure !"  && exit 1
	Zk_down 
	ssh root@$ip "echo $i >/opt/zkdata/$soft_dir/data/myid" && let i+=1 && Zk_conf
	Zk_start
done
