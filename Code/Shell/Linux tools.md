##### [Linux Tools Quick Tutorial](https://linuxtools-rst.readthedocs.io/zh_CN/latest/index.html)



##### iptables

```shell
ab : web性能测试工具
#	ab -n 1000000 -c 40 http://ip
#	iptables -I INPUT -p tcp --dport 80 -s 10.10.163.232 -m connlimit --connlimit-above 10 -j REJECT
```

> Netfilter

```shell
# 4 Table : filter, nat, mangle, raw
mangle:	修改数据包，改变包头中内容(TTL,TOS,MARK)
nat: 地址转发
filter：访问控制，规则匹配

# Hook point(5 chain)(挂载点)
	PRE_ROUTING, INPUT, OUTPUT, FORWARD, POST_ROUTING
# iptables 规则组成
数据包访问控制：ACCEPT，DROP， REJECT
数据包改写： SNAT， DNAT
信息记录：LOG
		table	 command			Parmeter & Xmatch	target
iptables -t	filter	-A	INPUT			-p tcp			-j ACCEPT
			nat	   -I   FORWARD		    -s				  DROP
		    	   -D   OUTPUT			-d				  REJECT
		    		   PREROUTING		--sport			   DNAT
		    		   POSTROUTING		--dports		   SNAT
		    		   				   -m tcp
		    		   				   	  state
		    		   				   	  multiport
```

> 实践

```shell
iptables -FXZ
iptables -L # list	(先后顺序)
iptables -F # flushall
iptables -I INPUT -p tcp --dport 80 -j ACCEPT # -I添加到最前
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -j REJECT	# -A 往后添加
# 外无法访问本机，本机也无法访问外，无法访问本地

iptables -I INPUT -i lo -j ACCEPT # 可以与本地通信
iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # 允许本地访问外网

```

##### tcp_wrappers

```shell
/etc/hosts.allow > /etc/hosts.deny (先后)
service:host(s) [:action]
ALL:ALL EXCEPT ip
```

##### perf

```shell
https://www.ibm.com/developerworks/cn/linux/l-cn-perf1/
http://www.ibm.com/developerworks/cn/linux/l-cn-perf2/
https://perf.wiki.kernel.org/index.php/Tutorial
https://mp.weixin.qq.com/s/T0wSAd9IAtB9BoaT7qPeIg
```

##### strace

```shell

```

##### gdb

```shell
https://www.linuxblogs.cn/articles/15041200.html
```

##### sshd

```shell
sshd -t -f /etc/ssh/sshd_config
# ssh 脚本常用免密
-o stricthostkeychecking=no -o ConnectTimeout=3 -o ConnectionAttempts=3 -o PasswordAuthentication=no 
ssh -v host # 查看被搁置原因
```

##### pam认证

```shel

```

##### chattr & lsattr

```shell
chattr -RV [mode:+ - = a c i s u]
lsattr [-aslRvV]
```

##### /etc/fstab

```shell
LABEL=/tmp /tmp ext3 rw,nosuid,noexec,nodev 0 0 #不允许任何suid程序，不能运行任何脚本，不存在设备文件
```

##### nmap

```shell
nmap -sS -p 0-1000 10.10.163.233
```

##### hydra

```shell

```

##### rsyslog

```shell

```

##### rsync

```shel
rsync详解
https://blog.csdn.net/qq_21419995/article/details/80458379
```

##### coredump

```shell
http://www.111cn.net/sys/linux/67291.htm
```

##### iftop

```shell
yum install libpcap libpcap-devel ncurses ncurses-devel
yum install flex byacc	#编译安装 or EPEL安装
```

##### 网络监控和分析工具

```shell
Ntop MRTG Ntopng iperf 
```

##### perf

```shell

```

##### sysstat

```shell
#	https://www.cnblogs.com/digdeep/p/4878138.html
```

##### stat

```shell

```

##### Snmp

> SNMP 简介

