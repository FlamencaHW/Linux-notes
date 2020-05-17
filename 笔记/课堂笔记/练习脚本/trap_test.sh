#!/bin/bash 
#
############################################################
# @Author:	Flamenca
# @Date:	2020-04-22 10:19:06
# @File Name:	trap_test.sh
# @Last Modified time:	2020-04-22 10:21:53
# @Description:	The test script
# @mail:	flamenca@qq.com

############################################################

# 简单的测试，当
trap 'echo press ctrl+c' int
# 显示自定义的信号
trap -p

for (( i = 0; i < 10; i++ )); do
	#statements
	echo $i
	sleep
done