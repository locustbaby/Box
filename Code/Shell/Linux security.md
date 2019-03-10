##### 系统安全

```shell
# unnecessary user & group
USER: adm, lp, sync, shutdown, halt, news, uucp, operator, games, gopher
GROUP: adm, lp, news, uucp, games, dip, pppusers, popusers, slipusers
```

##### rootkit

```shell
# 文件级别rootkit
替换常用命令为 壳程序
# 内核级别rootkit

chkrootkit
RKHunter
pidof sshd
ls -al /proc/13276/exe
ls -al /proc/13276/fd
fuser -n tcp port
rpm -Va	# S长度 M权限或类型 5 MD5 D设备节点的属性 L符号链接 U owner G group T last mtime
```

