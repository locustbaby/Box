#### [ZooKeeper](https://www.w3cschool.cn/zookeeper/) 2181

##### 分布式系统

>A distributed system is de ned as a software system that is composed of independent computing entities linked together by a computer network whose components communicate and coordinate with each other to achieve a common goal.
>分布式系统是由独立的计算机通过网络连接在一起，并且通过一些组件来相互交流和协作来完成一个共同的目标。

######  分布式系统特点

> - 资源共享，例如存储空间，计算能力，数据，和服务等等
> - 扩展性，从软件和硬件上增加系统的规模
> - 并发性 多个用户同时访问
> - 性能 确保当负载增加的时候，系统想要时间不会有影响
> - 容错性 尽管一些组件暂时不可用了，整个系统仍然是可用的
> - API抽象 系统的独立组件对用户隐藏，仅仅暴露服务
>
> 有了ZooKeeper，开发者可以很轻松的实现：
>
> - 配置管理
> - 命名服务
> - 分布式锁
> - 集群关系操作，检测节点的加入和离开

###### 分布式系统难点

> 可以想象，假如一台计算机的出错概率为0.1%，那么1000台服务器的出错概率呢？一旦计算机的数量增多，出错的概率就大大的增加。
>
> 1. 多个相互独立的计算机，假设集群的配置信息在某个Master节点上，其余的节点从Master节点下载配置信息。假如Master节点挂了呢？假设Master节点是故障冗余的，但是配置信息是动态的传递给所有的其余节点的，而不是直接传过去。所有节点之间的信息如何保证一致呢？
> 2. 服务发现的问题，为了增加系统的可靠性，我们一般会在系统中增加更多的服务器。让其它机器知道新加入的节点在集群中的关系和服务，这个设计也需要非常周到的考虑
> 3. 机器数目众多，更容易出现 机器故障，软件崩溃，网络延迟，拓扑改变等等，而这些类型的错误没有规律可循，因此在分布式系统，想实现高容错性是很难的。
>
> 当然了..ZooKeeper被设计出来的目的就是解决这种类型的问题.

##### Zookeeper介绍

###### 停起ZooKeeper

```shell
START: bin/zkServer.sh start
CLI: bin/zkCli.sh
STOP: bin/zkServer.sh stop
```

###### 配置ZooKeeper

```
tickTime=2000
dataDir=/zkdata		快照数据dataDir=/zkdata 
dataLogDir=/zkdatalog	事务日志dataLogDir=/zkdatalog
先写事务日志，再写内存，周期性落到磁盘（刷新内存到快照文件）。事务日志的对写请求的性能影响很大，保证dataLogDir所在磁盘性能良好、没有竞争者。
clientPort=2181	
默认jvm没有配置Xmx、Xms等信息，可以在conf目录下创建java.env文件（内存堆空间一定要小于机器内存，避免使用swap）
export JVMFLAGS="-Xms2048m -Xmx2048m $JVMFLAGS"

集群配置
server.1=zkip:2888:3888
server.2=zkip:2888:3888
server.3=zkip:2888:3888

echo num> dataDir/myid
```

