#! /bin/bash
# 打印菜单
call_menu() {
    echo '1 Screenkey'
    [ "$(docker ps | grep v2raya)" ] && echo '2 关闭代理' || echo '2 开启代理'
    [ "$(ps aux | grep picom | grep -v 'grep\|rofi\|nvim')" ] && echo '3 关闭 picom' || echo '3 开启 picom'
    [ "$(cat $HOME/Scripts/temp/rofi_temp)" -eq 0 ] && echo '4 外接显示器亮度设为50' || echo '4 外接显示器亮度设为0'
    [ "$(ps aux | grep warpd | grep -v 'grep')" ] && echo '5 关闭 warpd' || echo '5 开启 warpd'
    echo '0 重启至Windows'
}

# 执行菜单
execute_menu() {
    case $1 in
        '1 Screenkey')
            coproc (sh $HOME/Scripts/Screenkey.sh >/dev/null 2>&1)
            ;;
        '2 开启代理')
            coproc (docker restart v2raya >/dev/null)
            ;;
        '2 关闭代理')
            coproc (docker stop v2raya >/dev/null)
            ;;
        '3 开启 picom')
            coproc (picom --experimental-backends --config $HOME/.config/picom/picom.conf >/dev/null 2>&1)
            ;;
        '3 关闭 picom')
            killall picom
            ;;
        '4 外接显示器亮度设为50')
            coproc ( ddcutil setvcp 10 50; echo "50" >$HOME/Scripts/temp/rofi_temp )
            ;;
        '4 外接显示器亮度设为0')
            coproc ( ddcutil setvcp 10 0 ; echo "0" >$HOME/Scripts/temp/rofi_temp )
            ;;
        '5 开启 warpd')
            warpd
            ;;
        '5 关闭 warpd')
            killall warpd
            ;;
        '0 重启至Windows')
            sudo grub-reboot 2
            reboot
            ;;
    esac
}

execute_menu "$(call_menu | rofi -dmenu -p "")"
