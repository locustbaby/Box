##### kubeadm

```shell
# 参考
https://feisky.gitbooks.io/kubernetes/deploy/kubeadm.html#%E5%AE%89%E8%A3%85-master
https://blog.csdn.net/hanyren/article/details/103204161?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-7.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-7.nonecase
```

##### kubeadm 搭建单master k8s集群

```bash
# kubeadm 官方文档 https://v1-17.docs.kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
# 基础环境 Centos 7.3
# 关闭selinux
setenforce 0
[root@master ~]# cat /etc/selinux/config 

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of three two values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected. 
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted 

# 关闭防火墙
systemctl disable firewalld && systemctl stop firewalld

# 配置 ali yum源
cat <<EOF > kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
mv kubernetes.repo /etc/yum.repos.d/k8s.repo 

# 安装基础组件
yum install -y docker kubelet kubeadm kubectl kubernetes-cni

#FIX: docker启动失败 
ip link add name docker0 type bridge
ip addr add dev docker0  172.17.0.1/16
ip link set docker0 up

# 启动docker & kubelet
systemctl enable docker && systemctl start docker
systemctl enable kubelet && systemctl start kubelet

# 修改网络转发
sysctl -w net.bridge.bridge-nf-call-iptables=1
echo "net.bridge.bridge-nf-call-iptables=1" > /etc/sysctl.d/k8s.conf

# 关闭swap
swapoff -a && sed -i '/ swap / s/^/#/' /etc/fstab

# 起集群
nohup kubeadm init --pod-network-cidr 10.244.0.0/16 --kubernetes-version=v1.18.1 --image-repository registry.aliyuncs.com/google_containers
# 指定配置文件
export KUBECONFIG=/etc/kubernetes/admin.conf

# 命令检验
kubectl get po -n kube-system

# 其他节点接入(from kubeadm init，注意保留)
kubeadm join 192.168.199.214:6443 --token $token \
    --discovery-token-ca-cert-hash sha256:$sha

## FIX补充

# kubelet 无法启动问题
[root@master ~]# cat /usr/lib/systemd/system/docker.service
[Unit]
Description=Docker Application Container Engine
Documentation=http://docs.docker.com
After=network.target
Wants=docker-storage-setup.service
Requires=docker-cleanup.timer

[Service]
Type=notify
NotifyAccess=main
EnvironmentFile=-/run/containers/registries.conf
EnvironmentFile=-/etc/sysconfig/docker
EnvironmentFile=-/etc/sysconfig/docker-storage
EnvironmentFile=-/etc/sysconfig/docker-network
Environment=GOTRACEBACK=crash
Environment=DOCKER_HTTP_HOST_COMPAT=1
Environment=PATH=/usr/libexec/docker:/usr/bin:/usr/sbin
ExecStart=/usr/bin/dockerd-current \
          --add-runtime docker-runc=/usr/libexec/docker/docker-runc-current \
          --default-runtime=docker-runc \
          # kubelet与docker 驱动不同，修改docker驱动为cgroupfs
          --exec-opt native.cgroupdriver=cgroupfs \
          --userland-proxy-path=/usr/libexec/docker/docker-proxy-current \
          --init-path=/usr/libexec/docker/docker-init-current \
          --seccomp-profile=/etc/docker/seccomp.json \
          $OPTIONS \
          $DOCKER_STORAGE_OPTIONS \
          $DOCKER_NETWORK_OPTIONS \
          $ADD_REGISTRY \
          $BLOCK_REGISTRY \
          $INSECURE_REGISTRY \
          $REGISTRIES
ExecReload=/bin/kill -s HUP $MAINPID
LimitNOFILE=1048576
LimitNPROC=1048576
LimitCORE=infinity
TimeoutStartSec=0
Restart=on-abnormal
KillMode=process

[Install]
WantedBy=multi-user.target

# Failed to start ContainerManager failed to initialize top level QOS containers: failed to update top level BestEffort QOS cgroup : failed to set supported cgroup subsystems for cgroup [kubepods besteffort]: failed to find subsystem mount for required subsystem: pids

具体错误原因参考：https://github.com/kubernetes/kubernetes/issues/79046
kubelet配置参考：https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/

解决方法：
1）找到kubelet启动配置文件：find / name kubelet
2）修改配置文件：vim /etc/sysconfig/kubelet
3）KUBELET_EXTRA_ARGS="--feature-gates SupportPodPidsLimit=false --feature-gates SupportNodePidsLimit=false"
```

