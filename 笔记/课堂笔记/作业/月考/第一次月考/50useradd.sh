#! /bin/bash
# Author:Flamenca
# 使用脚本创建system1-50个用户，并指定家目录为/data/system[1-50]

for i in system{1..50}; do
	# 创建用户并指定家目录
	useradd -d /data/$i $i && echo "用户 $i 已添加";
done
