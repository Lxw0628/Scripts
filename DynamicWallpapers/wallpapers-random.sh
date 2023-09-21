#!/bin/bash

videosPath=$HOME/Videos/DynamicWallpapers

# 如果TEMP不存在 创建TEMP
temp_file=$HOME/Scripts/DynamicWallpapers/TEMP
if [ ! -f $temp_file ]; then
	touch $temp_file
fi

# 如果TEMP为空
if [ ! -s $temp_file ]; then
	ls "$videosPath" | grep mp4 >$temp_file
else
	# 如果TEMP非空
	# 先删除尾行
	last_file=$(tail -n 1 $temp_file)
	sed -i '$d' $temp_file
	# 随机选择一行并输出
	random_file=$(shuf -n 1 $temp_file)
	echo "$random_file"
	# 删除随机选中的行并添加之前删除的尾行之后再添加随机选择行
	sed -i "/$random_file/d" $temp_file
	echo $last_file >>$temp_file
	echo $random_file >>$temp_file

	# 如果TEMP为空 写入文件名
	if [ ! -s $temp_file ]; then
		ls "$videosPath" | grep mp4 >$temp_file
	fi
fi
