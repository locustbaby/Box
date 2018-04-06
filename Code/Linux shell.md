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

