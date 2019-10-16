[ZooKeeper](https://www.w3cschool.cn/zookeeper/) 2181

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

###### ZooKeeper 基本操作

```shell
# 启停
START: bin/zkServer.sh start
CLI: bin/zkCli.sh
	ls /
	Created /HelloWorld
	delete HelloWorld
STOP: bin/zkServer.sh stop
echo ruok |nc localhost 2181 #验证是否正常
# 基本操作
create	#创建一个znode（必须有父节点）
delete	#删除一个znode（不能有任何子节点）
exists	#测试一个znode是否存在并查询他的元数据
getACL，setACL	#获取/设置一个znode的子节点列表
getChildren	#获取一个znode的子节点列表
getData，setData	#获取、设置一个znode所保存的数据
sync	#将客户端的znode的视图与ZooKeeper同步
# 集合更新 multi （事物）
```

###### 配置ZooKeeper

[ZooKeeper管理员](https://blog.csdn.net/y_xianjun/article/details/8190047)

```shell
tickTime=2000	 #基本时间单元（毫米）
dataDir=/zkdata	 #存储持久数据的本地系统位置
dataLogDir=/zkdatalog	#事务日志
先写事务日志，再写内存，周期性落到磁盘（刷新内存到快照文件）。事务日志的对写请求的性能影响很大，保证dataLogDir所在磁盘性能良好、没有竞争者。
clientPort=2181	 #监听端口
默认jvm没有配置Xmx、Xms等信息，可以在conf目录下创建java.env文件（内存堆空间一定要小于机器内存，避免使用swap）
export JVMFLAGS="-Xms2048m -Xmx2048m $JVMFLAGS"

集群配置
server.1=zkip:2888:3888
server.2=zkip:2888:3888
server.3=zkip:2888:3888

echo num> dataDir/myid
```

##### ZK四字命令

```shell
服务器状态	 命令		描述
			ruok	 如果服务器正在运行且未出于出错状态，则输出imok
			conf	 输出服务器的配置信息
			envi	 输出服务器环境信息，包括zk版本，java版本和其他系统信息
			srvr	 输出服务器的统计信息，包括延迟统计，znode数量和服务器运行模（standalone,leader或follower）
			stat	 输出服务器的统计信息和已连接的客户端
			srst	 重置服务器的统计信息
			isro	 显示服务器是否出于只读(rw)模式，或者读写(rw)模式
客户端链接	 dump	  列出集合体中的所有会话和短暂znode
			cons	 列出所有服务器客户端的连接统计信息
			crst	 重置连接统计信息
观察		   wchs		列出服务器上所有观察的摘要信息
			wchc	 按连接列出服务器上所有的观察。如果观察的数量较多，此命令会影响服务器的性能
			wchp	 按znode路径列出服务器上所有的观察。
监控		   mntr		按java属性格式列出服务器统计信息，适合于用作Ganglia和Nagios等监控系统的信息源
```

##### zk API

```java
public class CreateGroup implements Watcher {
    private static final int SESSION_TIMEOUT  = 5000;
    
    private Zookeeper zk;
    private CountDownLatch connectedSignal = new CountDownLatch(1);
    
    public void connect(String hosts) throws IOException, InterruptedException {
        zk = new Zookeeper(hosts, SESSION_TIMEOUT, this);//host, 超时时间毫秒， Watcher对象实例
        connectedSignal.await();
    }
    @Override
    public void process(WatchedEvent event) { // Watcher interface
        if (event.getState() == KeeperState.SyncConected) {
            connectedSignal.countDown();
        }
    }
    public void create(String groupName) throws KeeperException,
    	InterruptedException {
       String path = "/" + groupName;
       String createPath = zk.create(path, null/*data*/, Ids.OPEN_ACL_UNSAFE,
                                    CreateMode.PERSISTENT);
       System.out.println("Created" + createPath);
    }
    public void close() throws InterruptedException {
        zk.close();
    }
    public static void main(String[] args) throws Exception {
        CreateGroup createGroup = new CreateGroup();
        createGroup.connect(args[0]);
        createGroup.create(args[1]);
        createGroup.close();
    }
}
```

##### ZooKeeper

```shell
# 数据模型
树状 znode<1MB 关联ACL
数据访问：原子性
# znode
短暂znode 会话结束时被删除，不可有子节点
顺序znode 名称中包含 ZooKeeper指定顺序号的znode
# 观察触发器
设置观察的操作	 创建znode 	创建子节点 		  删除znode 	删除子节点 			setData
exists		  NodeCreated  				     NodeDeleted					NodeData Chaged
getData									    NodeDeleted					   NodeData Chaged
getChildren				NodeChildren Chaged  NodeDeleted NodeChildren Chaged
# ACL
zk身份验证方式： Digest：用户名密码 sasl：kerberos ip：ip
ACL权限	允许的操作
CREATE		create（子节点）
READ		getChildren， getData
WRITE		setData
DELETE		delete
ADMIN		setACL
#在类 ZooDefs.Ids中有一些预定义的ACL，OPEN_ACL_UNSAFE是其中之一，它将所有的权限（除ADMIN）授予每个人
```

##### 实现

```shell
# 选举
阶段 1 leader选举（200ms）
leader(提交写请求) 其他为 follower（响应读请求）
阶段 2 原子广播
所有写请求都会被转发给leader，leader发送更新广播给follower，当半数以上的follower已经修改持久化之后，领导者才会提交这个更新，客户端收到更新成功的响应（原子性）
# 一致性
每一个对znode树的更新都被赋予一个zxid（全局唯一），决定了分布式系统的执行顺序。z1<z2 ,先z1
1， 顺序一致性
2， 原子性
3， 单一系统映像
4， 持久性
5， 及时性
# 会话

```





