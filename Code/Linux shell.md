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
ps -U root -u root u ：-U 参数按真实用户ID(RUID)筛选进程，它会从用户列表中选择真实用户名或 ID；-u 参数用来筛选有效用户ID（EUID）；最后的u参数用来决定以针对用户的格式输出
	USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
watch -n 1 ‘ps -aux --sort -pmem, -pcpu |head 20’ ：动态
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

