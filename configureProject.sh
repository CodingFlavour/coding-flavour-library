#!/bin/bash
PROJECT_NAME=$1
ERROR_UPPERCASE="Error: Component name must start with a lowercase letter."
FULLSCRIPTPATH="${BASH_SOURCE[0]}"
SCRIPTPATH=$(dirname "$FULLSCRIPTPATH")

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

show_help() {
    print_colored_message "---------------" "green"
    print_colored_message "|     HELP    |" "green"
    print_colored_message "---------------" "green"
    print_colored_message "Creates a project with all the utilities needed for a new Coding Flavour project by the given name."
    print_colored_message
    print_colored_message "Usage:" "blue"
    print_colored_message "sh ./configureProject.sh [project_name]"
    print_colored_message
    print_colored_message "[project_name]: Must start with a lowercase letter"
    print_colored_message
    print_colored_message "Options:" "blue"
    print_colored_message
    print_colored_message "  -h, --help   Show this help message and exit."
}

validate_component_name() {
    local first_char=${PROJECT_NAME:0:1}

    if [[ ! "$first_char" =~ [[:lower:]] ]]; then
        print_colored_message "$ERROR_UPPERCASE" "red"
        exit 1
    fi
}

generate_project() {
    print_colored_message "Starting to create NextJS project" green
    npx create-next-app $PROJECT_NAME --ts --eslint --src-dir --no-tailwind --import-alias '@/*' --app
    print_colored_message "Ended creating NextJS project" green
}

install_dependencies() {
    print_colored_message "Starting to install dependencies" green
    npm install --prefix ./$PROJECT_NAME/ sass
    print_colored_message "Ended installing dependencies" green
}

move_styles() {
    print_colored_message "Starting to move library files" green
    mkdir ./$PROJECT_NAME/src/styles
    cp $SCRIPTPATH/styles/grid-system.scss ./$PROJECT_NAME/src/styles/grid-system.scss
    print_colored_message "Ended moving library files" green
}

main() {
    print_colored_message "Starting to create project" green
    generate_project
    install_dependencies
    move_styles
    print_colored_message "Ended creating project" green
}

if [[ $PROJECT_NAME = '' || $PROJECT_NAME = '-h' || $PROJECT_NAME = '--help' ]]; then
    show_help
    exit 1
else
    validate_component_name
    main
    exit 0
fi
