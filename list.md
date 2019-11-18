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
```

