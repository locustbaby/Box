##### HTTP

```shell
URL是URI的子集
http://user:pass@www.example.jp:80/dir/index.htm?uid=1#ch1
协议	登录信息	服务器地址	端口	文件路径	查询字符串	片段标识符
```

##### HTTP方法

```shell
GET：获取资源 文本直接返回，cgi返回处理后的 304 not modified
POST：传输实体主体
PUT：传输文件
HEAD：获得报文首部
DELETE：删除文件
OPTIONS：询问支持的方法
TRACE：追踪路径
CONNECT：要求用隧道协议连接代理
```

##### HTTP持久连接

```shel
持久连接：keep-alive
管线化：pipelining
状态管理：cookie
```

##### HTTP报文

```shell
报文结构：
报文首部	
空行（CR+LF）
报文主体
```

##### 编码

```shell
# 压缩传输的内容编码
gzip(GUN zip)
compress(UNIX系统的标准压缩)
deflate（zlib）
identity（不进行编码）
# 分割发送的分块传输编码

# 发送多种数据的多部分对象集合（MIME）

# 获取部分内容的范围请求（断点续传）

# 内容协商（中/英）
Accept
Accept-Charest
Accept-Encoding
Accept-Language
Content-Language
服务器驱动协商
    以请求的首部字段为参考，服务器端自动处理
客户端驱动协商
    用户从浏览器显示的可选项列表中手动选择，js自动选择，按os类型和浏览器类型
透明协商
	服务器和客户端各自进行协商
```

##### 状态码

```shell
#	2xx (success)
200 OK
204 No Content
206 Partial Content
#	3xx (重定向)
301 Moved Permanently	(URI忘记加'/')
302 Found
303 See Other
304 Not Modified
307 
#	4xx
400
401
403	forbidden
404	Not Found
499	规定时间内无响应（总时间）
#	5xx
500	web,php,lua语法错误 访问量大的时候，由于资源限制，不能打开过多的句柄
502 Bad Gateway(未给出正确的响应，但是有响应)
503	（认为后端fail，limit_req）
504	后端服务无反应
```

##### HTTPS

```shell
#	https://blog.csdn.net/hherima/article/details/52469674
#	https://blog.csdn.net/anningzhu/article/details/77517432	SSL/TLS区别
公开密钥加密（非对称密钥加密）建立连接传送共享密钥
共享密钥加密（对称密钥加密）传输数据
```

##### HTTP/2

```shell
https://ye11ow.gitbooks.io/http2-explained/content/
```

##### session cookie token

```shell
#	https://www.cnblogs.com/wxinyu/p/9154178.html
```

##### HTTP

```
https://developer.mozilla.org/zh-CN/
```

