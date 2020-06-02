##### Redis
######  1.redis-cli

######  redis 常用操作

```
shutdown save
动态操作配置文件：
config get *
config set ; config rewrite -> redis conf
批量操作：
    nc：
        (echo -en "ping\r\nset key abc\r\nget key\r\n";sleep 1) | nc 127.0.0.1 6379
    pipeline：
        unix2dos
        cat insert.bat | ./redis-cli --pipe
select db-0 [0-15]
flushdb 当前库; flushall 所有库
rename-command FLUSHALL "boom"
--eval myscript.lua key1 key2 , arg1 arg2 arg3 [lua脚本]
echo -en "chen.qun" | redis-cli -x set name
-r 100 -i 1 info stats | grep instantaneous_ops_per_sec 这个选项在编写一些脚本时非常有用
-c：开启reidis cluster模式，连接redis cluster节点时候使用
--rdb 6379.rdb
-a with no auth
```

###### 数据操作

```
expire key seconds    设置过期时间
ttl key    查看过期时间
```

######  2.Redis 持久化和恢复

###### RDB

```
BGSAVE：后台子进程进行RDB持久化 
SAVE：主进程进行RDB，生产环境千万别用，服务器将无法响应任何操作。 
LASTSAVE： 返回上一次成功SAVE的Unix时间
动态关闭RDB：
redis-cli config set save ""
动态设置RDB：
redis-cli config set save "900 1"
永久关闭RDB：
sed -e '/save/ s/^#*/#/' -i /etc/redis/redis.conf
永久设置RDB：
在redis.conf中设置save选项
查看RDB是否打开：
redis-cli config get save
空的即是关闭，有数字的都是打开的。
```

###### AOF

###### 备份

###### 恢复

###### 3. Redis 数据迁移

```
move key db-index
```

###### 4. 问题处理

###### 一般处理

```
可用性探测：redis-cli ping
网络延迟：redis-cli --latency [千兆 0.16ms]

统计信息：info [] ; config restart : 重新统计

慢查询：结果为查询ID、发生时间、运行时长和原命令 默认10毫秒，默认只保留最后的128条。单线程的模型下，一个请求占掉10毫秒是件大事情，注意设置和显示的单位为微秒，注意这个时间是不包含网络延迟的。 slowlog get 10 ; slowlog len ; slowlog reset;

客户端：info clients ; client list ; client kill ; client getname ; client setnanme ;
```

###### 并发延迟检查

```
INFO commandstats    查看命令执行了多少次，执行命令所耗费的毫秒数(每个命令的总时间和平均时间)
--bigkeys
slowlog len ; slowlog get 10
```

###### REDIS 复制

```shell
#	https://www.cnblogs.com/lukexwang/p/4711977.html
```

###### REDIS补充

