##### Redis
######  1.redis-cli

######  redis 常用操作

```
shutdown save
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

##### Redis哨兵

```shell

```

