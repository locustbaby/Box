

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
result: hostname       0.070000(20190522110615)        26.530000(20190522110615)       9.830000(20190522110615)        96.000000(20190522110615)
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

##### sed

```shell
sed -n Np file
sed -n 's///p' file --显示修改的行
sed -i '3s/aaa/fff/' file --表示针对file文件中的第三行，将其中的aaa替换为fff
sed -i '/xxx/s/aaa/fff/g' file --表示针对文件，找出包含xxx的行，并将其中的aaa替换为fff
sed -i '1s/[#*]/fff/gp' file --表示针对文件第1行，将其中的#号或是*号替换为fff
g 全替换 p 打印 w file，将替换的结果写到文件中
```

##### tr

```bash

```

##### tee

```bash

```

