#!/bin/bash 
#
############################################################

# @Author:	Flamenca
# @Date:	2020-04-22 16:20:35
# @File Name:	arry_find_maxmin.sh
# @Last Modified time:	2020-04-22 16:35:26
# @Description:	生成10个随机数保存于数组中，并找出其最大值和最小值
# @mail:	flamenca@qq.com

############################################################

# 声明数组

declare -a RAND

for (( i = 0; i < 10; i++ )); do
	RAND[$i]=$RANDOM
	# 如果 i = 0
	if [[ $i -eq 0 ]]; then
		MAX=${RAND[$i]}
		MIN=$MAX
	else
		[ ${RAND[$i]} -gt $MAX ] && { MAX=${RAND[$i]};continue;}
		[ ${RAND[$i]} -lt $MIN ] && MIN=${RAND[$i]}
	fi
done

echo ALL RANDOM are ${RAND[@]}
echo MAX=$MAX
echo MIN=$MIN