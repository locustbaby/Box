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

##### top

```shell
f或者F :从当前显示中添加或者删除项目。
o或者O  :改变显示项目的顺序。
s:刷新时间间隔（s）
1: 显示多核cpu
l: 切换显示平均负载和启动时间信息。即显示影藏第一行
m： 切换显示内存信息。即显示影藏内存行
t ： 切换显示进程和CPU状态信息。即显示影藏CPU行
c：  切换显示命令名称和完整命令行。 显示完整的命令。 这个功能很有用。
M ： 根据驻留内存大小进行排序。
P：根据CPU使用百分比大小进行排序。
T： 根据时间/累计时间进行排序。
W：  将当前设置写入~/.toprc文件中。这是写top配置文件的推荐方法。
查看某一进程的所有线程 top -H -p <pid>
```

##### awk

```shell
两种形式
awk [-F ERE] [-v assignment] ... program [argument ...]
awk [-F ERE] -f progfile ...  [-v assignment] ...[argument ...]
INPUT ：默认 \n 可以用内置变量RS更改
FIELD ：-F ERE 或者 内置变量FS更改	awk中可以用$0,$1,$2...(同shell 命令行参数)

参数：
	-F ERE ：指定分隔符
		echo "1:2:3" | awk -F: '{print $1 " and " $2 " and " $3}'
		1 and 2 and 3
	-f program ：指定awk脚本
	-v assignment ：定义awk变量，同awk中的赋值，赋值发生在文本处理之前
		echo | awk -v a=1 'BEGIN {print a}'
		1
	argument ：输入文件 和 变量赋值
```
##### date

```shell
date -d '2013-2-22 22:14' +%s
date -d @unix time
date -d @1361542596 +"%Y-%m-%d %H:%M:%S"
```

##### curl

```shell
-a append
-A "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36"
-x 10.19.110.55:8080 https://artifacts.elastic.co/downloads/logstash/logstash-6.1.3.tar.gz -O
-D cookie0001.txt 存储cookie
-b cookie 使用cookie
```

##### tar

```shell
tar -ztvf log.tar.gz 不解压查看文件
tar -zxvf log.tar.gz 1.log 解压包内部分文件
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
查看连接某服务端口最多的的IP地址：
netstat -ntu | grep :80 | awk '{print $5}' | cut -d: -f1 | awk '{++ip[$1]} END {for(i in ip) print ip[i],"\t",i}' | sort -nr
TCP各种状态列表：
netstat -nt | grep -e 127.0.0.1 -e 0.0.0.0 -e ::: -v | awk '/^tcp/ {++state[$NF]} END {for(i in state) print i,"\t",state[i]}'
**查看phpcgi进程数，如果接近预设值，说明不够用，需要增加：
netstat -anpo | grep "php-cgi" | wc -l
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
sed -i '3s/aaa/fff/' file --表示针对file文件中的第三行，将其中的aaa替换为fff
sed -i '/xxx/s/aaa/fff/g' file --表示针对文件，找出包含xxx的行，并将其中的aaa替换为fff
sed -i '1s/[#*]/fff/gp' file --表示针对文件第1行，将其中的#号或是*号替换为fff
g 全替换 p 打印 w file，将替换的结果写到文件中
```

##### 基础

```shell
echo 
	-e 转义字符处理，比如\t显示为制表符而不是显示输出\t
	-n 把文本字符串和命令输出显示在同一行中
##### 运算
result=$(expr 5 + 5) 注意点：*乘法运算符号需要转义
result=$[5 + 5] 
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

##### 读取

```shell
$IFS是文件循环处理的分隔符，按按行处理数据需要把该值设置为$'\n'，处理完成之后恢复旧值
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



