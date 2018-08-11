####  DNS



##### Bind 搭建

```shell
www.imooc.com.
			根域（13个[a-m].root-server.net）
		 一级域(一级(顶级)域名TLDs)
	二级域
# DNS类型
主DNS： 存放域名配置文件，权威的规定地址，主DNS知道全部它管辖范围的主机和子域名地址
辅助DNS： 作为主DNS的备份，承担一定负载，主知道辅助的存在，会向他们推送更新	
缓存DNS： 不存放配置文件当客户端请求缓存服务器来解析域名时，该服务器将首先检查其本地缓存。如果找不到匹配项便会询问主服务器。接着这条响应将被缓存起来。您也可以轻松地将自己的系统用作缓存服务器
# DNS解析记录分类
A记录	域名->ip
CNAME 
MX记录 
NS记录
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
```

##### DNS记录类型

```shell


SOA、NS、A、PTR、MX、CNAME和TXT
SOA： 起始授权机构记录
e.g. ：
example.com.  86400  IN  SOA  ns1.example.com.  mail.example.com(
2017012604 ;serial
86400 ;refresh, seconds
7200 ;retry, seconds
3600000 ;expire, seconds
86400 ;minimum, seconds
)
NS: Name Server Records
```

##### Bind 负载均衡

##### 智能 DNS