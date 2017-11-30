# [Jboss](https://docs.jboss.org/author/display/WFLY9/Admin+Guide)
概述
一、安装部署
	1.1系统信息
	1.2安装准备
		1.2.1准备安装包
		1.2.2用户
		参数优化
		DNS
		修改hosts
	1.3开始安装
		Jdk
		Jboss安装
			解压即可，无需安装
目录结构
		环境变量
	1.4启动
		配置cli配置文件   待研究
		备份所有初始配置文件
		Standalone
			原理
			启动
		Domain
			原理
			启动
		启动脚本
二、控制台用户和角色分配
	用户添加
		控制台
		Add-user.sh
		集群成员添加联合
	Server配置
	jvm参数
		-Xms：设置jvm内存的初始大小
        -Xmx：设置jvm内存的最大值
        -Xmn：设置新域的大小（这个似乎只对 jdk1.4来说是有效的，后来就废弃了）
        -Xss：设置每个线程的堆栈大小(也就是说,在相同物理内存下，减小这个值能生成更多的线程)
        -XX：NewRatio :设置新域与旧域之比，如-XX：NewRatio = 4就表示新域与旧域之比为1：4
        -XX:NewSize：设置新域的初始值
        -XX:MaxNewSize ：设置新域的最大值
        -XX:PermSize：设置永久域的初始值
        -XX:MaxPermSize：设置永久域的最大值
        -XX:SurvivorRatio=n:设置新域中Eden区与两个Survivor区的比值。（Eden区主要是用来存放新生的对象，而两个 Survivor区则用来存放每次垃圾回收后存活下来的对象）
	日志轮询 .xml
	线程池
	MQ
	MQ连接工厂
	数据源配置 mysql sqlserver	validation
	LDAP
	与apache联合 mod_cluster
	应用部署
	Q&A
	