```shell
# redis为什么这么快？
纯内存操作
单线程操作，避免了频繁的上下文切换
采用了非阻塞I/O多路复用机制（Select、Epoll、Evport、Kqueue等多路复用函数库）
# Redis的数据类型
string：最常规的Set/Get操作，Value可以是String也可以是数字，一般做一些复杂的计数功能的缓存
Hash：存储用户信息，以CookieId作为Key，设置30分钟为缓存过期时间，能很好地模拟出类似Session的效果
List: Lrange命令，做基于Redis的分页功能，性能极佳，用户体验好
set： 因为Set堆放的是一堆不重复值的集合，所以可以做全局去重的功能，利用交集、并集、差集等操作，可以计算共同喜好、全部的喜好、自己独有的喜好等功能。
Sorted Set:Sorted Set多了一个权重参数Score，集合中的元素能够按Score进行排列。可以做排行榜应用，取TOP N操作。另外，Sorted Set还可以用来做延时任务。最后一个应用就是可以做范围查找。
# Redis的过期策略及内存淘汰机制
Redis采用的是定期删除+惰性删除策略
为什么不用定时删除策略？

定时删除，用一个定时器来负责监视Key，过期则自动删除。虽然内存及时释放，但是十分消耗CPU资源。在大并发请求下，CPU要将时间应用在处理请求，而不是删除Key，因此没有采用这一策略。
定期删除+惰性删除是如何工作的呢？

定期删除，Redis默认每个100ms检查是否有过期的Key，有过期Key则删除。需要说明的是，Redis不是每个100ms将所有的Key检查一次，而是随机抽取进行检查（如果每隔100ms，全部Key进行检查，Redis岂不是卡死）。因此，如果只采用定期删除策略，会导致很多Key到时间没有删除。

于是，惰性删除派上用场。也就是说在你获取某个Key的时候，Redis会检查一下，这个Key如果设置了过期时间，那么是否过期了？如果过期了此时就会删除。

采用定期删除+惰性删除就没其他问题了么？

不是的，如果定期删除没删除Key。然后你也没及时去请求Key，也就是说惰性删除也没生效。这样，Redis的内存会越来越高，那么就应该采用内存淘汰机制。

在Redis.conf中有一行配置：
# maxmemory-policy volatile-lru
该配置就是配内存淘汰策略的：
Noeviction：当内存不足以容纳新写入数据时，新写入操作会报错。应该没人使用吧；
Allkeys-lru：当内存不足以容纳新写入数据时，在键空间中，移除最近最少使用的Key。推荐使用，目前项目在用这种；

Allkeys-random：当内存不足以容纳新写入数据时，在键空间中，随机移除某个key，应该也没人使用吧；

Volatile-lru：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，移除最近最少使用的Key。这种情况一般是把Redis既当缓存又做持久化存储的时候才用。不推荐；

Volatile-random：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，随机移除某个Key。依然不推荐；

Volatile-ttl：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，有更早过期时间的Key优先移除。不推荐。

PS：如果没有设置Expire的Key，不满足先决条件（Prerequisites）；那么Volatile-lru、Volatile-random和Volatile-ttl策略的行为，和Noeviction（不删除）基本上一致。
# Redis和数据库双写一致性问题
一致性问题是分布式常见问题，还可以再分为最终一致性和强一致性。数据库和缓存双写，就必然会存在不一致的问题，想要回答这个问题，就要先明白一个前提：如果对数据有强一致性要求，就不能放缓存。我们所做的一切，只能保证最终一致性。

另外，我们所做的方案其实从根本上来说，只能说降低不一致发生的概率，无法完全避免。因此，有强一致性要求的数据不能放缓存。

《分布式数据库与缓存双写一致性方案解疑》给出了详细的分析，在这里简单地说一说：首先，采取正确更新策略，先更新数据库，再删缓存；其次，因为可能存在删除缓存失败的问题，提供一个补偿措施即可，例如利用消息队列。

# 应对缓存穿透和缓存雪崩问题
关于“如何应对缓存穿透和缓存雪崩”这两个问题，说句实在话，一般中小型传统软件企业很难碰到。如果有大并发的项目，流量有几百万左右，这两个问题一定要深刻考虑：

1应对缓存穿透

缓存穿透，即黑客故意去请求缓存中不存在的数据，导致所有的请求都怼到数据库上，从而数据库连接异常。

解决方案：
利用互斥锁，缓存失效的时候，先去获得锁，得到锁了，再去请求数据库，没得到锁，则休眠一段时间重试；

采用异步更新策略，无论Key是否取到值，都直接返回。Value值中维护一个缓存失效时间，缓存如果过期，异步起一个线程去读数据库，更新缓存，需要做缓存预热（项目启动前，先加载缓存）操作；

提供一个能迅速判断请求是否有效的拦截机制，比如利用布隆过滤器，内部维护一系列合法有效的Key，迅速判断出，请求所携带的Key是否合法有效，如果不合法，则直接返回。

2应对缓存雪崩

缓存雪崩，即缓存同一时间大面积的失效，这个时候又来了一波请求，结果请求都怼到数据库上，从而导致数据库连接异常。

解决方案：

给缓存的失效时间加上一个随机值，避免集体失效；

使用互斥锁，但是该方案吞吐量明显下降了；

双缓存。我们有两个缓存，缓存A和缓存B。缓存A的失效时间为20分钟，缓存B不设失效时间，自己做缓存预热操作。然后细分以下几个小点：

a. 从缓存A读数据库，有则直接返回；

b. A 没有数据，直接从B读数据，直接返回，并且异步启动一个更新线程；

c. 更新线程同时更新缓存A和缓存B。
# 如何解决Redis并发竞争Key问题
这个问题大致就是同时有多个子系统去Set一个Key。这个时候要注意什么呢？本人提前百度了一下，发现大家思考的答案基本都是推荐用Redis事务机制。但本人不推荐使用Redis的事务机制。因为我们的生产环境，基本都是Redis集群环境，做了数据分片操作。你一个事务中有涉及到多个Key操作的时候，这多个Key不一定都存储在同一个Redis-Server上。因此，Redis的事务机制，十分鸡肋。

解决方法如下：
 
如果对这个Key操作不要求顺序

这种情况下，准备一个分布式锁，大家去抢锁，抢到锁就做Set操作即可，比较简单。 
如果对这个Key操作要求顺序

假设有一个Key1，系统A需要将Key1设置为ValueA，系统B需要将Key1设置为ValueB，系统C需要将Key1设置为ValueC。期望按照Key1的Value值按照 ValueA→ValueB→ValueC的顺序变化。这种时候我们在数据写入数据库的时候，需要保存一个时间戳。假设时间戳如下：

系统A Key 1 {ValueA  3:00}
系统B Key 1 {ValueB  3:05}
系统C Key 1 {ValueC  3:10}

那么，假设这会系统B先抢到锁，将Key1设置为{ValueB 3:05}。接下来系统A抢到锁，发现自己的ValueA的时间戳早于缓存中的时间戳，那就不做Set操作了。以此类推。

其他方法，比如利用队列，将Set方法变成串行访问也可以。总之，灵活变通

# redis开发规范
https://mp.weixin.qq.com/s/DU-fz3nUU41mMkqVTRjxkw
# 合理使用集合类
使用 sortedset、set、list、hash等集合类的O(N)操作时要评估当前元素个数的规模以及将来的增长规模，对于短期就可能变为大集合的key，要预估O(N)操作的元素数量，避免全量操作，可以使用HSCAN、SSCAN、ZSCAN进行渐进操作。集合元素数量过大在使用过程中会影响redis的实际性能，元素个数建议尽量不要超过5000，元素数量过大可考虑拆分成多个key进行处理。
# 合理设置过期时间
如果key没有设置超时时间，会导致一直占用内存。对于可以预估使用生命周期的key应当设置合理的过期时间或在最后一次操作时进行清理，避免垃圾数据残留redis。
# 合理利用批操作命令
对于大量频繁的hset操作可以使用 HMSET替代减少redis操作次数同时提升处理速度，但是要考虑单次请求操作的数量，避免慢日志。
在redis使用过程中，要正视网络往返时间，合理利用批量操作命令，减少通讯时延和redis访问频次。redis为了减少大量小数据CMD操作的网络通讯时间开销 RTT (Round Trip Time)，支持多种批操作技术：

MSET/HMSET等都支持一次输入多个key，LPUSH/RPUSH/SADD等命令都支持一次输入多个value,也要注意每次操作数量不要过多,建议控制在500个以内；

PipeLining 模式 可以一次输入多个指令。redis提供一个 pipeline 的管道操作模式，将多个指令汇总到队列中批量执行，可以减少tcp交互产生的时间，一般情况下能够有10%~30%不等的性能提升；

更快的是Lua Script模式，还可以包含逻辑。redis内嵌了 lua 解析器，可以执行lua 脚本，脚本可以通过eval等命令直接执行，也可以使用script load等方式上传到服务器端的script cache中重复使用。
# 减少不必要的请求
ttl命令对于key不存在的情况会返回-2，若key不存在则不需要再调用del命令，可减少无效请求。
redis的所有请求对于不存在的key都会有输出返回，合理利用返回值处理，避免不必要的请求，提升业务吞吐量。
# 避免value设置过大
数量比较多时可以考虑改用hash结构存储，每一个field是商品id,value是该商品对象，如果数量较大可使用hscan获取。
String类型尽量控制在10KB以内。虽然redis对单个key可以缓存的对象长度能够支持的很大，但是实际使用场合一定要合理拆分过大的缓存项，1k 基本是redis性能的一个拐点。当缓存项超过10k、100k、1m性能下降会特别明显。关于吞吐量与数据大小的关系可见下面官方网站提供的示意图。
在局域网环境下只要传输的包不超过一个 MTU（以太网下大约 1500 bytes），那么对于 10、100、1000 bytes不同包大小的处理吞吐能力实际结果差不多。
# 设计规范的key名
可读性

以业务名为前缀，用冒号分隔，可使用业务名：子业务名：id的结构命名，子业务下多单词可再用下划线分隔

举例：活动系统-人拉人红包活动-id，可命名为 ACTIVITY:INVITE_REDPACKET:001

简洁性
保证语义的前提下，控制key的长度，当key较多时，内存占用也不容忽视

不包含转义字符
不包含空格、换行、单双引号以及其他转义字符
# 留心禁用命令
keys、monitor、flushall、flushdb应当通过redis的rename机制禁掉命令，若没有禁用，开发人员要谨慎使用。其中flushall、flushdb会清空redis数据；keys命令可能会引起慢日志；monitor命令在开启的情况下会降低redis的吞吐量，根据压测结果大概会降低redis50%的吞吐量，越多客户端开启该命令，吞吐量下降会越多。

keys和monitor在一些必要的情况下还是有助于排查线上问题的，建议可在重命名后在必要情况下由redis相关负责人员在redis备机使用，monitor命令可借助redis-faina等脚本工具进行辅助分析，能更快排查线上ops飙升等问题
```

