#! /bin/bash
# 更改环境变量脚本

if [ -s ~/.zprofile ]; then
	sed -i '/^export '$1'=.*$/d' ~/.zprofile
fi
echo 'export '$1'='$2'' >>~/.zprofile

source ~/.zprofile
