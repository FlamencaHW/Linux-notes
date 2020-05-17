#!/bin/bash 
#
############################################################

# @Author:	Flamenca
# @Date:	2020-05-09 20:58:39
# @File Name:	seslinux_switch.sh
# @Last Modified time:	2020-05-11 00:35:37
# @Description:	一键开关SELinux的脚本
# @mail:	flamenca@qq.com

############################################################

. /etc/rc.d/init.d/functions

# 查看当前SELinux 的状态
#sest=`sestatus |awk -F" " '{print $NF}'`
sest=`awk -F"=" '/^SELINUX=/{print $NF}' /etc/selinux/config`

if [[ $sest == "disabled" ]]; then
	#如果/etc/selinux/config 中SELINUX=disable,则提示是否开启
	echo "SELinux is disabled "	
	read -p "Would you like to [O]pen or [Q]uit? :" var
	if [[ $var == ["O""o""open"] ]]; then
		sed -i 's/^SELINUX=disabled/SELINUX=enforcing/g' /etc/selinux/config 
		action "SELINUX is Open, please reboot your system"	/bin/true
	elif [[ $var == ["Q""q""quit"] ]]; then
		break
	else
		echo "Error input!"
		
	fi
elif [[ $sest == "enforcing" ]]; then
	#statements
	echo "SELinux is enforcing "
	read -p "Would you like to [D]isable or [Q]uit? :" var
	if [[ $var == ["D""d"] ]]; then
		sed -i 's/^SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config 
		action "SELINUX is disabled, please reboot your system"	/bin/true
	elif [[ $var == ["Q""q""quit"] ]]; then
		break
	else
		echo "Error input!"
		
	fi	
fi

# 

# 否则关闭