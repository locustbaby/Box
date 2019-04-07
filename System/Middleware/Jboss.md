# [Jboss](https://docs.jboss.org/author/display/WFLY9/Admin+Guide)
概述
一、安装部署
	1.1系统信息
	1.2安装准备
		1.2.1准备安装包
		1.2.2用户
		参数优化
		DNS
		修改hosts
	1.3开始安装
		Jdk
		Jboss安装
			解压即可，无需安装
目录结构
		环境变量
	1.4启动
		配置cli配置文件   待研究
		备份所有初始配置文件
		Standalone
			原理
			启动
		Domain
			原理
			启动
		启动脚本
二、控制台用户和角色分配
	用户添加
		控制台
		Add-user.sh
		集群成员添加联合
	Server配置
	jvm参数
		-Xms：设置jvm内存的初始大小
        -Xmx：设置jvm内存的最大值
        -Xmn：设置新域的大小（这个似乎只对 jdk1.4来说是有效的，后来就废弃了）
        -Xss：设置每个线程的堆栈大小(也就是说,在相同物理内存下，减小这个值能生成更多的线程)
        -XX：NewRatio :设置新域与旧域之比，如-XX：NewRatio = 4就表示新域与旧域之比为1：4
        -XX:NewSize：设置新域的初始值
        -XX:MaxNewSize ：设置新域的最大值
        -XX:PermSize：设置永久域的初始值
        -XX:MaxPermSize：设置永久域的最大值
        -XX:SurvivorRatio=n:设置新域中Eden区与两个Survivor区的比值。（Eden区主要是用来存放新生的对象，而两个 Survivor区则用来存放每次垃圾回收后存活下来的对象）
	日志轮询 .xml
	线程池
	MQ
	MQ连接工厂
	数据源配置 mysql sqlserver	validation
	LDAP
	与apache联合 mod_cluster
	应用部署
	Q&A
	



#####	mysql参数

```shell
idle-timeout-minutes	undefined	10	minite	nonNegativeInteger	The idle-timeout-minutes elements indicates the maximum time in minutes a connection may be idle before being closed. The actual maximum time depends also on the IdleRemover scan time, which is 1/2 the smallest idle-timeout-minutes of any pool.	common
validate-on-match	undefined	false		boolean	The validate-on-match element indicates whether or not connection level validation should be done when a connection factory attempts to match a managed connection for a given set. This is typically exclusive to the use of background validation	common
background-validation	undefined	true		boolean	An element to specify that connections should be validated on a background thread versus being validated prior to use	common
max-pool-size	undefined			nonNegativeInteger	The max-pool-size element indicates the maximum number of connections for a pool. No more connections will be created in each sub-pool.This defaults to 20.	common
min-pool-size	undefined			nonNegativeInteger	The min-pool-size element indicates the minimum number of connections a pool should hold. These are not created until a Subject is known from a request for a connection. This default to 0. Ex: 1	common
pool-use-strict-min	false	true		boolean	Define if the min-pool-size should be considered a strictly. Default false	common
pool-prefill	false	true		boolean	Whether to attempt to prefill the connection pool. Empty element denotes a true value. e.g. true. Default is false	common
use-java-context	true			boolean	Setting this to false will bind the DataSource into global JNDI Ex: use-java-context="true"	common
blocking-timeout-wait-millis	undefined	500	millisecond	nonNegativeInteger	The blocking-timeout-millis element indicates the maximum time in milliseconds to block while waiting for a connection before throwing an exception. Note that this blocks only while waiting for a permit for a connection, and will never throw an exception	common
flush-strategy	undefined	FailingConnectionOnly		token	Specifies how the pool should be flush in case of an error. Valid values are: FailingConnectionOnly (default), InvalidIdleConnections, IdleConnections, Gracefully, EntirePool, AllInvalidIdleConnections, AllIdleConnections, AllGracefully, AllConnections	common
transaction-isolation	undefined	TRANSACTION_READ_COMMITTED		transaction-isolationType	Set java.sql.Connection transaction isolation level to use. The constants defined by transaction-isolation-values are the possible transaction isolation levels and include: TRANSACTION_READ_UNCOMMITTED TRANSACTION_READ_COMMITTED TRANSACTION_REPEATABLE_READ TRANSACTION_SERIALIZABLE TRANSACTION_NONE	common
check-valid-connection-sql		select 1				mysql
driver_version		5.1.45				mysql
drive_jar		mysql-connector-java-5.1.45-bin.jar sndp-connector-java-5.1.45.jar				mysql
module_xml						mysql
connection-url		jdbc:mysql://${mysql_host}:3306/${dbname}?characterEncoding=utf8&generateSimpleParameterMetadata=true&useServerPrepStmts=true&cachePrepStmts=true				mysql
connection-properties		connectTimeout=5000 useSSL=false pool-use-strict-min设置为true，pool-prefill设置为true validate-on-match设置为false，background-validation设置为true
```

##### sysctl.conf

```shell
# Kernel sysctl configuration file for Red Hat Linux
#
# For binary values, 0 is disabled, 1 is enabled.  See sysctl(8) and
# sysctl.conf(5) for more details.

# Controls IP packet forwarding
net.ipv4.ip_forward = 0

# Controls source route verification
net.ipv4.conf.default.rp_filter = 1

# Do not accept source routing
net.ipv4.conf.default.accept_source_route = 0

# Controls the System Request debugging functionality of the kernel
kernel.sysrq = 0

# Controls whether core dumps will append the PID to the core filename.
# Useful for debugging multi-threaded applications.
kernel.core_uses_pid = 1

# Controls the use of TCP syncookies
net.ipv4.tcp_syncookies = 1

# Disable netfilter on bridges.
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0

# Controls the default maxmimum size of a mesage queue
kernel.msgmnb = 65536

# Controls the maximum size of a message, in bytes
kernel.msgmax = 65536

# Controls the maximum shared segment size, in bytes
kernel.shmmax = 68719476736

# Controls the maximum number of shared memory segments, in pages
kernel.shmall = 4294967296
#add by install
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
```

