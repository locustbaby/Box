##### Zookeeper

[官方文档](http://zookeeper.apache.org/doc/r3.5.6/)

```shell
# 关闭swap
swapoff -a
```

###### zoo.cfg

```shell
initLimit=10
syncLimit=5
clientPort=2181
tickTime=2000	# 单位ms 各种limit的原子时间 
dataDir=data	#	相对路径
dataLogDir=log
admin.serverPort=8080	#adminserver ？不好使无法访问 tcp不释放 closewait
admin.idleTimeout=1000
reconfigEnabled=true	#开启动态配置
dynamicConfigFile=conf/zoo.cfg.dynamic	#热配置部分文件
4lw.commands.whitelist=*	#所有4字命令放行
```

```shell
#	conf/zoo.zfg.dynamic
server.1=zoo01:2888:2999
server.2=zoo01:2888:2999
server.3=zoo01:2888:2999

# myid： data/myid
```

```shell
#	conf/java.env
export JAVA_HOME=sun-java8/
export JVMFLAGS="-Xms8G -Xmx16G $JVMFLAGS"	#jvm简单配置 
```

