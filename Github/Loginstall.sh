#!/bin/bash

#env
Log_url=ftp://deploy:extdeploy@192.168.241.12/17liucf/Logstash
software=`curl -l $Log_url/package/`
soft_dir=`$software |awk -F '.zip' '{print $1}'`
Log_conf=`curl -l $Log_url/conf/`
Java_url=ftp://deploy:extdeploy@192.168.241.12/17liucf/Java
Java_tar=`curl -l $Java_url`

function connect()
{
	ssh -o ConnectTimeout=3 -o ConnectionAttempts=3 -o PasswordAuthentication=no -o StrictHostKeyChecking=no root@$ip "--------------Logstash By Nobody------------------"
}

function java_update()
{
	ssh opsuser@$ip "
cat>>./.bashrc<<!
JAVA_HOME=/usr/local/java/jdk1.7.0_75
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export JAVA_HOME
export PATH
export CLASSPATH
!
"
	ssh root@$ip "cd /usr/local && wget -x ./java/ -r -nd -m $Java_url -P ./java/ && cd ./java/ && tar zxf $Java_tar && rm -f ./$Java_tar && source /home/opsuser/.bashrc && java -version"	
}

function Log_down()
{
	ssh root@$ip "cd /opt/ && wget -r -nd -m $Log_url/package && unzip ./$software && rm -f ./$software"
}

function Bak_conf()
{
	#Description of configuration changesj: None
	#ssh root@$ip "ps -ef | grep logstash | grep -v grep |awk -F '/' '{print $NF}'|awk '{print $1}'" 
	ssh root@$ip "cd /opt/$soft_dir/conf/ && ll -d ./$Log_conf && cp ./$Log_conf ./$Log_conf.`date +%m-%d` ; wget -c $Logurl/conf/"
}

function perm_chage()
{
	ssh root@$ip "chown -R opsuser:opsuser /opt/$software/ && chmod +x /opt/$software/bin/* /opt/logstash-2.3.4/vendor/jruby/bin/jruby /opt/logstash-2.3.4/vendor/jruby/bin/jruby"
}

function lanuch()
{
	#??stop
	#ssh opsuser@$ip "pkill -9 java"
	ssh opsuser@$ip "cd /opt/$software && nohup bin/logstash -f /opt/$software/conf/$Log_conf -w 8 -b 600 &"
}
function Log_install()
{
for ip in `cat ip.conf`
do
	connect || echo "root Failure !"  && exit 1
	java_update && Log_down && Bak_conf && perm_chage && lanuch
	
done
}

#if [ 1$1 == 1 ];then
#	Log_down
#else
#	Log_conf=$1
#	Log_down
#fi
if [ 1$Log_conf == 1 ];then
	echo "-------------------No conf------------------" && exit 1
else
	Log_install
fi