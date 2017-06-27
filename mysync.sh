#!/bin/bash
############### 一键安装RslSync脚本 ###############
#Author:xiaoz.me
#Update:2017-03-27
#Help:https://www.xiaoz.me/archives/8219
####################### END #######################
#获取rslsync pid
chksync=$(pgrep 'rslsync')
if [ "$1" == "start" ]
	then
		/home/RslSync/rslsync --config sync.conf
		echo "启动成功，请访问http://IP:8888/"
	elif [ "$1" == "status" ]
		then
		if [ "$chksync" == "" ]
			then
				echo "Not running!"
			else
				echo "Is running,pid is ${chksync}"
		fi
	elif [ "$1" == "stop" ]
		then
			kill -9 ${chksync}
	else
		echo "参数错误!"
	fi