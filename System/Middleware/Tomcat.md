[Tomcat](https://www.abcdocker.com/abcdocker/2514)

###### chapter 1: INSTALL

java\_install

tomcat\_install

###### chapter 3: JVM

优化catalina.sh配置文件。在catalina.sh配置文件中添加以下代码：

JAVA\_OPTS="-Djava.awt.headless=true -Dfile.encoding=UTF-8 -server -Xms1024m -Xmx1024m -XX:NewSize=512m -XX:MaxNewSize=512m -XX:PermSize=512m -XX:MaxPermSize=512m"

server:一定要作为第一个参数，在多个CPU时性能佳

-Xms：初始堆内存Heap大小，使用的最小内存,cpu性能高时此值应设的大一些

-Xmx：初始堆内存heap最大值，使用的最大内存

上面两个值是分配JVM的最小和最大内存，取决于硬件物理内存的大小，建议均设为物理内存的一半。

-XX:PermSize:设定内存的永久保存区域

-XX:MaxPermSize:设定最大内存的永久保存区域

-XX:MaxNewSize:

-Xss 15120 这使得JBoss每增加一个线程（thread\)就会立即消耗15M内存，而最佳值应该是128K,默认值好像是512k.

+XX:AggressiveHeap 会使得 Xms没有意义。这个参数让jvm忽略Xmx参数,疯狂地吃完一个G物理内存,再吃尽一个G的swap。

-Xss：每个线程的Stack大小

-verbose:gc 现实垃圾收集信息

-Xloggc:gc.log 指定垃圾收集日志文件

-Xmn：young generation的heap大小，一般设置为Xmx的3、4分之一

-XX:+UseParNewGC ：缩短minor收集的时间

-XX:+UseConcMarkSweepGC ：缩短major收集的时间

###### chapter 3: CONFIG

1. server.xml 组件

顶级组件：位于整个配置的顶层，如server。

容器类组件：可以包含其它组件的组件，如service、engine、host、context。

连接器组件：连接用户请求至tomcat，如connector。

被嵌套类组件：位于一个容器当中，不能包含其他组件，如Valve、logger。

```
<server>
<service>
<connector />
<engine>
<host>
<context></context>
</host>
<host>
<context></context>
</host>
</engine>
</service>
</server>
```

engine：核心容器组件，catalina引擎，负责通过connector接收用户请求，并处理请求，将请求转至对应的虚拟主机host。

host：类似于httpd中的虚拟主机，一般而言支持基于FQDN的虚拟主机。

context：定义一个应用程序，是一个最内层的容器类组件（不能再嵌套）。配置context的主要目的指定对应对的webapp的根目录，类似于httpd的alias，其还能为webapp指定额外的属性，如部署方式等。

connector：接收用户请求，类似于httpd的listen配置监听端口的。

service（服务）：将connector关联至engine，因此一个service内部可以有多个connector，但只能有一个引擎engine。service内部有两个connector，一个engine。因此，一般情况下一个server内部只有一个service，一个service内部只有一个engine，但一个service内部可以有多个connector。

server：表示一个运行于JVM中的tomcat实例。

Valve：阀门，拦截请求并在将其转至对应的webapp前进行某种处理操作，可以用于任何容器中，比如记录日志\(access log valve\)、基于IP做访问控制\(remote address filter valve\)。

logger：日志记录器，用于记录组件内部的状态信息，可以用于除context外的任何容器中。

realm：可以用于任意容器类的组件中，关联一个用户认证库，实现认证和授权。可以关联的认证库有两种：UserDatabaseRealm、MemoryRealm和JDBCRealm。

UserDatabaseRealm：使用JNDI自定义的用户认证库。

MemoryRealm：认证信息定义在tomcat-users.xml中。

JDBCRealm：认证信息定义在数据库中，并通过JDBC连接至数据库中查找认证用户。

