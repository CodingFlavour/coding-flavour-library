#!/bin/bash
print_colored_message() {
    local message=$1
    local color=$2

    case $color in
    "red")
        echo -e "\e[1;31m$message\e[0m"
        ;;
    "green")
        echo -e "\e[1;32m$message\e[0m"
        ;;
    "blue")
        echo -e "\e[1;34m$message\e[0m"
        ;;
    "yellow")
        echo -e "\e[1;33m$message\e[0m"
        ;;
    "purple")
        echo -e "\e[1;35m$message\e[0m"
        ;;
    *)
        echo -e "$message"
        ;;
    esac
}