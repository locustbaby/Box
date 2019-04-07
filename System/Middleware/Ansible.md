#### Ansible

##### 配置文件路径

```shell
export ANSIBLE_CONFIG
./ansible.cfg
~/.ansible.cfg
/etc/ansible/ansible.cfg
```

##### 配置详解

```shell
分组
# defaults
ask_pass
ask_sudo_pass
gather_subnet = all	#all, network, hardware, virtual, facter, ohai
remote_port & remote_tmp & remote_user	#端口 临时目录 用户
sudo_exe & sudo_flags & sudo_user	#sudo命令路径 参数 
action_plugins & callback_plugins & connection_plugins & filter_plugins & lookup_plugins & vars_plugins # 激活事件 回调 连接 过滤器 加载路径 任何地方加载
forks # cpu * 2
module_name # 默认模块 command，不支持shell变量，管道，配额  推荐改为shell
vault_password_file # 如果使用脚本，确保密码可以输出到标准输出
pattern # 默认主机组
inventory # 可通行主机的目录
library # 默认模块搜索路径
# privilege_escalation 执行命令的用户权限设置
# paramiko_connection paramika插件设置
# ssh_connection ssh连接设置
# accelerate
# selinux & colors
```

##### 基本命令

```shell
ansible -m[模块] -a 指定传入模块的参数 -C -D 检查hosts文件的修改 -l 限制匹配规则的主机数 --list-hosts 显示匹配主机数 -m -M 指定使用的模块和模块的路径 --syntax-check 检查语法 -v 输出
ansible all[正则] -m ping #测试连通性
ansible ip -a ''
```

#####  inventory

```shell
[groupname] #分组管理 /etc/ansible/hosts
ip
ip:port
jumper ansible_ssh_port=5550 ansible_ssh_host=ip ansible_ssh_user=opsuser
vim[1:50].example.com
# inventory 参数
ansible_sudo_pass ssh $passwd
ansible_sudo_pass sudo $passwd
ansible_sudo_exe
ansible_connection local/ssh/paramiko
ansible_ssh_private_key_file
# 分文件管理
/etc/ansible/group_vars/vim
/etc/ansible/group_vars/webuser
	# 文件内容（文件夹名为组名）
	---
	ip
# Patterns [从左到右依次匹配]
all / *
ansible 192.168.1.* -m ping #连续
ansible ip:ip -m 
ansible $groupname
ansible webservers:!phoenix #在 web组 不在phonex组
ansible webservers:&nginx #并集
```

##### playbook

```shell
#	/etc/ansible/*.yml
Ad-Hoc # 临时命令
ansible atlanta -a -u username --sudo "/sbin/reboot/" -f 10 (10个子进程)
ansible webservers -m file -a "dest=/path/to/c mode=755 owner=maehaan group=maehaan state=directory" # 创建目录
ansible atlana -m copy -a "src=/etc/hosts dest=/tmp/hosts" # 拷贝文件
ansible # 包管理
# git模块
# service模块
ansible all -B 3600 -P 0 -a "code" # -B 秒 -P 0 不获取状态（每0分钟获取状态）
```

> Playbook.yaml

```shell
---
- hosts: webservers
  vars:
    http_port: 80
    max_clients: 200
  remote_user: root
  tasks:
  - name: ensure apache is at the latest version
    yum: pkg=httpd state=latest
  - name: write the apache config file
    template: src=/srv/httpd.j2 dest=/etc/httpd.conf
    notify:
    - restart apache
  - name: ensure apache is running
    service: name=httpd state=started
  handlers:
    - name: restart apache
      service: name=httpd state=restarted
```

