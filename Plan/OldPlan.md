**11-13**

ELK zk 配置方式生效进度 配置 cli 控制台 平台

**11-19**

爬虫

所有中间件的理解，详细配置
nginx(apache) upstream(proxy pass) keepalive 
jboss ELK zk varnish redis 

**12-1**

[Jboss wiki](https://docs.jboss.org/author/display/WFLY9/Admin+Guide#)
python 巡检
bash -s Navicat for MySQL

update： python函数：sqlalchemy paramiko threading
在C、C++等语言中，三元表达式作为一种常用的表达式起到广泛的作用，但是在Python中却并没有这么方便直接的表达式。最近在帮公司做一个项目的时候，存在需要进行多条件查询的需求，如

user = User.query.filter(User.name.like("%"+搜索的内容+"%"), User.age.like("%"+搜索的内容+"%"))

这样做需要确保搜索的内容不得为空，且我们必须要根据搜索的内容来确定进行搜索的字段，这样子5个条件如果进行if else判断的话就有2^5，即​32种可能，这是相当麻烦的一件事情，不过我发现，filter函数如果搜索条件为空的时候，即“”的时候都能够正常的列出搜索的内容，因此便考虑可以使用三元表达式来实现判断如果表单传过来的值是控制的话搜索条件变为“”，不然的话就是User.name.like("%"+搜索的内容+"%")。

具体是这么写：

search 是存放搜索内容的变量​

user = ​User.query.filter(User.name.like("%"+search+"%") if search is not None else "", User.age.like("%"+search+"%") if search is not None else "")

这个样子，原本需要N多情况判断的模糊查询用一句话就可以了。

上传 下载 

**12-5**

scripts update => everyone UP DOWN  ssh的-o 
脚本：ftp down 包 配置 if没有配置 up down 配置 => server
















### Plan

##### Python

```python
Django
```

##### Go

```go

```

##### Linux

```shell

```

##### 运维

```shell
# 中间件
Nginx/Apache	nginx配置手册
Zookeeper	zookeeper分布式协调
Tomcat/Jboss	tomcat权威指南第二版 tomcat8权威
Redis/MongoDB	redis运维和开发
ELK		官方文档
RabbitMQ/Websphere MQ	rabbitmq
Kafka	kafka权威指南
zabbix/promethus
Ansible/Saltstack
Docker+k8s+swarm
DNS/CDN/bind
Mycat/PostgreSQL
mesos marathon ceph
druid
```

##### 大数据

```shell
Hadoop/Hive	hadoop权威指南
Storm/Spark	spark快速数据分析
lambda
MPP
```


##### com in plan

```shell
蚂蚁金服
阿里云
51信用卡管家 #待定
钉钉
网易云音乐
同盾科技
airwallex #空中云汇
第四范式
蜻蜓FM/喜马拉雅
七牛云/Ucloud
极链科技video++
华尔街见闻 sre 15-22
ele 数据安全专家 3-5 20-35
沪江 3-5 20-30
即刻 3-5 15-30
海康威视 
```

# SA_list
1. 系统基础
 + 操作系统原理
 + 分布式
 + ceph
 + 负载均衡

2. 算法基础
 + 时间空间复杂度
 + 数据结构和编码 json xml
 + 单线程架构
 + I/O多路复用 非阻塞IO epoll 线程切换、竞态 
 + 与或非 并交补
 + HyperLogLog

3. Linux基础
+ 2>&1
+ lsof
+ | xargs -exec >重定向 ！\ && || 
+ 正则
+ RHEL 7 by红帽
+ curl
+ ssh
+ ftp
+ top
+ rsync
+ 查机器信息
+ 系统 cpu 内存 硬盘 ->shell
+ 杀进程 kill pkill killall 信号：hup -9  ->说明文档
+ ssh config ssh远程执行 scp传输 
+ 文字处理 三剑客 grep awk sed cut 
+ find xargs expect
+ vi 快捷
+ log level
+ 驱动安装 网卡 显卡
+ ubuntu 图形界面安装 + 链接
+ Git + Hexo + Material
+ strace tcpdump sysstat
+ pgrep ps -ef -aux
+ 用户 用户组
+ 返回码 400 500
+ git操作
+ C

4. Code
+ git skills
+ 汇编
+ 伪代码
+ C  C++
+ python Django
+ Go
+ lua
+ MVC


5. 中间件
+ 数据库 实例 索引
+ Apache
+ Nginx
+ Jboss
+ WAS
+ Tomcat
+ MQ
+ Mysql
+ redis
+ varnish
+ docker
+ saltstack
+ keepalive
+ ELK ES Logstash Kinaba
+ zk 
+ kafka
+ Hive
+ Spark
+jvm

6. IaaS
+ openstack
+ KVM
+ Docker

7. Language
+ TED x
+



# Plan in 3 years
## Language:Markdown
---
###### C C++ System algorithm
---
1. Python : 9h
   - Regular expression： *re* : 1.5h
   - Tornado & Django
      - WEB ：H5 CSS : 10h JS : 12h
      - BootStrap : 10h
      - Jquery : 2.5h
      - 
   - [Crawler](http://mp.weixin.qq.com/s/i_LRetBNXLHZWDipgGaJsg)
      + Spider : 1.5h & 2.5h
         - Urllib
         - BeautifulSoup 
      + Scrapy
   - Request : 3h
   - Collection : 2h
   - File : 2h
   - Exception : 1.5h
   - Auto ：6h
      + Ansible
      + Saltstack
      + Puppet
      + Chef
   - 数据分析 & 机器学习
2. Operation 
   - Redis : 3h
        + sentienl
        + shardname
        + Jedis
   - Nginx
   - Apache
   - Tomcat
   - Zabbix
   - Mysql
   - TCP/IP
   - ELK & kafka
   - DNS & [bind](https://mp.weixin.qq.com/s/uKfg5ATddOldRZ2C0j7FmA)
3. [CI/CD](https://www.mindtheproduct.com/2016/02/what-the-hell-are-ci-cd-and-devops-a-cheatsheet-for-the-rest-of-us/ )
4. Docker & K8s
5. HDFS 多线程 异步 高性能设计 性能调优



#### Dev

> Ddevops Tools

```shell
#	Ansible

#	gitlab

#	jenkins
```

> PY并发

```shell
O（1）复杂度排序

join

进程

协程

threads

multiprocess

异步 asynio

gevent

twisted

基于py RPC

```

> PY自动化运维

```shell
# 网易公开课

# Jenkins+Ansible+Gitlab自动化部署

# python+Django+Ansible+playbook自动化运维

# 红绿 实践 核心

```

> Go

```shell
# Google资深工程师深度讲解Go语言

# Gopl

# Go web

```

> Bootstrap

```shell

```

> Vue

```shell
https://cn.vuejs.org/
```

> 算法数据结构

```shell
C语言基础
C语言描述
C++
网易公开课 -> （浙大）数据结构
LeetCode
```

> PY爬虫

```shell
urllib

requests

BeautifulSoap

Xpath

Scrapy

selenium

phamtjs


# 聚焦python分布式爬虫必学框架Scrapy打造搜索引擎
```

> PY自动化测试

```shell
# selenium + phantomjs
```

##### Ops

> 协议

```shell
#	HTTTP & HTTPS
https 握手
#	TCP

#	DNS

#	CDN
Squid Varnish
```

> 中间件

```shell
#	JVM
Jboss Tomcat
#	web
PHP Nginx Apache
#	Lvs+keepalive

#	Pxe+Keepalived

#	ELK
ES
#	ZooKeeper

#	kafka

#	mq
avtivemq	rabbitmq	

```

> SQL

```shell
#	Nosql
Redis
#	
mysql oracle pgsql
#

```

> 网络

```shell

```