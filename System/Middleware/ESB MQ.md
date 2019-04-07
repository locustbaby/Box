#### LESB WMB( Websphere Message Broker )

##### 搭建

```shell
暂无
```

##### 运维

```shell
# Broker
su - mbadmin
mqsilist 	#查看所有broker信息
mqsistop <brokerName> -i	# -i 强停
mqsistart <brokerName>	# 起broker

# MQ
su - mqm
dspmq	#查看所有 MQ
endmqm <mqName> -i	#强停
strmqm <mqName>	#起MQ
```

##### Websphere MQ 

```shell
创建:
crtmqm -ld /data/mqm/QmgrName/log -md /data/mqm/QmgrName/data -lc -lf 10240 -lp 50 -ls 30 -q QmgrName
启动：strmqm <qmgrName>
查看：dspmq <qmgrName>
运行：（类似cli）runmqsc <qmgrName>
停止：endmqm -c|-w|-i|-p <qmgrName>
删除：dltmqm <qmgrName>
```

```shell
属性操作：
禁读： 查看：echo "DISPLAY QLOCAL( QNAME ) GET "| runmqsc <qmgrName>
ALTER QLOCAL（QNAME） GET（DISABLED）
ALTER QMGR DESCR（'NEW DESCRIPTION'）
ALTER QLOCAL（QNAME） PUT（DISABLED） #禁写
ALTER QALIAS（QNAME） TARGQ（TARGQNAME）
```

```shell
BOOM:
crtmqm
strmqm
setmqaut

RUNMQSC:
ALTER QMGR CCSID(1208)
ALTER QMGR MAXMSGL(10485760)
DEFINE CHANNEL('${qchannel}') CHLTYPE(SVRCONN) MAXMSGL(10485760) MCAUSER('mqclient') TRPTYPE(TCP) REPLACE;
DEFINE CHANNEL('ADMINchannel') CHLTYPE(SVRCONN) MAXMSGL(10485760) MCAUSER('MQuser') TRPTYPE(TCP) REPLACE;
DEFINE LISTENER (LISR.TCP$qmport) TRPTYPE (TCP) CONTROL (QMGR) PORT ($qmport) REPLACE
START LISTENER(LISR.TCP$qmport)
END
```

