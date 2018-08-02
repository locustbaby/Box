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
			nat		   FORWARD		    -s				  DROP
		    		   OUTPUT			-d				  REJECT
		    		   PREROUTING		--sport			   DNAT
		    		   POSTROUTING		--dports		   SNAT
		    		   				   -m tcp
		    		   				   	  state
		    		   				   	  multiport
```

##### nmap

```shell

```

##### hydra

```shell

```

##### rsyslog

```shell

```

##### coredump

```shell
http://www.111cn.net/sys/linux/67291.htm
```

