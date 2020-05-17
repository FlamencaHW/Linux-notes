#!/bin/bash 
#
############################################################
# @Author:	Flamenca
# @Date:	2020-04-22 08:53:57
# @File Name:	recursion2.sh
# @Last Modified time:	2020-04-22 09:25:12
# @Description:	测试递归的脚本
# @mail:	flamenca@qq.com

############################################################

# 实现阶乘

fact(){
	if [[ $1 -eq 0 ]]; then
		# 0的阶乘是1
		echo 1
	else
		echo $[`fact  $[$1-1]`*$1]
	fi
}


fact $1