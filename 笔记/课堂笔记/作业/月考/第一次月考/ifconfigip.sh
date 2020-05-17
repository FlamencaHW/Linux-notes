# raid5 是需要最少使用 3块硬盘或分区的我们假设为/dev/sdb{1..3}

# 创建raid-5

mdadm -c /dev/md0 -a yes -l5 -n3 /dev/sdb{1..3}
