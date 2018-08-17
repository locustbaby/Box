####  DNS

##### 递归查询 迭代查询

```shell
域名服务器：bind
解析器：nslookup函数
#递归（需禁用）
解析器->本地域->根->12
#迭代
返回一个列表，包含可解析的服务器
```

##### Bind 搭建

```shell
www.imooc.com.
			根域（13组[a-m].root-server.net，使用Anycast技术）
		 一级域(一级(顶级)域名TLDs)
	二级域
#
顶（一）级域：分为 通用顶级域 国家代码顶级域名
二级
缓存域名服务器：根->顶->二->DNS条目，根据ttl值缓存
转发域名服务器：接受解析器来的请求，转发给上级域名服务器
# DNS类型
主DNS： 存放域名配置文件，权威的规定地址，主DNS知道全部它管辖范围的主机和子域名地址
辅助DNS： 作为主DNS的备份，承担一定负载，主知道辅助的存在，会向他们推送更新	
缓存DNS： 不存放配置文件当客户端请求缓存服务器来解析域名时，该服务器将首先检查其本地缓存。如果找不到匹配项便会询问主服务器。接着这条响应将被缓存起来。您也可以轻松地将自己的系统用作缓存服务器
权威DNS：负责授权域下的域名解析服务，由上级权威域名服务器使用NS记录进行授权
# DNS解析记录分类
A	域名->ip
CNAME 
MX 
NS
PTR	ip->域名
```

##### 配置

> 默认配置

```shell
# /etc/named.conf	默认配置
//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS
// server as a caching only nameserver (as a localhost DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//
// See the BIND Administrator's Reference Manual (ARM) for details about the
// configuration located in /usr/share/doc/bind-{version}/Bv9ARM.html

options {
	listen-on port 53 { 127.0.0.1; };
	listen-on-v6 port 53 { ::1; };
	directory 	"/var/named";
	dump-file 	"/var/named/data/cache_dump.db";
	statistics-file "/var/named/data/named_stats.txt";
	memstatistics-file "/var/named/data/named_mem_stats.txt";
	allow-query     { localhost; };

	/* 
	 - If you are building an AUTHORITATIVE DNS server, do NOT enable recursion.
	 - If you are building a RECURSIVE (caching) DNS server, you need to enable 
	   recursion. 
	 - If your recursive DNS server has a public IP address, you MUST enable access 
	   control to limit queries to your legitimate users. Failing to do so will
	   cause your server to become part of large scale DNS amplification 
	   attacks. Implementing BCP38 within your network would greatly
	   reduce such attack surface 
	*/
	recursion yes;

	dnssec-enable yes;
	dnssec-validation yes;

	/* Path to ISC DLV key */
	bindkeys-file "/etc/named.iscdlv.key";

	managed-keys-directory "/var/named/dynamic";

	pid-file "/run/named/named.pid";
	session-keyfile "/run/named/session.key";
};

logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};

zone "." IN {
	type hint;
	file "named.ca";
};

include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";

```

> 配置详解

```shell
acl extend
{
	192.168.2.0/24;
	127.0.0.0/8;
}
# 定义一个主DNS
zone    "likegeeks.com" {
type master;
file likegeeks.com.db
};
# 定义一个辅DNS
zone    "likegeeks.com" {
type slave;
masters IP Address list; ;
file likegeeks.com.db
};
# 定义 缓存服务器
zone      "." IN {
type hint;
file "root.hint";
};
zone      "." IN {
type hint;
file "root.hint";
};
zone      "." IN {
type hint;
file "root.hint";
};
zone      "localhost" IN {
type master;
file "localhost.db";
};
view "INNET" {      #智能DNS
	match-clients { internal; };
	recursion yes;	#递归
	zone "." IN {
                type hint;
                file "named.ca";
     };
};
```

##### DNS记录类型

```shell
SOA、NS、A、PTR、MX、CNAME和TXT
#	SOA： 起始授权机构记录

example.com.  86400  IN  SOA  ns1.example.com.  mail.example.com(
2017012604 ;serial
86400 ;refresh, seconds
7200 ;retry, seconds
3600000 ;expire, seconds
86400 ;minimum, seconds
)
#	NS: Name Server Records
@	IN NS	ns1	#指定ns1作为授权域 xxx的权威域名服务器
#	A & AAAA： Address Records

#	PTR： Pointer Records

#	MX: Mail Exchange Records

#	CNAME: Canonical Name Records
A IN CNAME B	#把b域名解析的ip作为a所用的ip
#	TXT
#	RP记录被创建为对host联系信息的显式容器：example.com. IN RP mail.example.com. example.com
#	DNS TTL
在/etc/named.conf文件的顶部，这里有一个$TTL条目。
该条目告诉BIND每个单独记录的TTL值（time to live，生存时间值）。
它是以秒为单位的数值，比如14,400秒（4个小时），因此DNS服务器最多缓存你的域文件4个小时，之后就会向你的DNS服务器重新查询。
你可以降低这个值，但是默认值通常是合理的。除非你知道你正在做什么。
#	捕获配置错误
当您写入域文件时，也许您忘记了一个句号或空格或其他任意错误。
你可以从日志诊断Linux DNS服务器错误。BIND服务通过/var/log/messages上的错误，可以使用tail命令来查看实时错误日志，须使用-f选项：$ tail -f /var /log/messages。
因此，当你编写域文件或修改/etc/named.config并重新启动服务时，显示错误之后，你可以从日志中轻松识别错误类型。
#	Host命令
#	Whois命令
#	Rndc命令
#	Linux DNS解析器
#	泛域名与泛解析
泛域名是指在一个域名根下，以 *.Domain.com的形式表示这个域名根所有未建立的子域名。 泛解析是把*.Domain.com的A记录解析到某个IP 地址上，通过访问任意的前缀.domain.com都能访问到你解析的站点上。 
#	域名绑定 
域名绑定是指将域名指向服务器IP的操作。 
#	域名转向 
域名转向又称为域名指向或域名转发，当用户地址栏中输入您的域名时，将会自动跳转到您所指定的另一个域名。一般是使用短的好记的域名转向复杂难记的域名。
```

##### DNS缓存服务器

```shell
# NSCD
yum -y install nscd
# /etc/nscd.conf
enable-cache	hosts	yes	#指定对DNS解析进行缓存
positive-time-to-live	hosts	3600	#对成功的缓存时间
negative-time-to-live	hosts	20	#对失败的缓存时间
suggested-size	hosts	211	#内部hash表大小
check-files	hosts	yes	#是否检查hosts文件变化
persistent	hosts	yes	#是否在重启NSCD进程后保留已缓存的条目
shared	hosts	yes	#指是否允许客户端直接查询nscd的内存镜像以获得结果
max-db-size	hosts	33554432	#DNS的缓存大小，单位字节
#验证
nsdc -g

```

##### Bind 负载均衡

```shell
多条A记录，简单负载均衡
```

##### 智能 DNS

```shell
#	view
acl "SDT" {
ip	#用户配置的DNS地址
}
view "SDT" {
match-clients{SD_CTC};
inlude "public.def";
zone "via.woyodns.com" {
type master;
file "zone/via.any.zone";
};
};
# view 优化
channel query_log {
	file "/var/query.log" versions 5 size 20m;
	severity info;
	print-time yes;
	pring-category yes;
};
category querties{
	query_log;
};
```

##### 监控

```shell
负载
进程
dig监控
```

##### CDN

```shell
用户->请求->本地DNS->权威DNS->view技术->上海电信CDN节点->缓存+代理的方式->源站
```

