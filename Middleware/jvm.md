##### JVM

```shell
jmap -heap pid
jmap -dump:format=b,file=temp_heapdump.hprof pid
jstack pid >javacore.txt
```

