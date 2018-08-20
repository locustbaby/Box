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