##### Redis哨兵

```shell

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
vm.overcommit_memory = 1
vm.swappiness = 0
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 300
net.ipv4.tcp_max_syn_backlog = 511
net.core.somaxconn = 511
```

##### redis.conf

```shell
daemonize yes
pidfile "/opt/logs/redis.pid"
port 6379
tcp-backlog 511
timeout 0
tcp-keepalive 0
loglevel notice
logfile "/opt/logs/redislog.log"
databases 16
stop-writes-on-bgsave-error no
rdbcompression yes
rdbchecksum yes
dbfilename "dump.rdb"
dir "/opt/logs"
slave-serve-stale-data yes
slave-read-only yes
repl-disable-tcp-nodelay no
slave-priority 100
rename-command config suningconfig
rename-command flushall suningflushall
maxmemory-policy noeviction
appendonly no
appendfilename "appendonly.aof"
appendfsync everysec
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
lua-time-limit 5000
slowlog-log-slower-than 10000
slowlog-max-len 128
notify-keyspace-events ""
hash-max-ziplist-entries 512
hash-max-ziplist-value 64
list-max-ziplist-entries 512
list-max-ziplist-value 64
set-max-intset-entries 512
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
activerehashing yes
client-output-buffer-limit normal 0 0 0
client-output-buffer-limit slave 256mb 64mb 60
client-output-buffer-limit pubsub 32mb 8mb 60
hz 10
aof-rewrite-incremental-fsync yes
maxmemory 2410404249
```

##### redis官网

http://www.redis.cn/topics/faq.html

