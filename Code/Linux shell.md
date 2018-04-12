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

