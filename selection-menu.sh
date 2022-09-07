#!/usr/bin/env bash

selected_item=0
menu_items=(
    "one"
    "two"
    "three"
)

menu_size=${#menu_items[@]}

print_menu() {
    clear

    for ((i = 0; i < $menu_size; ++i)); do
        if [ $i = $selected_item ]; then
            echo "-> ${menu_items[i]}"
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
                        print_menu
                    fi
                    ;;
                B)
                    if [ $selected_item -lt $((menu_size - 1)) ]; then
                        selected_item=$((selected_item + 1))
                        print_menu
                    fi
                    ;;
                esac
            fi
            read -rsn5 -t 0.1
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

    case "$menu_result" in
    0)
        echo 'Selection: one'
        ;;
    1)
        echo 'Selection: two'
        ;;
    2)
        echo 'Selection: three'
        ;;
    esac
}

selection_menu
