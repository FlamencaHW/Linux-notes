#!/bin/bash

# 将1.txt	2.log	3.html 统一修改后缀名为abc

for i in `ls ./rename`; do
	#加工
	new_name="`$i |cut -d "." -f1`.abc"
	echo $new_name
	# mv $i $new_name;
done