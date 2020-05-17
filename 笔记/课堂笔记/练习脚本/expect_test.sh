#!/usr/bin/expect
#
############################################################

# @Author:	Flamenca
# @Date:	2020-04-26 13:12:26
# @File Name:	expect_test.sh
# @Last Modified time:	2020-04-26 13:16:34
# @Description:	The test script
# @mail:	flamenca@qq.com

############################################################
set timeout 10
#设置超时时间，单位为秒，默认情况下是10秒
set user root
set PASSWD root
set IP 192.168.1.13

spawn ssh $user@$IP
   expect {
     "yes/no" { send "yes\n";exp_continue }
     "password" { send "$PASSWD\n" }
          }
   interact
   #执行完成后保持交互状态，把控制权交给控制台，这个时候就可以手工操作了。如果没有这一句登录完成后会退出，而不是留在远程终端上。