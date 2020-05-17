#!/bin/bash

# 创建一个10以内的随机数
N=$[RANDOM%10+1]

# 开始循环
while read -p "input a number(1-10):" NUM ; do
	# 判断输入的是否为数字
	if [[ $NUM =~ ^[[:digit:]]+$ ]]; then
		# 为真则执行循环
		if [[ $NUM -eq $N ]]; then
			echo ok
		elif [[ $NUM -gt $N ]]; then
			echo too large!
		else
			echo too small!
		fi
	else
		echo "please input a digit"
	fi
done