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

##### LVS实践

> LVS	DR

```shell
#	DR
# vim /usr/local/sbin/lvs_dr.sh
#! /bin/bash
echo 1 > /proc/sys/net/ipv4/ip_forward
ipv=/sbin/ipvsadm
vip=192.168.0.38
rs1=192.168.0.18
rs2=192.168.0.28
ifconfig eth0:0 down
ifconfig eth0:0 $vip broadcast $vip netmask 255.255.255.255 up
route add -host $vip dev eth0:0
$ipv -C
$ipv -A -t $vip:80 -s wrr 
$ipv -a -t $vip:80 -r $rs1:80 -g -w 3
$ipv -a -t $vip:80 -r $rs2:80 -g -w 1

#	RS
# vim /usr/local/sbin/lvs_dr_rs.sh
#! /bin/bash
vip=192.168.0.38
ifconfig lo:0 $vip broadcast $vip netmask 255.255.255.255 up
route add -host $vip lo:0
echo "1" >/proc/sys/net/ipv4/conf/lo/arp_ignore
echo "2" >/proc/sys/net/ipv4/conf/lo/arp_announce
echo "1" >/proc/sys/net/ipv4/conf/all/arp_ignore
echo "2" >/proc/sys/net/ipv4/conf/all/arp_announce
```

#####	LVS+Keepalived

```shell

```

##### Keepalived

```shell
#	/etc/keepalived/keepalived.conf
! Configuration File for keepalived

global_defs {
   notification_email {
     acassen@firewall.loc
     failover@firewall.loc
     sysadmin@firewall.loc
   }
   notification_email_from Alexandre.Cassen@firewall.loc	#源地址
   smtp_server 192.168.200.1
   smtp_connect_timeout 30
   router_id LVS_DEVEL	#机器标识
   vrrp_skip_check_adv_addr
   vrrp_strict
   vrrp_garp_interval 0
   vrrp_gna_interval 0
}

vrrp_instance VI_1 {	#vrrp实例
    state MASTER	#
    interface eth0
    virtual_router_id 51
    priority 100	#本节点优先级
    advert_int 1	#检查间隔
    authentication {	#设置认证
        auth_type PASS	#认证方式
        auth_pass 1111	#认证密码
    }
    virtual_ipaddress {	#VIP
        192.168.200.16
        192.168.200.17
        192.168.200.18
    }
}

virtual_server 192.168.200.100 443 {
    delay_loop 6
    lb_algo rr
    lb_kind NAT
    persistence_timeout 50
    protocol TCP

    real_server 192.168.201.100 443 {
        weight 1
        SSL_GET {
            url {
              path /
              digest ff20ad2481f97b1754ef3e12ecd3a9cc
            }
            url {
              path /mrtg/
              digest 9b3a0c85a887a256d6939da88aabd8cd
            }
            connect_timeout 3
            nb_get_retry 3
            delay_before_retry 3
        }
    }
}
#	LVS+Keepalived配置
virtual_server 10.10.10.2 1358 {	#VIP Vport
    delay_loop 6	#服务轮询时间间隔
    lb_algo rr 		#lvs调度算法
    lb_kind NAT		#lvs集群模式
    persistence_timeout 50
    protocol TCP	#健康检查用的tcp还是udp

    sorry_server 192.168.200.200 1358	#备用机 当所有rserver都不可用时，请求分发到这

    real_server 192.168.200.2 1358 {	#rserver
        weight 1		#权重
        HTTP_GET {		#检查方式	HTTP_GET|SSL_GET|TCP_CHECK|SMTP_CHECK|MISC_CHECK
            url { 		#要检查的url
              path /testurl/test.jsp
              digest 640205b7b0fc66c1ea91c463fac6334d
            }
            url { 
              path /testurl2/test.jsp
              digest 640205b7b0fc66c1ea91c463fac6334d
            }
            url { 
              path /testurl3/test.jsp
              digest 640205b7b0fc66c1ea91c463fac6334d
            }
            connect_timeout 3
            nb_get_retry 3	#重连次数
            delay_before_retry 3	#重连间隔
        }
    }

    real_server 192.168.200.3 1358 {
        weight 1
        HTTP_GET {
            url { 
              path /testurl/test.jsp
              digest 640205b7b0fc66c1ea91c463fac6334c
            }
            url { 
              path /testurl2/test.jsp
              digest 640205b7b0fc66c1ea91c463fac6334c
            }
            connect_timeout 3
            nb_get_retry 3
            delay_before_retry 3
        }
    }
}

virtual_server 10.10.10.3 1358 {	
    delay_loop 3
    lb_algo rr 
    lb_kind NAT
    persistence_timeout 50
    protocol TCP

    real_server 192.168.200.4 1358 {
        weight 1
        HTTP_GET {
            url { 
              path /testurl/test.jsp
              digest 640205b7b0fc66c1ea91c463fac6334d
            }
            url { 
              path /testurl2/test.jsp
              digest 640205b7b0fc66c1ea91c463fac6334d
            }
            url { 
              path /testurl3/test.jsp
              digest 640205b7b0fc66c1ea91c463fac6334d
            }
            connect_timeout 3
            nb_get_retry 3
            delay_before_retry 3
        }
    }

    real_server 192.168.200.5 1358 {
        weight 1
        HTTP_GET {
            url { 
              path /testurl/test.jsp
              digest 640205b7b0fc66c1ea91c463fac6334d
            }
            url { 
              path /testurl2/test.jsp
              digest 640205b7b0fc66c1ea91c463fac6334d
            }
            url { 
              path /testurl3/test.jsp
              digest 640205b7b0fc66c1ea91c463fac6334d
            }
            connect_timeout 3
            nb_get_retry 3
            delay_before_retry 3
        }
    }
}
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

