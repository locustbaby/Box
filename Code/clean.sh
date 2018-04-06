#!/bin/bash

# Env
range='find ./ -mtime +10'
#ps -fu jbossuser|grep java|grep domain|grep -o "jboss.server.log.dir.*"|awk '{print $1}'|awk -F '=' '{print $2}'
domain_file=`ps -ef|grep java|grep -o "jboss.server.log.dir.*"|awk '{sub(/-D.*/,NONE);sub(/.*dir=/,NONE);print}'`
standalone_file=`ps -ef|grep standalone|grep -o "org.jboss.boot.log.file=.*server.log"|awk '{sub(/.*=/,NONE);sub(/\/server.log/,NONE);print}'`

function clean() {
    for file in $Log_Files
    do
        #echo "PWD : "$file  && cd $file && find ./ -mtime +20 || continue && continue && find ./ -mtime +20|xargs /usr/sbin/lsof && echo "success" && echo 222 && echo 2222 && echo 222 || echo 1
        echo "PWD : "$file  && cd $file && res=`$range`
        if [ -z "$res" ];then  #file : NONE
            echo "No Files to Del,change Time ."
            continue
        elif [ -z "`/usr/sbin/lsof $res`" ];then
            #echo "Free to Del ! " && $res -delete && /usr/sbin/lsof |grep delete
            echo "Free to Del & The NUM: " && $range|wc -l && $range -delete && echo "Files DELD !" && /usr/sbin/lsof |grep delete 
        else
             echo "Occupy !"
            continue
        fi
    done
}

function main() {
    if [ "$domain_file" ];then #file : NONE
    echo "DOMAIN"
    Log_Files=$domain_file && clean
    elif [ "$standalone_file" ];then
    echo "STANDALONE"
    Log_Files=$standalone_file && clean
    fi
}
main
