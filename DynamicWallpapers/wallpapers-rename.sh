#!/bin/bash
# 用于快速重命名全部文件

videosPath=$HOME/Videos/DynamicWallpapers

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

let i1=1
for file in $(ls $videosPath); do
	cd $videosPath && [ -f $file ] && mv $file $(printf "%09d" $i1).mp4 && let i1=i1+1
done

let i2=1

for file in $(ls -tr $videosPath); do
	cd $videosPath && [ -f $file ] && mv $file $(printf "%02d" $i2).mp4 && let i2=i2+1
done

for file in $(ls $videosPath); do
	echo "$file  " >>$HOME/Scripts/DynamicWallpapers/TEMP
done

IFS=$SAVEIFS
