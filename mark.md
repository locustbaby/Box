##### ML

> [ML](<https://mp.weixin.qq.com/s/TjpCoyZRT1kI0M6y7pSeiQ>)
>
> AutoKeras

##### 怎么参与开源

```
https://zhuanlan.zhihu.com/p/78893980
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
? initrd <- pxe+kickstart
系统启动过程 bios 。。。+。。。 initrd ？

#20191103
协程

# trap
https://man.linuxde.net/trap

# PS4
export PS4='+{$LINENO:${FUNCNAME[0]}} '
https://www.ibm.com/developerworks/cn/linux/l-cn-shell-debug/index.html



# exec http://xstarcd.github.io/wiki/shell/exec_redirect.html

# <>

# tee

# bash 高级编程
https://linuxstory.gitbook.io/advanced-bash-scripting-guide-in-chinese/
https://www.tldp.org/LDP/abs/abs-guide.pdf

# good coder
https://github.com/cafedeflore/mini_spider/tree/master/mini_spider


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

# 占位符
https://www.jianshu.com/p/66aaf908045e


# sed -i "/name: SparkIdmChannel/,/lb/{s/^lb.*/#&\nlb:/}" $rpc_conf

# math
https://betterexplained.com/

# google sre book
《Building Secure and Reliable Systems》、《The Site Reliability Workbook》和《Site Reliability Engineering》https://landing.google.com/sre/workbook/toc/

阿里云文档
https://help.aliyun.com/?spm=a2c4g.11186623.6.538.127a35e19bpe4L

阿里藏经阁
https://developer.aliyun.com/ebook

rpc
https://www.jianshu.com/p/7d6853140e13

5xx

https

outh2.0

vim
http://www.classnotes.cn/2857.html

k8s 命令
https://zhuanlan.zhihu.com/p/93461178
http://docs.kubernetes.org.cn/683.html

cfs
http://c.biancheng.net/view/1255.html

http://www.ymcall.com/artinfo/780867682346446665.html

https://zhuanlan.zhihu.com/p/92536201


IO调度算法
https://blog.csdn.net/xie1xiao1jun/article/details/20629145?utm_source=blogxgwz6

进程调度算法
https://www.cnblogs.com/bajdcc/p/4707544.html

内存 io 进程
https://blog.csdn.net/pi9nc/article/details/19848831?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromBaidu-1.control&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromBaidu-1.control


每个程序员都应该尝试的项目-InfoQ
https://www.infoq.cn/article/k5CpCGNqgfErqTol2SpX

公开课资源
https://www.zhihu.com/question/38335108

16 岁高中生成功将 Linux 移植到 iPhone，并贴出详细指南-InfoQ
https://www.infoq.cn/article/DMMXsxG1O1Bf76u40l7v

https://prometheus.fuckcloudnative.io/

https://www.cnblogs.com/sunsky303/p/8962628.html

go atomic mutex

https://zhuanlan.zhihu.com/p/153093074

质量效率性能成本安全
```

Go and 分布式

```
go 协程
https://www.cnblogs.com/piaobodewu/p/11075441.html
v2ex 分布式
https://www.v2ex.com/t/236294
分布式经典
https://www.zhihu.com/question/62486582
什么是分布式
https://www.cnblogs.com/xybaby/p/7787034.html
学习分布式
https://www.zhihu.com/question/23645117
什么是协程
https://zhuanlan.zhihu.com/p/172471249
高并发分布式解密
https://www.cnblogs.com/binghe001/p/12778853.html

rust 写操作系统
https://zhuanlan.zhihu.com/p/90710559
go写linux

nginx config
https://github.com/chr4/nginx.vim/blob/master/syntax/nginx.vim
https://github.com/nginx/
https://www.cnblogs.com/1993zzd/p/11987442.html

Go语言设计和实现
https://draveness.me/golang/docs/part3-runtime/ch06-concurrency/golang-goroutine/
go并发之道
https://www.kancloud.cn/mutouzhang/go/596844
https://gobyexample.com/closing-channels
https://cloud.tencent.com/developer/article/1412500
https://www.jianshu.com/p/24ede9e90490

goroutine
https://www.zhihu.com/question/20862617
```



```
pdf: go语言高并发之道


进程线程协程：https://blog.csdn.net/daaikuaichuan/article/details/82951084

准备：nginx es redis ansible

go高级语言编程 https://github.com/chai2010/advanced-go-programming-book

决策算法： https://mp.weixin.qq.com/s/JD6uFshTpGN_3RaekSA36w
（https://algorithmsbook.com/files/dm.pdf）

全链路压测
https://www.cnblogs.com/imyalost/p/8439910.html

go并发：channel还是锁
https://segmentfault.com/a/1190000017890174

go常见的几种并发模型
https://blog.csdn.net/smartfox80/article/details/77603481

春招计划：https://leetcode-cn.com/circle/discuss/iUZEHo/

EDAS 微服务应用同城容灾最佳实践 https://developer.aliyun.com/article/781642?utm_content=g_1000238405

arthas定位根因
https://mp.weixin.qq.com/s/RuqltkN9VdVQ1K3GKuJ-Gw

云原生小红书https://mp.weixin.qq.com/s/BFJCWGOJGWfqfcxzVCU5hQ


https://roadmap.sh/backend
https://blog.csdn.net/a724888/article/details/83000249

https://w.cnblogs.com/peteremperor/p/12785335.html
https://zhuanlan.zhihu.com/p/101306188

https://www.zhihu.com/question/20402534?sort=created
Operating Systems: https://pages.cs.wisc.edu/~remzi/OSTEP/

乐观锁 悲观锁
https://mp.weixin.qq.com/s/BQ-nUwL5MrLIJCQTHLtpXw

ebpf
https://www.cnblogs.com/charlieroro/p/13403672.html

k8s准入控制器
https://blog.csdn.net/xixihahalelehehe/article/details/112280103

https://yuerblog.cc/2019/11/26/k8s-python-client%E8%8E%B7%E5%8F%96pod%E8%B5%84%E6%BA%90%E5%88%A9%E7%94%A8%E7%8E%87%EF%BC%88cpu-%E5%86%85%E5%AD%98%EF%BC%89/


https://leetcode-cn.com/circle/discuss/XXGdoF/#25-%E8%BF%9B%E7%A8%8B%E7%9A%84%E9%80%9A%E4%BF%A1%E6%96%B9%E5%BC%8F%E6%9C%89%E5%93%AA%E4%BA%9B%EF%BC%9F%E7%BA%BF%E7%A8%8B%E5%91%A2%EF%BC%9F

https://zhuanlan.zhihu.com/p/21649950	（https://www.zhihu.com/column/c_1309835600069750784）

k8s与云服务器之间服务互访之节点网络打通
https://www.cnblogs.com/cuishuai/p/10310698.html
```

```
go学习路线
https://codechina.gitcode.host/developer-roadmap/go/intro/

阿里云csi flexvloume
https://www.alibabacloud.com/help/zh/doc-detail/100013.htm

pid namespace
https://blog.csdn.net/tanzhe2017/article/details/81003281

etcd
https://blog.csdn.net/keets1992/article/details/108722430

go sql
https://blog.csdn.net/hittata/article/details/52122541

go 复杂json
https://blog.csdn.net/kevin_tech/article/details/105213359

serverless
https://blog.csdn.net/cc18868876837/article/details/90672971

mkdown
https://studygolang.com/markdown

go json 改格式
https://www.v2ex.com/t/680907

nginx $Query string
https://blog.csdn.net/liuxiao723846/article/details/54925328

thanos
http://dockone.io/article/6019

cadvisor 常用指标
https://blog.csdn.net/yjph83/article/details/84909318

混沌工程
https://zhuanlan.zhihu.com/p/90294032

promethus cadvisor指标
https://www.freesion.com/article/6068709518/

tcp
https://typecodes.com/linux/tcpconnectiontimedout.html

linux
http://linuxe.cn/

envoy
https://www.servicemesher.com/envoy/intro/what_is_envoy.html

ioutil.readall 问题
https://w.cnblogs.com/EasyNVR/p/13265048.html

优雅读取response
https://blog.csdn.net/thinkercode/article/details/86660632

Go param
https://stackoverflow.com/questions/30652577/go-doing-a-get-request-and-building-the-querystring

rewrite 作用， /x/(.*) /x/$1

coursea 硕士学位

promethus
https://yunlzheng.gitbook.io/prometheus-book/

tcpdump
容器抓包

workflow
https://zhuanlan.zhihu.com/p/40301198

磁盘
https://help.aliyun.com/knowledge_detail/42531.html#ejmcJ

k8s
https://mp.weixin.qq.com/s/Qb5otJT0ZmnPr7Qz0EQ0iQ


devops
https://www.jianshu.com/p/7738f7a6b36d


k8s 书
kubernetes 源码剖析 《programming kubernetes》

什么是service mesh
https://zhuanlan.zhihu.com/p/61901608

服务网格入口网关大比拼
https://m.sohu.com/a/314009713_465944

istio流量管理
https://segmentfault.com/a/1190000037760781

kubernetes快速学习手册
https://blog.csdn.net/xixihahalelehehe/article/details/108562082?utm_source=app&app_version=4.5.2

kubenetes源码笔记
https://blog.upweto.top/gitbooks/kubeSourceCodeNote/

istio原理和架构
https://blog.csdn.net/zhonglinzhang/article/details/85233390

istio服务网格进阶实战
https://www.bookstack.cn/read/istio-handbook/data-plane-envoy-cds.md

知乎kubernetes
https://www.zhihu.com/column/c_1236695767592222720

thanos部署
https://www.kubernetes.org.cn/8308.html

kube promthus
https://github.com/prometheus-operator/kube-prometheus#quickstart

kubepromethus部署
https://blog.csdn.net/networken/article/details/85620793

k8s crd详解
https://www.jianshu.com/p/cc7eea6dd1fb

github访问慢
https://www.ipaddress.com 

kubernetes CRD开发指南
https://blog.csdn.net/github_35614077/article/details/98749285

CRD
https://zhuanlan.zhihu.com/p/52367044

Canal数据库增量同步
https://blog.csdn.net/tony_vip/article/details/100904024

kubernetes网络原理
https://www.kubernetes.org.cn/2059.html

k8s hpa
https://w.cnblogs.com/centos-python/articles/13641576.html

动态修改pod资源
https://help.aliyun.com/document_detail/197267.html

压测工具
https://www.imooc.com/article/291715


Kubernetes Best Practices 书

grpc 准备工作
https://grpc.io/docs/languages/go/quickstart/#prerequisites

serverless 
https://blog.csdn.net/cc18868876837/article/details/90672971

go性能分析pprof
https://www.jianshu.com/p/4e4ff6be6af9

rx_missed_errors
https://bbs.csdn.net/topics/392153237?utm_medium=distribute.wap_relevant.none-task-discussion_topic-BlogCommendFromBaidu-2.wap_blog_relevant_pic&depth_1-utm_source=distribute.wap_relevant.none-task-discussion_topic-BlogCommendFromBaidu-2.wap_blog_relevant_pic

全链路压测
https://www.cnblogs.com/imyalost/p/8439910.html


golang并发选择
https://segmentfault.com/a/1190000017890174

go 常用并发模型框架
https://blog.csdn.net/smartfox80/article/details/77603481

并发访问slice
https://juejin.cn/post/6844904134592692231

redis分布式锁
https://www.cnblogs.com/moxiaotao/p/10829799.html


网络IO和磁盘IO
https://www.cnblogs.com/sunsky303/p/8962628.html

6大设计原则
https://www.cnblogs.com/LangZXG/p/6242925.html

消息队列价值思考
https://juejin.cn/post/6844903985522950158

分布式锁：
基于数据库实现分布式锁；
基于缓存（Redis等）实现分布式锁；
基于Zookeeper实现分布式锁；

分布式锁
https://www.cnblogs.com/makelove/p/12101538.html

https://blog.csdn.net/ydyang1126/article/details/51769010
cpu mem io
https://blog.csdn.net/wujizhishui/article/details/89333957
timewait closewait
https://www.cnblogs.com/kevingrace/p/9988354.html

ES
https://www.cnblogs.com/JimShi/p/11525360.html
https://www.cnblogs.com/weifeng1463/p/14479373.html
https://www.sohu.com/a/288181416_411876
https://blog.csdn.net/whichard/article/details/90753727
https://zhuanlan.zhihu.com/p/102500311
```

```
cgroup
https://www.ibm.com/developerworks/cn/linux/1506_cgroup/index.html
strace 排查
https://blog.bruceding.me/595.html
```

```
https://cloud.tencent.com/developer/article/1576347

https://start.aliyun.com/course?spm=a2ck6.17690074.0.0.503c2e7dutbTJV&id=0iNJ9RDH
```

```
https://www.bilibili.com/read/cv8081272
https://zhuanlan.zhihu.com/p/99364894?from_voters_page=true
https://blog.csdn.net/ZLJ925/article/details/79045034
https://blog.csdn.net/kaka1121/article/details/89187863
https://www.zhihu.com/question/34845701
https://github.com/torvalds/linux/commit/73f576c04b9410ed19660f74f97521bee6e1c546
https://github.com/torvalds/linux/commit/d6e0b7fa11862433773d986b5f995ffdf47ce672
https://blog.csdn.net/yunqiinsight/article/details/88103952
https://docs.pingcap.com/zh/tidb/stable/tikv-overview
https://www.cnblogs.com/yangyuliufeng/p/13611126.html
https://golang.design/under-the-hood/
https://mp.weixin.qq.com/s/C2y8WqjVnLXHRMYJa-hqvA
https://i.cloudnative.to/kubernetes/kubernetes/index
https://cloudnative.to/blog/kubernetes-apiserver-cacher/  kuberentes 源码图的完整版，欢迎大家阅读
Brendan Gregg
https://www.zhihu.com/question/31413235
https://mp.weixin.qq.com/s/VulB3tiXTRAjYsuWxgU1Zg
https://www.oschina.net/translate/debugging-an-evil-go-runtime-bug?print
lldb -c

https://stor.51cto.com/art/201909/603425.htm
https://www.cnblogs.com/huaweicloud/p/12016055.html
```

