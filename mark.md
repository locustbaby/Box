###### list

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
sleep 4
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

# echo $RANDOM

# if -n -s -p 
http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html

# 正则表达式
https://blog.csdn.net/yufenghyc/article/details/51078107

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

#pandas
sheet1[~sheet1['b'].isin(remove_db)].sort_values(by=['a']).tail(10)
```

