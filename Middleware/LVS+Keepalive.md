##### LVS+Keepalived

https://www.cnblogs.com/kevingrace/p/5574486.html

https://www.cnblogs.com/liwei0526vip/p/6370103.html 	#LVS+Keepalived精讲

##### LVS原理

> 三种模型

```shell
# LVS+DR
源mac->DR mac
# LVS+NAT
修改 源IP->CIP 目标ip->RIP
# LVS+Tun
封装 源ip->DIP 目ip->RIP
```

> 八种调度算法

```shell
#	静态方法
rr	:轮询
wrr	:加权轮询
sh	:源地址hash
dh	:目的地址hash
#	动态方法
lc	:最少链接
wlc	:加权最少链接
sed	:
nq	:
lblc:基于局部性的最少连接调度算法，记录请求的目标 IP 地址寻找最近的该目标 IP 地址所有使用的服务器
lblcr:复杂的基于局部性的最少连接调度算法，维护目标 IP 到一组服务器之间的映射关系
```

##### LVS排错

```shell
#	判断连通性
#	检查状态
#	测试每台服务
#	检查后端的Arp设置是否正确
#	检查虚拟ip是否绑定成功
#	交换机确认vip的mac是否更新
```

