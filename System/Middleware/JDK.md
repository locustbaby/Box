##### JDK

> JVM原理讲解和调优

```shell
#	https://blog.csdn.net/hjxgood/article/details/53896229
#	讲解
JVM栈	-> 堆
		-> 栈
		-> 本地方法栈
		-> 方法区
#	堆
new	创建对象的内存存放于堆中
堆	->新生代(Young)		->Eden
						  ->Survivor	-> From Space
									   -> To Space
	 ->旧生代(Old)			->Tenured Space
	 ->持久代(Permanent)	->Permanent Space
#	垃圾回收
基本回收策略	-> 引用计数
			-> 标记清除
			-> 复制
			-> 标记-整理
#	JVM对新生代和旧生代采用不同的垃圾回收策略
新生代GC
执行机制	-> 串行GC		 -XX:+UseSerialGC
		   -> 并行回收GC   -XX:+UseParallelGC -XX:ParallelGCThreads=4来指定线程数
		   -> 并行GC	与旧生代的并发GC配合使用
#	调优

```

> 堆栈查看

```shell
jmap -heap pid
jmap -dump:format=b,file=temp_heapdump.hprof pid
jstack pid >javacore.txt
```

```shell
GC日志滚动参数如下：-XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=5M  以上是JBOSS GC日志滚动的配置，第一个开关，第二个是滚动多少个文件，第三个是日志文件的大小（前提已开启-Xloggc）
```

##### JVM参数

```shell
-XX:MaxPermSize=512m	
-Djava.net.preferIPv4Stack=TRUE	
-Dfile.encoding=UTF-8	
-Dsun.jnu.encoding=UTF-8	
-verbose:gc	
-XX:+PrintGCDetails	
-XX:+PrintGCTimeStamps	
-XX:+PrintHeapAtGC	
-XX:+PrintGCDateStamps	
-Xloggc:$JBOSS_HOME/standalone/log/verbose.gc	
-XX:+HeapDumpOnOutOfMemoryError	
-XX:HeapDumpPath=$JBOSS_HOME/standalone/log/	
-Djboss.modules.system.pkgs=$JBOSS_MODULES_SYSTEM_PKGS	
-Djava.awt.headless=true	
-Xms512m	
-Xmx1536m	
-XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSParallelRemarkEnabled	GC算法1
-XX:+UseG1GC	GC算法2
-XX:+UseParallelOldGC	GC算法3
-Dcom.ibm.mq.cfg.TCP.Connect_Timeout=5	防止MQ宕机，连接超时释放
-XX:UseGCLogFileRotation	GC日志分割
-XX:NumberOfGCLogFiles=10	
-XX:GCLogFileSize=20M	
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
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 300
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.ip_local_port_range = 5000  65000

```

