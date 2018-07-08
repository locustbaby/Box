```shell
#   jboss password加密
/opt/wildfly/java64/jdk1.7.0_25/bin/java -cp /opt/wildfly/modules/system/layers/base/org/picketbox/main/picketbox-4.0.21.Beta1.jar:/opt/wildfly/modules/system/layers/base/org/jboss/logging/main/jboss-logging-3.1.4.GA.jar:/opt/wildfly/java64/jdk1.7.0_25/lib/ org.picketbox.datasource.security.SecureIdentityLoginModule PAAWORD

#   ssh 免yes	超时	次数	跳过密码输入
-o stricthostkeychecking=no -o ConnectTimeout=3  -o ConnectionAttempts=3 -o PasswordAuthentication=no

#   FTP
ftp -inv 10.105.73.170 <<!
user username password
bin
cd soft/sndp/
put
!

#   下载
wget ftp://deploy:extdeploy@192.168.241.12/17liucf/cache/
wget -r -nd -m $Log_url/package && unzip ./$software && rm -f ./$software

#   上传
curl -T   $file  ftp://192.168.241.12/17liucf/cache/ -u uname:passwd

#   追加
cat>>1.list<<EOF
EOF
#    javacore & dump
收集topCPU及javacore：
top -H -p <pid> -b -n1 >> dump_high_cpu.txt;/opt/jboss/java64/jdk1.7.0_25/bin/jstack <pid> > javacore.txt
收集dump：
/opt/jboss/java64/jdk1.7.0_25/bin/jmap -dump:format=b,file=heap.prof <pid>

#   loop
for ip in  `cat ip.conf`;do command;done
for ip in 1 2 3 4 5 ;do command;done
cat ip.conf | while read ip ;do command & wait;done

#	文本三剑客
#	sed
sed -n Np file
sed -i '3s/aaa/fff/' file --表示针对file文件中的第三行，将其中的aaa替换为fff
sed -i '/xxx/s/aaa/fff/g' file --表示针对文件，找出包含xxx的行，并将其中的aaa替换为fff
sed -i '1s/[#*]/fff/gp' file --表示针对文件第1行，将其中的#号或是*号替换为fff

#   Thread

# 	if case while
#	if脚本参数
if [ x$1 = x];then
    no key;
elif [];then

else

fi

数值比较 ：-eq	-ge -gt -le -lt -ne 
字符比较 ：= !=  < > -n(字符串长度非0) -z(字符串长度为0)
文件比较 ：-d(directory) -e(exit) -f(file) -r(read) -s(存在且非空) -w(write) -x(execut) -O(是否存在且属当前用户) -G(存在且默认组与当前用户相同) -nt(newer than) -ot(older than) 

# for

# chage 密码延期

# unix time
date

#	nc
#	netstat
#	ps top
#	lsof
#	du
#	find which rsync
#	sort wc
#	tee

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

# ssh expect
for ip in `cat ip.conf`
do
	spawn ssh jbossuser@$ip
	expect "no)"
	send "yes"
	expect "*#"
	send exit/r
done

```

