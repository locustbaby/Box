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
gather_subnet = all
remote_port & remote_tmp & remote_user
sudo_exe & sudo_flags & sudo_user
action_plugins & callback_plugins & connection_plugins & filter_plugins & lookup_plugins & vars_plugins # 激活事件 回调 连接 过滤器 加载路径 任何地方加载
forks # cpu * 2
module_name # 默认模块 command，不支持shell变量，管道，配额  改为shell
vault_password_file # 
pattern # 默认主机组
inventory # 
library # 默认模块搜索路径
# privilege_escalation 执行命令的用户权限设置
# paramiko_connection paramika插件设置
# ssh_connection ssh连接设置
# accelerate
# selinx & colors
```

