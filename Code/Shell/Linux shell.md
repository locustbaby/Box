##### bash

```shell
bash
	-c : string with args
	-i : interactive
	-l : shell act as login shell
	-s : < 标准输入
```

##### 变量子串  $string	

| 编号 | 表达式                       | 说明                                        |
| ---- | ---------------------------- | ------------------------------------------- |
| 1    | ${#string}                   | 返回$string的长度                           |
| 2    | ${string:position}           | 在$string中，从位置position之后开始提取子串 |
| 3    | ${string:position:length}    | 在length的子串                              |
| 4    | ${string#substring}          | 从变量string开头(通配)匹配 最短删除（左右） |
| 5    | ${string##substring}         | 从变量string开头(通配)匹配 最长删除（左右） |
| 6    | ${string%substring}          | 从变量结尾最短匹配删除substring子串（左右） |
| 7    | ${string%%substring}         | 从变量结尾最长匹配删除substring子串（左右） |
| 8    | ${string/substring/replace}  | 替换第一个匹配                              |
| 9    | ${string//substring/replace} | 全替换                                      |
| 10   | ${string/#substring/replace} | 开头匹配                                    |
| 11   | ${string/%substring/replace} | 结尾匹配                                    |

##### ps

```shell
ps : PID TTY TIME CMD
ps -ax : -a all x 没有终端控制的进程
ps -xu jbossuser : -u 指定用户 -x 所有程序
ps -aux : USER PID %CPU %MEM  VSZ   RSS TTY      STAT START   TIME COMMAND
	--sort :-pcpu -pmem
	e.g.  ps -aux --sort -pcpu,+pmem | head -n 10
ps -fC java :查找java进程
	-L ：线程 可以跟pid查看线程数
ps -zxjf :类似 pstree
ps -eo pid,user,args ： -o 控制输出
	能够与-e 参数 一起使用的关键字是args, cmd, comm, command, fname, ucmd, ucomm, lstart, bsdstart 和 start
ps -U root -u root u ：-U 参数按真实用户ID(RUID)筛选进程，它会从用户列表中选择真实用户名或 ID；-u 参数用来筛选有效用户ID（EUID）；最后的u参数用来决定以针对用户的格式输出，由		User, PID, %CPU, %MEM, VSZ, RSS, TTY, STAT, START, TIME 和 COMMAND这几列组成。
	USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
watch -n 1 'ps -aux --sort -pmem, -pcpu |head 20'：动态
```

##### uptime

```shell
uptime
19:26:17 up 49 days,  7:34,  1 user,  load average: 0.67, 0.51, 0.41
最后三列，即系统1分钟、5分钟、15分钟 uptime命令显示的系统平均负载 / CPU核数，一般以0.7为比较合适的值。偏高说明有比较多的进程在等待使用CPU资源。
```

##### w

```shell
w
 10:05:24 up 141 days, 13:53,  1 user,  load average: 0.00, 0.02, 0.01
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
jbossuse pts/0    192.168.242.9    09:43    0.00s  0.07s  0.00s w
```

##### find

```shell
find / -type f -perm -2 -o -perm -20 |xargs ls -al
```

##### sar

```shell
#	https://www.cnblogs.com/howhy/p/6396437.html
sar -u 1 3	#cpu 1s 3次
sar -p 1 3 #每个CPU
sar -q #查看平均负载：
-o #output 二进制	#-f 读取
sar -r #内存
sar -W #查看系统swap分区的统计信息
sar -b #查看I/O和传递速率的统计信息
sar -d #磁盘使用详情统计
sar -v #进程、inode、文件和锁表状态
sar -n #统计网络信息
#sar -n选项使用6个不同的开关：DEV，EDEV，NFS，NFSD，SOCK，IP，EIP，ICMP，EICMP，TCP，ETCP，UDP，SOCK6，IP6，EIP6，ICMP6，EICMP6和UDP6 ，DEV显示网络接口信息，EDEV显示关于网络错误的统计数据，NFS统计活动的NFS客户端的信息，NFSD统计NFS服务器的信息，SOCK显示套接字信息，ALL显示所有5个开关。它们可以单独或者一起使用。
```

##### sort

```shell
-b	# 忽略每行前的空格
-u 	#去重
-t	#指定分隔符
-r	#反序
-n	#按数值大小
#	-n是按照数字大小排序，-r是以相反顺序，-k是指定需要爱排序的栏位，-t指定栏位分隔符为冒号
```

##### top

```shell
f或者F : 从当前显示中添加或者删除列。
o或者O : 改变显示项目的顺序。 
s:刷新时间间隔（s）
1: 显示多核cpu
l: 切换显示平均负载和启动时间信息。即显示影藏第一行
m：切换显示内存信息。即显示影响内存行
t ：切换显示进程和CPU状态信息。即显示影响CPU行
c：切换显示命令名称和完整命令行。 显示完整的命令。 这个功能很有用。
M ：根据驻留内存大小进行排序。
P：根据CPU使用百分比大小进行排序。
T： 根据时间/累计时间进行排序。
W： 将当前设置写入~/.toprc文件中。这是写top配置文件的推荐方法。
b：打开高亮
x：排序列 shift + > <	切换行
查看某一进程的所有线程 top -H -p <pid>

#	优先级
https://blog.csdn.net/longdel/article/details/7317511
PRI 	#越小越高
nice	#改变进程占用cpu百分比 root可set负值
PRI(new)=PRI(old)+nice
```

##### awk

```shell
两种形式
awk [-F ERE] [-v assignment] ... program [argument ...]
awk [-F ERE] -f progfile ...  [-v assignment] ...[argument ...]
awk [-F|-f|-v] 'BEGIN{} //{command1; command2} END{}' file
INPUT ：默认 \n 可以用内置变量RS更改
FIELD ：-F ERE 或者 内置变量FS更改	awk中可以用$0,$1,$2...(同shell 命令行参数)
内部变量：NR 行号 NF 行数
参数：
	-F ERE ：指定分隔符
		echo "1:2:3" | awk -F: '{print $1 " and " $2 " and " $3}'
		1 and 2 and 3
	-f program ：指定awk脚本
	-v assignment ：定义awk变量，同awk中的赋值，赋值发生在文本处理之前
		echo | awk -v a=1 'BEGIN {print a}'
		1
	argument ：输入文件 和 变量赋值
#	e.g.
awk 'NR==10' file.txt
#	转置文件
awk '{ for(i=1;i<=NF;i++){ if(NR==1){ arr[i]=$i; }else{ arr[i]=arr[i]" "$i; } } } END{ for(i=1;i<=NF;i++){ print arr[i]; } }'  file.txt	
#	统计词频
sed 's/\ /\n/g' words.txt|egrep -v '^$'|sort|uniq -c|sort -r|awk '{print $2,$1}'
awk '{ for(i=1;i<=NF;i++) {print $i}}' words.txt |sort|uniq -c|sort -n -r -k 1 -t ' '|awk -F ' ' {'print $2" "$1'}
# gsub
awk '{gsub(/\([0-9]+\)/,NONE);if($3>90||$4>85||$NF<10)print $1, "MountPoint: "$2, " DISK_USED "$3"%" ,"MEM_USED "$4,"CPU_IDLE "$NF,strftime("%Y%m%d%H%M%S")}' result
result: njjs-sys-hsc05be3431.njjs       0.070000(20190522110615)        26.530000(20190522110615)       9.830000(20190522110615)        96.000000(20190522110615)
```
##### grep

```shell
#	https://blog.csdn.net/hzjkb24/article/details/47104809	grep比较异同
#	https://blog.csdn.net/wzhwho/article/details/6169603
-niR 行号
-wvf 在后不在前
-BA num 前后
-E 正则（EREs）
-e 多项
-o 分片
```

##### date

```shell
date -d '2013-2-22 22:14' +%s
date -d @unix time
date -d @1361542596 +"%Y-%m-%d %H:%M:%S"
```

##### curl

```shell
-s 不显示 %等进度
-a append
-A "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36"
-x 10.19.110.55:8080 https://artifacts.elastic.co/downloads/logstash/logstash-6.1.3.tar.gz -O
-D cookie0001.txt 存储cookie
-b cookie 使用cookie
FTP
curl ftp://www.xxx.com/ --user name:passwd	//列出目录列表
curl ftp://www.xxx.com/ –u name:passwd #简洁写法
curl ftp://name:passwd@www.xxx.com #简洁写法2
curl ftp://www.xxx.com –u name:passwd -s	//只列出目录
curl ftp://www.xxx.com/size.zip –u name:passwd -o size.zip	//下载 -O保留文件名
curl –u name:passwd -T size.mp3 ftp://www.xxx.com/mp3/	//上传
curl –u name:passwd ftp://www.xxx.com/ -X 'DELE mp3/size.mp3'	//删除
curl -X GET/PORT/DELETER 
```

##### rsync

```shell
rsync -a /data /backup	# -a = -rtopgDl
rsync -avz *.c foo:src	#远程机器
rsync -av root@ip::www /databack #rsync服务器
```

##### tar

```shell
tar -ztvf log.tar.gz 不解压查看文件
tar -zxvf log.tar.gz 1.log 解压包内部分文件
tar -cvf log.tar log2012.log    仅打包，不压缩！ 
tar -zcvf log.tar.gz log2012.log   打包后，以 gzip 压缩 
tar -jcvf log.tar.bz2 log2012.log  打包后，以 bzip2 压缩 
tar --exclude scf/service -zcvf scf.tar.gz scf/* 排除
```

##### netstat

```shell
-a或--all：显示所有连线中的Socket；
-A<网络类型>或--<网络类型>：列出该网络类型连线中的相关地址；
-c或--continuous：持续列出网络状态；
-C或--cache：显示路由器配置的快取信息；
-e或--extend：显示网络其他相关信息；
-F或--fib：显示FIB；
-g或--groups：显示多重广播功能群组组员名单；
-h或--help：在线帮助
-i或--interfaces：显示网络界面信息表单；
-l或--listening：显示监控中的服务器的Socket；
-M或--masquerade：显示伪装的网络连线；
-n或--numeric：直接使用ip地址，而不通过域名服务器；
-N或--netlink或--symbolic：显示网络硬件外围设备的符号连接名称；
-o或--timers：显示计时器；
-p或--programs：显示正在使用Socket的程序识别码和程序名称；
-r或--route：显示Routing Table；
-s或--statistice：显示网络工作信息统计表；
-t或--tcp：显示TCP传输协议的连线状况；
-u或--udp：显示UDP传输协议的连线状况；
-v或--verbose：显示指令执行过程；
-V或--version：显示版本信息；
-w或--raw：显示RAW传输协议的连线状况；
-x或--unix：此参数的效果和指定"-A unix"参数相同；
--ip或--inet：此参数的效果和指定"-A inet"参数相同。
**IP和TCP分析
#	查看连接某服务端口最多的的IP地址：
netstat -ntu | grep :80 | awk '{print $5}' | cut -d: -f1 | awk '{++ip[$1]} END {for(i in ip) print ip[i],"\t",i}' | sort -nr
#	TCP各种状态列表：
netstat -nt | grep -e 127.0.0.1 -e 0.0.0.0 -e ::: -v | awk '/^tcp/ {++state[$NF]} END {for(i in state) print i,"\t",state[i]}'
#	查看phpcgi 进程 数，如果接近预设值，说明不够用，需要增加：
netstat -anpo | grep "php-cgi" | wc -l
#	查看 端口 进程
netstat -anp
```

##### ss

```shell
-h：显示帮助信息；
-V：显示指令版本信息；
-n：不解析服务名称，以数字方式显示；
-a：显示所有的套接字；
-l：显示处于监听状态的套接字；
-o：显示计时器信息；
-m：显示套接字的内存使用情况；
-p：显示使用套接字的进程信息；
-i：显示内部的TCP信息；
-4：只显示ipv4的套接字；
-6：只显示ipv6的套接字；
-t：只显示tcp套接字；
-u：只显示udp套接字；
-d：只显示DCCP套接字；
-w：仅显示RAW套接字；
-x：仅显示UNIX域套接字。
ss -t -a # TCP
#	查看端口进程占用
ss
```

##### ip

```shell
-V：显示指令版本信息；
-s：输出更详细的信息；
-f：强制使用指定的协议族；
-4：指定使用的网络层协议是IPv4协议；
-6：指定使用的网络层协议是IPv6协议；
-0：输出信息每条记录输出一行，即使内容较多也不换行显示；
-r：显示主机时，不使用IP地址，而使用主机的域名。
 ip -s link list #
 ip route list  #显示核心路由表
 ip neigh list #显示邻居表
```

##### lsof

```shell
默认：没有选项，lsof列出活跃进程的所有打开文件
	-a ： 与运算 （默认或）
	-l :
	-i :
#	查看端口进程占用
```

#####	time

```shell
#	st_atime           
Time when file data was last accessed. Changed by  the           following   functions:   creat(),   mknod(),   pipe(),           utime(2), and read(2).
#	st_mtime           
Time when data was last modified. Changed by the  fol           lowing  functions:  creat(), mknod(), pipe(), utime(),           and write(2).
#	st_ctime           
Time when file status was last changed. Changed by the           following   functions:   chmod(),   chown(),  creat(),           link(2),  mknod(),  pipe(),  unlink(2),  utime(),  and           write().

```

##### chage

```shell
-m：密码可更改的最小天数。为零时代表任何时候都可以更改密码。-1
-M：密码保持有效的最大天数
-w：用户密码到期前，提前收到警告信息的天数。
-E：帐号到期的日期。过了这天，此帐号将不可用。-1
-d：上一次更改的日期。-1
-i：停滞时期。如果一个密码已过期这些天，那么此帐号将不可用。
-l：例出当前的设置。由非特权用户来确定他们的密码或帐号何时过期。
```

##### sed

```shell
sed -n Np file
sed -n 's///p' file --显示修改的行
sed -i '3s/aaa/fff/' file --表示针对file文件中的第三行，将其中的aaa替换为fff
sed -i '/xxx/s/aaa/fff/g' file --表示针对文件，找出包含xxx的行，并将其中的aaa替换为fff
sed -i '1s/[#*]/fff/gp' file --表示针对文件第1行，将其中的#号或是*号替换为fff
g 全替换 p 打印 w file，将替换的结果写到文件中
```

##### wait

```shell
wait [作业指示或进程号]
1.等待作业号或者进程号制定的进程退出，返回最后一个作业或进程的退出状态状态。如果没有制定参数，则等待所有子进程的退出，其退出状态为0.
2.如果是shell中等待使用wait，则不会等待调用函数中子任务。在函数中使用wait，则只等待函数中启动的后台子任务。
wait $! #$!表示上个子进程的进程号，wait等待一个子进程，等待5秒后，退出
3.在shell中使用wait命令，相当于高级语言里的多线程同步。
e.g. :函数中使用wait
#!/bin/bash
source ~/.bashrc
 
fun(){
    echo "fun is begin.timeNum:$timeNum"
    local timeNum=$1
    sleep $timeNum &
    wait #这个只等待wait前面sleep
    
    echo "fun is end.timeNum:$timeNum"
}
 
fun 10 &
fun 20 &
 
wait #如果fun里面没有wait，则整个脚本立刻退出，不会等待fun里面的sleep
echo "all is ending"
e.g. :shell中使用wait
#!/bin/bash
sleep 10 &
sleep 5&
wait #等待10秒后，退出
#!/bin/bash
sleep 10 &
sleep 5&
wait $! #$!表示上个子进程的进程号，wait等待一个子进程，等待5秒后，退出
```

##### eval

```shell

```

##### nc

```shell
# 监听端口
nc -lp 8888
# 连接端口
nc -vz -w 5 127.0.0.1 8888
# 端口扫描
nc -vz -w 5 127.0.0.1 1-100
# 远程拷贝文件
server:	nc -lp 1234 > install.log
server:	nc -w 1 192.168.228.222 1234 < install.log
# 克隆硬盘或分区
nc -l -p 1234 | dd of=/dev/sda
dd if=/dev/sda | nc 192.168.228.222 1234
# 保存web页面
while true; do
    nc -l -p 80 -q 1 < somepage.html;
done
# 聊天
nc -lp 1234
nc 192.168.228.222 1234
# 传输目录
nc -l 1234 | tar xzvf -
tar czvf – nginx-0.6.34 | nc 192.168.228.222 1234
```

##### du

```shell
du -sh *
```

##### mail

```shell
export LANG="en_US.UTF-8" #mail 避免生成ATT文件
# mail by file
mail -s "Hello from linuxde.net by shell" admin@linuxde.net <{filename}
# mail by pipe
echo "hello,this is the content of mail.welcome to www.linuxde.net" | mail -s "Hello from linuxde.net by pipe" admin@linuxde.net
```

##### jq

```shell
# https://www.ibm.com/developerworks/cn/linux/1612_chengg_jq/index.html
jq -r '.[]|select(.>2)'
```

##### 基础

```shell
echo 
	-e 转义字符处理，比如\t显示为制表符而不是显示输出\t
	-n 把文本字符串和命令输出显示在同一行中
##### cat追加 ： cat>file<<EOF"start:"EOF
##### 运算
result=$(expr 5 + 5) 注意点：*乘法运算符号需要转义
result=$[5 + 5] 
let i++ ; let i-- ; let i+=10 ; let i-=10
##### 判断
if [ x$1 = x];then
    no key;
elif [];then
else
fi
数值比较 ：-eq	-ge -gt -le -lt -ne 
字符比较 ：= !=  < > -n(字符串长度非0) -z(字符串长度为0)
文件比较 ：-d(directory) -e(exit) -f(file) -r(read) -s(存在且非空) -w(write) -x(execut) -O(是否存在且属当前用户) -G(存在且默认组与当前用户相同) -nt(newer than) -ot(older than) 
##### 循环
for
	c : for (( i = 0; i < 10; i++ )); do  CODE   ;done
	in : for line in $(cat $file);do  CODE  ;done
while [[ i -lt 10 ]]; do
	CODE
done
until [[ i -lt 10 ]]; do
	CODE
done
```

##### 函数

```shell
function func1 {
}
func2(){
	echo $1,$2
}
return 最大返回256，表示结果码，有特殊含义，并且只能返回数值
参数的获取使用$1,$2以此类推，特别地$0表示文件名、$#表示参数的个数
```

#####  数组

```shell
array_name=(value0 value1 value2 value3)	#从0开始
#读取
${数组名[下标]}
# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}
#### 可做子串切分
```

##### 字典

```shell
#必须先声明
declare -A dic
dic=([key1]="value1" [key2]="value2" [key3]="value3")

#打印指定key的value
echo ${dic["key1"]}
#打印所有key值
echo ${!dic[*]}
#打印所有value
echo ${dic[*]}
#字典添加一个新元素
dic+=（[key4]="value4"）

#遍历key值
for key in $(echo ${!dic[*]})
do
    echo "$key : ${dic[$key]}"
done
```

##### 读取

```shell
$IFS是文件循环处理的分隔符，按按行处理数据需要把该值设置为$'\n'，处理完成之后恢复旧值
echo "=======循环for in======="file="data"
IFS_OLD=$IFS
IFS=$'\n'
for line in $(cat $file)
do
	echo "${line}"
done
IFS=${IFS_OLD}# 输出：=======
```

##### 模块

```shell
##### 流程模块
处理参数使用getopts命令实现，getopts optionstring opt其中optionstring格式:i:o:，i和o之后的:表示指定i选项和o选项需要有参数，第一个:表示忽略错误，使用case分支处理参数选项对应的参数值。
# 参数解析echo "参数>>${@}"while getopts :i:o: optdo
	case "$opt" in
		i) param_input_dir=$OPTARG
			echo "Found the -i option, with parameter value $OPTARG"
			;;
		o) param_output_file=$OPTARG
			echo "Found the -o option, with parameter value $OPTARG"
			;;
		*) echo "Unknown option: $opt";;	esacdoneecho "param_input_dir = ${param_input_dir}"echo "param_output_file = ${param_output_file}"
##### 菜单模块
read -n 1 option命令中用了-n选项来限制只读取一个字符
clear命令是用来清空命令行的屏幕的
echo -e -e 选项用来处理转义字符
echo -en -n 选项让光标处于同一行，用户的输入会显示在同一行
使用while循环获取用户的输入，在while循环中使用case分支处理不同的操作
```

##### 内存检查

###### 系统swap内存检查

```
# Modified by Mikko Rantalainen 2012-08-09
# Pipe the output to "sort -nk3" to get sorted output
# Modified by Marc Methot 2014-09-18
# removed the need for sudo


SUM=0
OVERALL=0
for DIR in `find /proc/ -maxdepth 1 -type d -regex "^/proc/[0-9]+"`
do
    PID=`echo $DIR | cut -d / -f 3`
    PROGNAME=`ps -p $PID -o comm --no-headers`
for SWAP in `grep VmSwap $DIR/status 2>/dev/null | awk '{ print $2 }'`
do
    let SUM=$SUM+$SWAP
done
if (( $SUM > 0 )); then
    echo "PID=$PID swapped $SUM KB ($PROGNAME)"
fi
let OVERALL=$OVERALL+$SUM
SUM=0
done
echo "Overall swap used: $OVERALL KB"
```

##### tcpdump

```shell
tcpdump
	-s 0 //忽略大小
	-c num //抓（符合条件）包数量
	-i interface //监听接口 -i eth0
	-n //地址数字形式显示
	-w 写入文件
tcpdump -i eth0 -vnn src host 8.8.8.8 and dst port 22
tcpdump -s 0 dst net ip and tcp port 80 -c 10 -w cap.cap
tcpdump -i eth0 -s 0 tcp port 80 -c 100 -w capt.cap	#抓80
tcpdump -i eth0 -s 0 tcp[20:2]=0x504f -c 100 -w capt.cap	#抓post
tcpdump -i eth0 -vnn \( src host 8.8.8.8 and dst port 22 \) or   \( src host 4.4.4.4 and dst port 80 \)
tcpdump 'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'	#打印所有源或目的端口是80, 网络层协议为IPv4, 并且含有数据,而不是SYN,FIN以及ACK-only等不含数据的数据包
```

##### 实用命令

```shell
#   jboss password加密
/opt/wildfly/java64/jdk1.7.0_25/bin/java -cp /opt/wildfly/modules/system/layers/base/org/picketbox/main/picketbox-4.0.21.Beta1.jar:/opt/wildfly/modules/system/layers/base/org/jboss/logging/main/jboss-logging-3.1.4.GA.jar:/opt/wildfly/java64/jdk1.7.0_25/lib/ org.picketbox.datasource.security.SecureIdentityLoginModule PAAWORD

#   ssh 免yes	超时	次数	跳过密码输入
-o stricthostkeychecking=no -o ConnectTimeout=3  -o ConnectionAttempts=3 -o PasswordAuthentication=no

#   FTP
ftp -inv 10.105.73.170 <<!
user username password
bin
cd soft/sndp/
put
!

#   下载
wget ftp://liucf/cache/
wget -r -nd -m $Log_url/package && unzip ./$software && rm -f ./$software

#   上传
curl -T   $file  ftp://192.168.241.12/17liucf/cache/ -u user:passwd

#   追加
cat>>1.list<<EOF
EOF
#    javacore & dump
收集topCPU及javacore：
top -H -p <pid> -b -n1 >> dump_high_cpu.txt;/opt/jboss/java64/jdk1.7.0_25/bin/jstack <pid> > javacore.txt
收集dump：
/opt/jboss/java64/jdk1.7.0_25/bin/jmap -dump:format=b,file=heap.prof <pid>

#   loop
for ip in  `cat ip.conf`;do command;done
for ip in 1 2 3 4 5 ;do command;done
cat ip.conf | while read ip ;do command & wait;done

#	文本三剑客
#	sed
sed -n Np file
sed -i '3s/aaa/fff/' file --表示针对file文件中的第三行，将其中的aaa替换为fff
sed -i '/xxx/s/aaa/fff/g' file --表示针对文件，找出包含xxx的行，并将其中的aaa替换为fff
sed -i '1s/[#*]/fff/gp' file --表示针对文件第1行，将其中的#号或是*号替换为fff

#   Thread

# 	if case while
#	if脚本参数
if [ x$1 = x];then
    no key;
elif [];then

else

fi

数值比较 ：-eq	-ge -gt -le -lt -ne 
字符比较 ：= !=  < > -n(字符串长度非0) -z(字符串长度为0)
文件比较 ：-d(directory) -e(exit) -f(file) -r(read) -s(存在且非空) -w(write) -x(execut) -O(是否存在且属当前用户) -G(存在且默认组与当前用户相同) -nt(newer than) -ot(older than) 

# for

# chage 密码延期

# unix time
date

#	nc
#	netstat
#	ps top
#	lsof
#	du
#	find which rsync
#	sort wc
#	tee
```

##### core dump

```shell
kill -SIGABRT pid 即可产生core dump
gdb $coredump_PATH/coredump
$java_HOME/jstack $java_HOME/java $coredump_PATH/coredump
$java_HOME/jmap $java_HOME/java $coredump_PATH/coredump
```

##### kill

```shell
kill -l
 1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL
 5) SIGTRAP      6) SIGABRT      7) SIGBUS       8) SIGFPE
 9) SIGKILL     10) SIGUSR1     11) SIGSEGV     12) SIGUSR2
13) SIGPIPE     14) SIGALRM     15) SIGTERM     16) SIGSTKFLT
17) SIGCHLD     18) SIGCONT     19) SIGSTOP     20) SIGTSTP
21) SIGTTIN     22) SIGTTOU     23) SIGURG      24) SIGXCPU
25) SIGXFSZ     26) SIGVTALRM   27) SIGPROF     28) SIGWINCH
29) SIGIO       30) SIGPWR      31) SIGSYS      34) SIGRTMIN
35) SIGRTMIN+1  36) SIGRTMIN+2  37) SIGRTMIN+3  38) SIGRTMIN+4
39) SIGRTMIN+5  40) SIGRTMIN+6  41) SIGRTMIN+7  42) SIGRTMIN+8
43) SIGRTMIN+9  44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12
47) SIGRTMIN+13 48) SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14
51) SIGRTMAX-13 52) SIGRTMAX-12 53) SIGRTMAX-11 54) SIGRTMAX-10
55) SIGRTMAX-9  56) SIGRTMAX-8  57) SIGRTMAX-7  58) SIGRTMAX-6
59) SIGRTMAX-5  60) SIGRTMAX-4  61) SIGRTMAX-3  62) SIGRTMAX-2
63) SIGRTMAX-1  64) SIGRTMAX
```

##### iptables

```shell
iptables -FXZ
```

##### 内核参数

```shell

```

##### sysctl

```shell
#	sysctl.conf
net.ipv4.ip_forward = 1
#
echo "1" > /proc/sys/net/ipv4/ip_forward
#
sysctl -w net.ipv4.ip_forward = 1	# write
sysctl -p
ARP抑制
echo "1">/proc/sys/net/ipv4/conf/lo/arp_ignore
echo "2">/proc/sys/net/ipv4/conf/lo/arp_announce 
echo "1">/proc/sys/net/ipv4/conf/all/arp_announce
echo "2">/proc/sys/net/ipv4/conf/all/arp_announce
```

##### wget

```shell
wget -x ./download/package/ -r -nd -m $ES_url -P ./download/package/
wget -o 
wget -c continue
wget -x 强制创建目录
wget -r 递归
wget -m mirror
wget -P 将文件保存到目录
wget -l,  --level=NUMBER       最大递归深度
```

##### 变量

```shell
$#	个数
$*	所有参数当成一个参数
$@	所有参数
```





