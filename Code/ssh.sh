#!/bin/expect
for ip in `cat ip.conf`
do
	spawn ssh jbossuser@$ip
	expect "no)"
	send "yes"
	expect "*#"
	send exit/r
done