```shell
SNMP采用UDP 161端口接收和发送请求，162端口接收trap，执行SNMP的设备缺省都必须采用这些端口。SNMP消息全部通过UDP端口161接收，只有Trap信息采用UDP端口162。
SNMP v1是SNMP协议的最初版本，不过依然是众多厂家实现SNMP基本方式。 
SNMP v2通常被指是基于community的SNMP V2。Community实质上就是密码。
SNMP v3 是最新版本的SNMP。它对网络管理最大的贡献在于其安全性。增加了对认证和密文传输的支持。
SNMP为管理员提供了一个网管平台(NMS)，又称为【管理站】，负责网管命令的发出、数据存储、及数据分析。【被】监管的设备上运行一个SNMP代理(Agent))，代理实现设备与管理站的SNMP通信。
```

##### rpm

```shell
#	安装rpm包
方法一：
rpm -i your-package.src.rpm
cd /usr/src/redhat/SPECS
rpmbuild -bp your-package.specs             #一个和你的软件包同名的specs文件
cd /usr/src/redhat/BUILD/your-package/      #一个和你的软件包同名的目录
./configure                                 #这一步和编译普通的源码软件一样，可以加上参数
make
make install

方法二：
rpm -i you-package.src.rpm
cd /usr/src/redhat/SPECS
前两步和方法一相同
rpmbuild -bb your-package.specs       #一个和你的软件包同名的specs文件
这时在/usr/src/redhat/RPM/i386/（根据具体包的不同，也可能是i686,noarch等等）在这个目录下，有一个新的rpm包，这个是编译好的二进制文件。
执行rpm -i new-package.rpm即可安装完成。

rpm -qa
rpm -ivh	#--force
rpm -e
rpm2cpio xxx.rpm | cpio -idmv
rpm -qf `which 程序名`    #返回软件包的全名
rpm -qif `which 程序名`   #返回软件包的有关信息
rpm -qlf `which 程序名`   #返回软件包的文件列表
```

##### which whereis locate find

```shell
which	#PATH
whereis	#文件索引
locate	#updatedb (匹配)
find	#直接搜硬盘
```

##### dd

```shell
# 打满cpu
for i in `seq 1 $(cat /proc/cpuinfo |grep "physical id" |wc -l)`; do dd if=/dev/zero of=/dev/null & done	
```

##### fork炸弹

```shell
:() { :|:& };:
# https://www.jianshu.com/p/9e508888e2d9
```

##### 锁内存

```shell
#!/bin/bash  
mkdir /tmp/memory  
mount -t tmpfs -o size=1024M tmpfs /tmp/memory  
dd if=/dev/zero of=/tmp/memory/block  
sleep 3600  
rm /tmp/memory/block  
umount /tmp/memory  
rmdir /tmp/memory  
```

##### xxd

```shell

```

##### urlencode

```shell
function urlencode() {
    local length="${#1}"
    for ((i = 0; i < length; i++)); do
        local c="${1:i:1}"
        case $c in
        [a-zA-Z0-9.~_-]) printf "$c" ;;
        *) printf "$c" | xxd -p -c1 | while read x; do printf "%%%s" "$x"; done ;;
        esac
    done
}
```


##### sar

```shell
#	https://www.cnblogs.com/howhy/p/6396437.html
sar -u 1 3	#cpu 1s 3次
sar -p 1 3 #每个CPU
sar -q #查看平均负载：
-o #output 二进制	#-f 读取
sar -r #内存
sar -W #查看系统swap分区的统计信息
sar -b #查看I/O和传递速率的统计信息
sar -d #磁盘使用详情统计
sar -v #进程、inode、文件和锁表状态
sar -n #统计网络信息
#sar -n选项使用6个不同的开关：DEV，EDEV，NFS，NFSD，SOCK，IP，EIP，ICMP，EICMP，TCP，ETCP，UDP，SOCK6，IP6，EIP6，ICMP6，EICMP6和UDP6 ，DEV显示网络接口信息，EDEV显示关于网络错误的统计数据，NFS统计活动的NFS客户端的信息，NFSD统计NFS服务器的信息，SOCK显示套接字信息，ALL显示所有5个开关。它们可以单独或者一起使用。
```

##### perl

```shell
perl -e 'for(<*>){((stat)[9]<(unlink))}' 
# 删除对比
# https://mp.weixin.qq.com/s/dsguRKkiWAZb9mGqZg8tlA
```

