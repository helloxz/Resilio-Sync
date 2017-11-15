#!/bin/bash
############### 一键安装RslSync脚本 ###############
#Author:xiaoz.me
#Update:2017-11-15
#Help:https://www.xiaoz.me/archives/8219
####################### END #######################

#自动放行端口
function chk_firewall() {
	if [ -e "/etc/sysconfig/iptables" ]
	then
		iptables -I INPUT -p tcp --dport 8888 -j ACCEPT
		service iptables save
		service iptables restart
	else
		firewall-cmd --zone=public --add-port=8888/tcp --permanent 
		firewall-cmd --reload
	fi
}
#安装
function install_sync(){
	mkdir -p /home/RslSync
	cp mysync.sh /home/RslSync/
	cd /home/RslSync
	wget https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz --no-check-certificate
	tar -zxf resilio-sync_x64.tar.gz
	rm -rf resilio-sync_x64.tar.gz
	./rslsync --dump-sample-config > sync.conf 
	declare user=$(cat sync.conf|grep 'login')
	declare upass=$(cat sync.conf|grep ",\"password\"")
	read -p "请输入用户名:" newuser
	suser=${newuser}
	declare newuser=",\"login\" : \"${newuser}\""
	read -p "请设置密码:" newpass
	spass=${newpass}
	declare newpass=",\"password\" : \"${newpass}\""
	sed -i "s%${user}%${newuser}%g" sync.conf
	sed -i "s%${upass}%${newpass}%g" sync.conf
	#设置alias
	echo "alias mysync='/home/RslSync/mysync.sh'" >>  ~/.bashrc
	./rslsync --config sync.conf
	#开机自启
	echo "/home/RslSync/rslsync --config /home/RslSync/sync.conf" >> /etc/rc.local
	#获取IP
	osip=$(curl http://https.tn/ip/myip.php?type=onlyip)
	chk_firewall
	echo "############################# 安装成功 #############################"
	echo "访问地址:http://${osip}:8888/"
	echo "用户名:"${suser}
	echo "密码:"${spass}
	echo "帮助中心:https://www.xiaoz.me/archives/8219"
}

#卸载
function uninstall_sync(){
	chksync=$(pgrep 'rslsync')
	kill -9 ${chksync}
	rm -rf /home/RslSync
	#删除alias
	sed -i '/^.*mysync.*/'d ~/.bashrc
	sed -i '/^.*rslsync.*/'d /etc/rc.local 
	echo "卸载完成."
}
#搜索是否存在RslSync文件夹
echo "##########	欢迎使用Resilio Sync一键安装脚本	##########"
echo "1.安装Resilio Sync"
echo "2.卸载Resilio Sync"
echo "3.退出"

declare -i stype
read -p "请输入选项:（1.2.3）:" stype

if [ "$stype" == 1 ]
	then
		#检查目录是否存在
		if [ -e "/home/RslSync" ]
			then
			echo "目录存在，请检查是否已经安装。"
			exit
		else
			echo "目录不存在，创建目录..."
			mkdir -p /home/RslSync
			#执行安装函数
			install_sync
		fi
	elif [ "$stype" == 2 ]
		then
			uninstall_sync
			exit
	elif [ "$stype" == 3 ]
		then
			exit
	else
		echo "参数错误！"
	fi	