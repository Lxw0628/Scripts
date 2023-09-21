#!/bin/bash

ps -ef | grep xwinwrap | grep -v grep
if [ $? -ne 0 ]; then
	$HOME/Scripts/edit-profile.sh WALLPAPEREXIST '0'
else
	$HOME/Scripts/edit-profile.sh WALLPAPEREXIST '1'
fi

source ~/.zprofile

if [ $WALLPAPEREXIST -eq 1 ]; then
	killall mpv >>/dev/null 2>&1
	killall xwinwrap >>/dev/null 2>&1
else
	# mp4=$(cd /home/lxw/Videos/DynamicWallpapers;readlink -f $(ls | sort -R | head -1))
	mp4=$(sh $HOME/Scripts/DynamicWallpapers/wallpapers-random.sh)
	nice xwinwrap -g 1920x1080+0+0 -un -fdt -ni -b -nf -ov -- $HOME/Scripts/DynamicWallpapers/wallpapers-live.sh WID $HOME/Videos/DynamicWallpapers/$mp4 >>/dev/null 2>&1 &
fi
