pxe+dhcp+nfs+KickStart

```shell
#	配置NFS服务器 用于存放安装文件 

#	配置TFTP服务器，用于提供客户端PXE引导所必须的文件 
	/mnt/images/vmlinuz initrd.img 
	/mnt/isolinux/isolinux.cfg -> pxelinux.cfg/default
	#	cat default
	append ks=nfs:ip:/data/.../ks.cfg initrd.img text
#	配置DHCP，用于给客户端提供IP地址及其他信息 
	allow booting
	next-server ->本机ip
	filename "pxelinux.0"	#filename "pxelinux.0"; 　　#pxelinux 启动文件位置;
#	配置kickstart，用于自动应答安装 使用PXE功能引导客户机 

```

​	

