#! /bin/bash
# Author：Flamenca
# 写一个脚本，生成10个随机数，并从小到大排序

i=1

while [[ $1<10 ]]; do
	# 生成十次随机数添加到临时文件numbers.tmp中
	echo $RANDOM >> ./numbers.tmp;
	i=$i+1;
done

# 取出内容然后排序输出
cat ./numbers.tmp |sort -n

# 删除临时文件
rm ./numbers.tmp