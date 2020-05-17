#!/bin/bash 
#
############################################################

# @Author:	Flamenca
# @Date:	2020-05-16 17:46:40
# @File Name:	sshkey_expect.sh
# @Last Modified time:	2020-05-16 18:04:50
# @Description:	SSH基于key的expect自动化脚本
# @mail:	flamenca@qq.com

############################################################
# 设置密码
PASS=123123

# 第一步：先自动生成钥匙对，密码为空,并提示,
ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa &> /dev/null && echo "ssh key is created!"

# 因为要用到expect，所以先检查是否安装expect如果未安装，则安装，反之直接运行
rpm -q expect &> /dev/null || yum -y install expect &> /dev/null

# 第二步：复制公钥文件到远程去，因为目标主机的数量可能非常多，所以我们将目标主机的IP写入文件host.txt中通过while读入并循环执行expect程序


while read IP; do
	#statements
	expect <<EOF
		set timeout 20
		spawn ssh-copy-id -i /root/.ssh/id_rsa.pub root@$IP
		expect {
			"yes/no" {send "yes\n";exp_continue }
			"password" {send "$PASS\n"}
		}
		expect eof
	EOF
	echo $IP is ready
done < host.txt