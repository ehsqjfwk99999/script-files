#!/usr/bin/env bash

GREEN="\e[32m"
UNDERLINE="\e[4m"
ENDCOLOR="\e[0m"

selected_item=0

menu_items=(
    "mount /dev/nvme0n1"
    "umount /dev/nvme0n1"
)

commands=(
    'sudo bash /home/ksy/.ksy/mount.sh'
    'sudo bash /home/ksy/.ksy/unmount.sh'
)

menu_size=${#menu_items[@]}

print_menu() {
    clear

    for ((i = 0; i < $menu_size; ++i)); do
        if [ $i = $selected_item ]; then
            echo -e "${GREEN}-> ${UNDERLINE}${menu_items[i]}${ENDCOLOR}"
        else
            echo "   ${menu_items[i]}"
        fi
    done
}

run_menu() {
    print_menu

    while read -rsn1 input; do
        case $input in
        $'\x1B')
            read -rsn1 -t 0.1 input
            if [ $input = "[" ]; then
                read -rsn1 -t 0.1 input
                case $input in
                A)
                    if [ $selected_item -ge 1 ]; then
                        selected_item=$((selected_item - 1))
                    else
                        selected_item=$((menu_size - 1))
                    fi
                    ;;
                B)
                    if [ $selected_item -lt $((menu_size - 1)) ]; then
                        selected_item=$((selected_item + 1))
                    else
                        selected_item=0
                    fi
                    ;;
                esac
                print_menu
            fi
            read -rsn5 -t 0.1
            ;;
        "q")
            clear
            exit
            ;;
        "")
            clear
            return $selected_item
            ;;
        esac
    done
}

selection_menu() {
    run_menu
    menu_result=$?

    eval ${commands[$menu_result]}
}

selection_menu
