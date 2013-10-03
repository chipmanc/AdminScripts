#!/bin/bash
if [ $# != 2 ]
	then
	echo "Command syntax:"
	echo "telnetAutomation FROM_EMAIL TO_EMAIL"
else
	exec 3<>/dev/tcp/127.0.0.1/25
	echo -e "ehlo localhost">&3
	sleep 1
	echo -e "mail from: ${1}">&3
	sleep 1
	echo -e "rcpt to: ${2}">&3
	sleep 1
	echo -e "data\nTest\n.">&3
	echo -e "quit">&3
	cat <&3
fi
