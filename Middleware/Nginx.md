#### Nginx

```shell
# 内核优化
vi /etc/sysctl.conf

fs.file-max = 999999	#进程可以同时打开的最大句柄数（最大并发）
net.ipv4.tcp_tw_reuse = 1	#允许将TIME-WAIT的socket重新用于新的TCP
net.ipv4.tcp_keepalive_time = 600	#TCP发送keeplive消息的频度
net.ipv4.tcp_fin_timeout = 30	#当服务器主动关闭连接时，socket保持在FIN-WAIT-2状态的最大时间
net.ipv4.tcp_max_tw_buckets = 5000	#TIME_WAIT套接字数量最大值，超过会立即清除
net.ipv4.ip_local_port_range = 1024 61000	#UDP TCP连接中本地端口取值范围
net.ipv4.tcp_rmem = 4096 32768 262142	#TCP接收缓存 最小 默认 最大
net.ipv4.tcp_wmem = 4096 32768 262142	#TCP发送缓存 
net.core.netdev_max_backlog = 8096	#网卡接收数据包的速度大于内核处理速度时，会有一个队列保存这些数据，队列最大值
net.core.rmem_default = 262144	#内核套接字接收缓存区默认大小
net.core.wmem_default = 262144	#发送缓存区
net.core.rmem_max = 2097152	#内核套接字接收缓存区最大大小
net.core.wmem_max = 2097152	#内核套接字发送缓存区最大大小
# 上述四个参数需要根据业务特性和实际硬件成本来考虑
net.ipv4.tcp_syncookies = 1	#用于解决TCP的SYN攻击
net.ipv4.tcp_max_syn.backlog=1024	#TCP三次握手建立阶段接受SYN请求队列最大长度

sysctl -p
```

##### 编译安装

```shell

```

##### 目录结构

```shell

```

##### 配置

```shell
user  nobody;
worker_processes  8;
error_log  /var/log/nginx/error.log error;
#pid        logs/nginx.pid;
events {
    use epoll;
    worker_connections  50000;
}
http {
  upstream backend {
    server 127.0.0.1:8080;
  }
  gzip on;
  server {
  	listen localhost:80;
    …
    location /webstatic {
      gzip off;
    }
  }
}
#### 基本配置
#用于调试、定位问题
daemon on;
master_process on | off;
error_log  /path/file  level;	#level: debug、info、notice、warn、error、crit、alert、emerg
debug_points [stop | abort];
events {
    debug_connection 10.224.66.14; 
    debug_connection 10.224.57.0/24;
}
worker_rlimit_core size;
working_directory path;
#正常运行的必备配置
env VAR|VAR=VALUE
include /path/file;
pid path/file;
user username [groupname]; 
worker_rlimit_nofile limit;	#一个worker打开的最大句柄数
worker_rlimit_sigpending limit;	#每个用户发往 Nginx 的信号队列的大小
#优化性能
worker_processes number;
worker_cpu_affinity cpumask [cpumask...];
ssl_engine device；
timer_resolution t;	#每次内核的事件调用（如 epoll、select、poll、kqueue 等）返回时，都会执行一次 gettimeofday
worker_priority nice;
#事件类配置
accept_mutex [on | off];	#负载均衡锁 worker连接数达到7/8时，会大大减少连接
lock_file path/file;
accept_mutex_delay Nms;
multi_accept [ on | off ];
use [ kqueue | rtsig | epoll | /dev/poll | select | poll | eventport ];
worker_connections number;
```

#####  ngx_http_core_module

```shell
listen address:port [ default(deprecated in 0.8.21) | default_server | [ backlog=num | 
rcvbuf=size | sndbuf=size | accept_filter=filter | deferred | bind | ipv6only=[on|off] | ssl ] ];
# default，default_server：	将所有server块作为整个web服务的默认server块
# backlog=num：表示 TCP 中 backlog 队列的大小，默认为 –1，表示不予设置。在 TCP 建立三次握手过程中，进程还没有开始处理监听句柄，这时 backlog 队列将会放置这些新连接。可如果 backlog 队列已满，还有新的客户端试图通过三次握手建立 TCP 连接，这时客户端将会建立连接失败。
# rcvbuf=size：设置监听句柄的 SO_RCVBUF 参数
# sndbuf=size：设置监听句柄的 SO_SNDBUF 参数
# accept_filter：设置 accept 过滤器，只对 FreeBSD 操作系统有
# deferred：在设置该参数后，若用户发起建立连接请求，并且完成了 TCP 的三次握手，内核也不会为了这次的连接调度 worker 进程来处理，只有用户真的发送请求数据时（内核已经在网卡中收到请求数据包），内核才会唤醒 worker 进程处理这个连接。这个参数适用于大并发的情况下，它减轻了 worker 进程的负担。当请求数据来临时，worker 进程才会开始处理这个连接。只有确认上面所说的应用场景符合自己的业务需求时，才可以使用 deferred 配置。
# bind ：绑定当前端口 / 地址对，如 127.0.0.1:8000。只有同时对一个端口监听多个地址时才会生效
# ssl：在当前监听的端口上建立的连接必须基于 SSL 协议
server_name name [...];	# 全匹配>通配在前>通配在后>
server_names _hash_bucket_size size;	#为了提高快速寻找到相应 server name 的能力，Nginx 使用散列表来存储 server name。server_names _hash_bucket_size 设置了每个散列桶占用的内存大小。
server_names _hash_max_size;	#server_names _hash_max_size 会影响散列表的冲突率。server_names _hash_max_size 越大，消耗的内存就越多，但散列 key 的冲突率则会降低，检索速度也更快。server_names _hash_max_size 越小，消耗的内存就越小，但散列 key 的冲突率可能增高
server_name_in_redirect on;	#重定向请求时会使用server_name 里配置的第一个主机名代替原先请求中的 Host 头部
error_page 404 =200 /empty.gif;
# 转发到另一location
location / (
    error_page 404 @fallback;
)
 
location @fallback (
    proxy_pass http://backend;
)
recursive_error_pages [on | off];
try_files path1 [path2] uri;
```

##### 负载均衡

```shell
upstream backend {
    server backend1.example.com weight=5;
    server 127.0.0.1:8080 max_fails=3 fail_timeout=30s;
    server unix:/tmp/backend3;
}
# down 永久下线（ip_hash） backup(备份，不用于ip_hash)
```

##### 反向代理

```shell
proxy_pass url
proxy_set_header Host $host //带host头
proxy_method method; //GET POST
proxy_hide_header the_header;
proxy_pass_header;
proxy_pass_request_body on|off;
proxy_redirect [default|off|redirect replacement]
proxy_next_upstream [error|timeout|500|502|503|504||404|invaild_header] //如果 ，下一台处理
```
```shell
# Nginx
        location / {
            #root   html;
            #index  index.html index.htm;
            proxy_set_header Host $host;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass http://list1;
            if ($request_uri ~ ^/qrs-web/(.*)){
                rewrite ^(.*)$ $1 break;
                }
            if ($request_uri ~ ^/NginxStatus/(.*)){
                rewrite ^(.*)$ $1 break;
                }
           rewrite ^(.*)$ /qrs-web$1 break;
		   #if ( $request_uri !~ ^/dtm-web ){
           #     rewrite (.*) /dtm-web$1 break;
           #}
        }
#       if ($host = "qrssit.cnsuning.com"){
#            rewrite ^(.*)$ /qrs-web$1 last;   #500
#        }
location =/ {index index.html ; rewrite /(.*) /ssrc-web/ last ;}
```