```
<?xml version='1.0' encoding='utf-8'?>
<!--
<Server>元素代表整个容器,是Tomcat实例的顶层元素.由org.apache.catalina.Server接口来定义.它包含一个<Service>元素.并且它不能做为任何元素的子元素.
port指定Tomcat监听shutdown命令端口.终止服务器运行时,必须在Tomcat服务器所在的机器上发出shutdown命令.该属性是必须的.
shutdown指定终止Tomcat服务器运行时,发给Tomcat服务器的shutdown监听端口的字符串.该属性必须设置
-->
<Server port="8005" shutdown="SHUTDOWN">
<Listener className="org.apache.catalina.startup.VersionLoggerListener" />
<Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
<Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
<Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
<Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />
<GlobalNamingResources>
<Resource name="UserDatabase" auth="Container"
type="org.apache.catalina.UserDatabase"
description="User database that can be updated and saved"
factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
pathname="conf/tomcat-users.xml" />
</GlobalNamingResources>
<!--service服务组件-->
<Service name="Catalina">
<!--
connector：接收用户请求，类似于httpd的listen配置监听端口.
port指定服务器端要创建的端口号，并在这个端口监听来自客户端的请求。
address：指定连接器监听的地址，默认为所有地址（即0.0.0.0）
protocol连接器使用的协议，支持HTTP和AJP。AJP（Apache Jserv Protocol）专用于tomcat与apache建立通信的， 在httpd反向代理用户请求至tomcat时使用（可见Nginx反向代理时不可用AJP协议）。
minProcessors服务器启动时创建的处理请求的线程数
maxProcessors最大可以创建的处理请求的线程数
enableLookups如果为true，则可以通过调用request.getRemoteHost()进行DNS查询来得到远程客户端的实际主机名，若为false则不进行DNS查询，而是返回其ip地址
redirectPort指定服务器正在处理http请求时收到了一个SSL传输请求后重定向的端口号
acceptCount指定当所有可以使用的处理请求的线程数都被使用时，可以放到处理队列中的请求数，超过这个数的请求将不予处理
connectionTimeout指定超时的时间数(以毫秒为单位)
-->
<Connector port="8080" protocol="HTTP/1.1"
connectionTimeout="20000"
redirectPort="8443" />
<Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
<!--engine,核心容器组件,catalina引擎,负责通过connector接收用户请求,并处理请求,将请求转至对应的虚拟主机host
defaultHost指定缺省的处理请求的主机名，它至少与其中的一个host元素的name属性值是一样的
-->
<Engine name="Catalina" defaultHost="localhost">
<!--Realm表示存放用户名，密码及role的数据库-->
<Realm className="org.apache.catalina.realm.LockOutRealm">
<Realm className="org.apache.catalina.realm.UserDatabaseRealm"
resourceName="UserDatabase"/>
</Realm>
<!--
host表示一个虚拟主机
name指定主机名
appBase应用程序基本目录，即存放应用程序的目录.一般为appBase="webapps" ，相对于CATALINA_HOME而言的，也可以写绝对路径。
unpackWARs如果为true，则tomcat会自动将WAR文件解压，否则不解压，直接从WAR文件中运行应用程序
autoDeploy：在tomcat启动时，是否自动部署。
xmlValidation：是否启动xml的校验功能，一般xmlValidation="false"。
xmlNamespaceAware：检测名称空间，一般xmlNamespaceAware="false"。
-->
<Host name="localhost" appBase="webapps"
unpackWARs="true" autoDeploy="true">
<!--
Context表示一个web应用程序，通常为WAR文件
docBase应用程序的路径或者是WAR文件存放的路径,也可以使用相对路径，起始路径为此Context所属Host中appBase定义的路径。
path表示此web应用程序的url的前缀，这样请求的url为http://localhost:8080/path/****
reloadable这个属性非常重要，如果为true，则tomcat会自动检测应用程序的/WEB-INF/lib 和/WEB-INF/classes目录的变化，自动装载新的应用程序，可以在不重启tomcat的情况下改变应用程序
-->
<Context path="" docBase="" debug=""/>
<Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
prefix="localhost_access_log" suffix=".txt"
pattern="%h %l %u %t &quot;%r&quot; %s %b" />
</Host>
</Engine>
</Service>
</Server>
```

###### chapter 4: GET\_REAL\_IP

在tomcat配置文件/conf/server.xml下配置



&lt;Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"

prefix="localhost\_access\_log" suffix=".txt"

pattern="%h %l %u %t %r %s %b" /&gt;

前面有负载均衡的时候，获取真实IP可以使用下面的配置

&lt;Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"

prefix="localhost\_access\_log." suffix=".txt"

pattern="%{X-Forwarded-For}i %h %l %u %t %r %s %b" /&gt;

###### chapter 5: DEPLOY

`/application/tomcat/webapps/x.war`





