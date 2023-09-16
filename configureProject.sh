#!/bin/bash
PROJECT_NAME=$1
ERROR_UPPERCASE="Error: Component name must start with a lowercase letter."
FULLSCRIPTPATH="${BASH_SOURCE[0]}"
SCRIPTPATH=$(dirname "$FULLSCRIPTPATH")
source $SCRIPTPATH/helper.sh

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
    cp $SCRIPTPATH/styles/main.scss ./$PROJECT_NAME/src/presentation/styles/main.scss
    cp $SCRIPTPATH/styles/base/grid-system.scss ./$PROJECT_NAME/src/presentation/styles/base/grid-system.scss
    print_colored_message "Ended moving library files" green
}

create_root_dir_front() {
    print_colored_message "Creating folders tree in root" green
    mkdir ./$PROJECT_NAME/src/presentation/
    mkdir ./$PROJECT_NAME/src/presentation/pages
    mkdir ./$PROJECT_NAME/src/presentation/layouts
    mkdir ./$PROJECT_NAME/src/presentation/components
    mkdir ./$PROJECT_NAME/src/presentation/styles
    mkdir ./$PROJECT_NAME/src/presentation/styles/utilities
    mkdir ./$PROJECT_NAME/src/presentation/styles/base
    mkdir ./$PROJECT_NAME/src/presentation/styles/pages
    mkdir ./$PROJECT_NAME/src/presentation/styles/layouts
    mkdir ./$PROJECT_NAME/src/presentation/styles/components
    print_colored_message "Ended creating folders tree in root" green
}

main() {
    print_colored_message "Starting to create project" green
    generate_project
    install_dependencies
    create_root_dir_front
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
