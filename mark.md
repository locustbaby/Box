###### 管道

```shell
#!/bin/bash

[ -e /tmp/fd1 ] || mkfifo /tmp/fd1 #创建有名管道
exec 3<>/tmp/fd1                   #创建文件描述符，以可读（<）可写（>）的方式关联管道文件，这时候文件描述符3就有了有名管道文件的所有特性
rm -rf /tmp/fd1                    #关联后的文件描述符拥有管道文件的所有特性,所以这时管道文件可以删除，我们留下文件描述符来用就可以
for ((i=1;i<=10;i++))
do
        echo >&3                   #&3代表引用文件描述符3，这条命令代表往管道里面放入了一个"令牌"，文件描述符可以使用0/1/2/225之外的其他数字，这几个已被占用
done
 
for ((i=1;i<=100;i++))
do
read -u3                           #代表从管道中读取一个令牌
{
        sleep 1  #sleep 1用来模仿执行一条命令需要花费的时间（可以用真实命令来代替）
        echo 'success'$i       
        echo >&3                   #代表我这一次命令执行到最后，把令牌放回管道
}&
done
wait
 
exec 3<&-                       #关闭文件描述符的读
exec 3>&-                       #关闭文件描述符的写
```

##### go 值传递 值引用

```shell
https://studygolang.com/articles/10962
https://www.cnblogs.com/ghj1976/archive/2013/02/28/2936595.html
https://www.flysnow.org/2018/02/24/golang-function-parameters-passed-by-value.html
https://studygolang.com/articles/11313
https://juejin.im/post/5ca2f37ce51d4502a27f0539
```

###### learn

