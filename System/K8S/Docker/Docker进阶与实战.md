##### cgroup

```bash
# cgroup：https://cloud.tencent.com/developer/article/1574064
子系统：
# 1、cpuset
cpuset.cpus：允许进程使用的CPU列表（例如0~4，9）
cpuset.mems：允许进程使用的内存节点列表（例如0~1）
# 2、cpu
cpu比重分配
cpu带宽限制
# 3、cpuacct
cpuacct.stat
cpuacct.usage
cpuacct.usage_percpu
# 4、memory
memory.limit_in_bytes
memory.memsw.limit_in_bytes
memory.oom_control
memory.stat
# 5、blkio
blkio.weight
blkio.weight_device
blkio.throttle.read_bps_device
blkio.throttle.write_bps_device
# 6、devices
# 7、net_cls
# 8、freezer
# 9、ns子系统
```

##### Namespace

```bash
主要是通过clone、setns和unshare这3个系统调用来完成的。
docker exec命令的实现原理就是setns
6种namespace:
# IPC：隔离System V IPC和POSIX消息队列。
# Network：隔离网络资源。
# Mount：隔离文件系统挂载点。
# PID：隔离进程ID。
# UTS：隔离主机名和域名。
# User：隔离用户ID和组ID。
```



