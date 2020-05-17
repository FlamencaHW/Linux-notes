#!/bin/bash
# Author:Flamenca

# 自动添加三个用户，并计算这三个用户的uid之和

uid=0

for i in user{1..3}; do 
	# 添加三个用户
	useradd $i;
	# 添加完一个就取出其UID
	u=`id -u $i`;
	# 计算uid之和
	uid=`echo $[uid+u]`;

done

echo "UID之和为： $uid"