```shell
# 20191031
declare
set 
<shell 编程规范>
trap
shell里变量

# 20191101
?initrd <- pxe+kickstart
系统启动过程 bios 。。。+。。。 initrd？

#20191103
协程

# trap
https://man.linuxde.net/trap

# PS4
export PS4='+{$LINENO:${FUNCNAME[0]}} '
https://www.ibm.com/developerworks/cn/linux/l-cn-shell-debug/index.html

# 管道通信
mkfifo或mknod timeout

# flock

# exec http://xstarcd.github.io/wiki/shell/exec_redirect.html

# <>

# tee

# bash 高级编程
https://linuxstory.gitbook.io/advanced-bash-scripting-guide-in-chinese/
https://www.tldp.org/LDP/abs/abs-guide.pdf

# good coder
https://github.com/cafedeflore/mini_spider/tree/master/mini_spider

# flock 无法自控并发，文件🔒 为单锁
单锁：https://my.oschina.net/leejun2005/blog/108656
http://blog.lujun9972.win/blog/2019/02/15/linux-shell-flock%E6%96%87%E4%BB%B6%E9%94%81%E7%9A%84%E7%94%A8%E6%B3%95%E5%8F%8A%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9/index.html
# 单锁
exec 3<>/tmp/lock
flock -n 3
[[ $? -eq 1 ]] && exit
date


# 并发抢占单锁
#!/bin/bash
function com() {
    echo $(($(cat $1)+1)) >$1
    sleep 1
    echo $(($(cat $1)-1)) >$1
}
function te() {
    if [[ -s $1 ]];then
        if [[ $(cat $1) -lt 3 ]];then
            com $1
        else
            echo "$$ locked" && flock 9 && com $1 && echo "$$ unclock"
        fi
    else
        echo 0 >$1 && te $1
    fi
} 9<>$1
te $@

# mkfifo 管道是天然的队列，自控并发实现
#!/bin/bash
trap "rm -f AAA" EXIT
function run() {
read -u 7
sleep 4 # do
echo "success"
echo 1>&7
}
if [[ -p AAA ]];then
    exec 7<>AAA
    run
else
		tmp=/tmp/lock
echo -e "[[ ! -p AAA ]] && mkfifo 2>/dev/null AAA && { echo 1 > AAA & \n echo 2 > AAA & }" >$tmp && source $tmp
exec 7<>AAA
run
fi
#关闭读写
exec 3<&-   #关闭文件描述符的读
exec 3>&-   #关闭文件描述符的写

# echo $RANDOM

# if -n -s -p 
http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html

# 正则表达式
https://blog.csdn.net/yufenghyc/article/details/51078107
https://www.jb51.net/tools/shell_regex.html

# 快速占用端口 python -m SimpleHTTPServer 8116

# prjquota

# slab 泄漏

# cache 泄漏

# scan
florder=$1
dir=$(ls -l $florder |awk '/^d/ {print $NF}')
for i in $dir
do
    if [ "$i" != 'home' -a "$i" != 'proc' ];then
    f=$i
    if [ $florder != '/' ];then
        f=$florder/$i
    fi
        rs=$(ls -lR $f|grep "^-"| wc -l)
    echo $f 文件以及子文件个数 $rs
    fi
done
# sed 
sed -i 's/指定的字符/要插入的字符&/g' 文件
# IFS （分隔符） FS OFS RS ORS
# lsof ss netstat ip 

# awk排除某列
awk '{ $1=""; print $0 }' ur_file
awk -F'|' 'BEGIN {OFS = FS} NR != 1 {$5 += 0.1} {print}' myfile
# 统计学/巴菲特

# latex

#论坛
v2ex gmail
china unix
https://segmentfault.com/
https://juejin.im/

# linux 编程： linux/unix系统编程手册 pdf https://www.itpanda.net/book/9

# 罪与罚

# k8s 指南：https://kubernetes.feisky.xyz/

# pandas
sheet1[~sheet1['b'].isin(remove_db)].sort_values(by=['a']).tail(10)

# readline
easy_install readline
https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/lsof.html

# 腾讯开发者手册
https://cloud.tencent.com/developer/devdocs

# IFS=$'\n' 分隔符指定为换行符

# 美林投资时钟

# https://mooc.study.163.com/learn/1000029000?tid=2403023011#/learn/content

# logging.basicConfig(filemode='a+',handlers=[RotatingFileHandler(filename='log2bigpipe.log',maxBytes=10000,backupCount=3)],level=logging.INFO, format='%(asctime)s %(process)d %(funcName)s : %(message)s')

# https://blog.csdn.net/f2006116/article/details/89058601


# systemctl
http://www.jinbuguo.com/systemd/systemd.html

# ipcmk 消息队列

#ps 信息读取自 procfs

# Container技术：
LXC: https://linuxcontainers.org/
libcontainer: https://github.com/docker/libcontainer
chroot
cgroups
namespace

# TCP/IP sockets in C
# http://cs.baylor.edu/~donahoo/practical/CSockets/

# oauth 2.0

# https://jasper-zhang1.gitbooks.io/influxdb/content/Concepts/key_concepts.html

# https://segmentfault.com/a/1190000013565079

# 桥水/->原则

# https://www.ietf.org/rfc/rfc3339.txt

# https://huataihuang.gitbooks.io/cloud-atlas/studio/

# http://man7.org/index.html

sysctl -w vm.min_free_kbytes=4096000
sysctl -w vm.vfs_cache_pressure=200

# grpc https://doc.oschina.net/grpc?t=60138 // rpyc
# https://www.runoob.com/python/python-multithreading.html

# python 原子更新 https://www.runoob.com/python/python-multithreading.html

# google 内部公开文档 https://zijinshi.gitbook.io/google/introduction 

# https://python3-cookbook.readthedocs.io/zh_CN/latest/index.html

# https://scoutapm.com/blog/understanding-load-averages

# sar 性能分析
https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/sar.html

# tee

#Error starting daemon: Error initializing network controller: list bridge addresses failed: no available network

kubeadm init --image-repository docker.mirrors.ustc.edu.cn/google_containers --ignore-preflight-errors=Swap

registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.17.4

yum list kubelet --showduplicates

# https://blog.csdn.net/shenhuxi_yu/article/details/53047012

# https://blog.csdn.net/hanyren/article/details/103204161?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-7.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-7.nonecase


# redhat
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/kernel_administration_guide/index

# git
https://github.com/huangchucai/My-Note-Blog/issues/46

# py 多线程
https://www.jianshu.com/p/e30d302ebdeb
https://blog.csdn.net/kelvinLLL/article/details/70766836


# 阿里云运维实践
https://developer.aliyun.com/article/761830

# 后端开发
https://www.zhihu.com/question/24952874

# c10k
https://zhuanlan.zhihu.com/p/23114695

# 分布式
https://juejin.im/post/5ef9a88ff265da22dc3fd238

# Istio
https://www.servicemesher.com/istio-handbook/

# Golang
https://documentation.help/Golang/encoding_json.htm

```

