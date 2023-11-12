#!/bin/bash
print_colored_message() {
    local message=$1
    local color=$2
    local level=$3
    local indentation=""
    local regex='^[0-9]+$'

    if [[ $level = "" || ! $level =~ $regex ]]; then
        level=0
    fi

    for i in $(seq $level); do
        indentation="${indentation}    "
    done

    finalMessage="${indentation}- ${message}"

    case $color in
    "red")
        echo -e "\e[1;31m$finalMessage\e[0m"
        ;;
    "green")
        echo -e "\e[1;32m$finalMessage\e[0m"
        ;;
    "blue")
        echo -e "\e[1;34m$finalMessage\e[0m"
        ;;
    "yellow")
        echo -e "\e[1;33m$finalMessage\e[0m"
        ;;
    "purple")
        echo -e "\e[1;35m$finalMessage\e[0m"
        ;;
    *)
        echo -e "$finalMessage"
        ;;
    esac
}

debug() {
    local message=$1
    local level=$2

    if [[ $debug = true ]]; then
        print_colored_message "[DEBUG] ${message}" "purple" "${level}"
    fi
}
