#!/bin/bash 
#
############################################################

# @Author:	Flamenca
# @Date:	2020-04-26 12:38:20
# @File Name:	addUser_dir.sh
# @Last Modified time:	2020-04-26 13:01:05
# @Description:	接受二个位置参数，magedu和/www，判断系统是否有magedu，如果没有则自动创建magedu用户，并自动设置家目录为/www
# @mail:	flamenca@qq.com

############################################################

# 接受两个输入参数$name $dir
while read -p "please input your USERNAME and HOMEDIR:" name dir; do
	# 判断输入内容是否正确
	if [[ -z $name ]]; then
		# 当$name 为空
		echo "please input your USERNAME"
	elif [[ -z $dir ]]; then
		# 当$dir 为空
		echo "please input your DIR"
	elif `id $name &> /dev/null`; then
		# 查询 $name 发现已经存在
		echo "$name already exit!"
	elif `useradd $name -d $dir &> /dev/null` ; then
		# 为其创建账户，并制定家目录
		echo your count $name is created!
		echo 123456 |passwd --stdin $name &> /dev/null
		echo your passwd is : 123456  
	else 
		echo "another error,please check your input"
	fi
done