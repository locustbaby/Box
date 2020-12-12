#####  I/O

```
标准文件描述符--指代打开的文件
	POSIX名称
0	STDIN_FILENO
1	STDOUT_FILENO
2	STDERR_FILENO
```

系统调用

```
fd = open(pathname, flags, mode)
numread = read(fd, buffer, count)
numwritten = write(fd, buffer, count)
status = close(fd)
```

文件描述符和打开文件之间的关系

```

针对进程，内核为其维护打开文件的描述符表，每条记录单个文件描述符的相关信息：
	控制文件描述符操作的一组标志（目前仅 close-on-exec）
	对打开文件句柄的引用

内核对所有打开的文件维护有一个 系统级的描述表格（打开文件表），条目称为打开文件句柄，每个打开文件句柄存储了 与一个打开文件相关的全部信息：
	当前文件偏移量（调用read和write时更新，或使用lseek直接修改）
	打开文件时所使用的状态标志（open的flags参数）
	文件访问模式（open时设置的只读，只写，读写）
	与信号驱动I/O相关的设置
	对该文件i-node对象的引用
	
每个文件系统都会为驻留其上的所有文件建立一个 i-node表，i-node信息：
	文件类型（例如：常规文件、套接字或FIFO）和访问权限
	一个指针，指向该文件所持有的锁的列表
	文件的各种属性，包括文件大小以及与不同类型操作相关的时间戳
    
    ps：
    inode：
    	文件类型（比如：常规文件 目录 符号链接以及字符设备等）
    	文件属主（UID）
    	文件属组（GID）
    	3类用户的访问权限
    	3个时间戳（atime mtime ctime）
    	指向文件的硬链接数量
    	文件的大小，以字节为单位
    	实际分配给文件的块数量
    	指向文件数据块的指针
```

