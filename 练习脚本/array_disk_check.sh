#!/bin/bash 
#
############################################################
# @Author:	Flamenca
# @Date:	2020-04-22 15:56:43
# @File Name:	array_disk_check.sh
# @Last Modified time:	2020-04-22 16:10:09
# @Description:	The test script
# @mail:	flamenca@qq.com

############################################################

declare -A DISK
WARRING=10
df |grep '^/dev/sd' > df.log

while read line ; do
	#statements
	INDEX=`echo $line |sed -nr 's#(^[^[:space:]]+) .*#\1#p'`
	DISK[$INDEX]=`echo $line |sed -nr 's#^.* ([0-9]+)%.*#\1#p'`
	if [ ${DISK[$INDEX]} -gt $WARRING ];then
		wall $INDEX : ${DISK[$INDEX]}
	fi
done < df.log

