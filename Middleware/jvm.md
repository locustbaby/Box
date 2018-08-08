##### JVM

```shell
jmap -heap pid
jmap -dump:format=b,file=temp_heapdump.hprof pid
jstack pid >javacore.txt
```

```shell
GC日志滚动参数如下：-XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=5M  以上是JBOSS GC日志滚动的配置，第一个开关，第二个是滚动多少个文件，第三个是日志文件的大小（前提已开启-Xloggc）
```

