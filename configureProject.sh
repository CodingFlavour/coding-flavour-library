#!/bin/bash
PROJECT_NAME=$1
# Esto tendria que ir a un config o algo
# STATICS
ERROR_UPPERCASE="Error: Project name must start with a lowercase letter."
DEFAULT_VIEWS_ROUTE=./$PROJECT_NAME/src/app
PATH_TO_LOCALE_FILE="./styles/main.scss"

# DYNAMICS
dryMode=false
FULLSCRIPTPATH="${BASH_SOURCE[0]}"
SCRIPTPATH=$(dirname "$FULLSCRIPTPATH")

# import helpers
source $SCRIPTPATH/helpers/log.sh
source $SCRIPTPATH/generateViews.sh

# Views related
interactiveMode=true
views=''
path=$DEFAULT_VIEWS_ROUTE
localBoilerplate=$PATH_TO_LOCALE_FILE

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
    print_colored_message "Regular usage starts with full interactive mode"
    print_colored_message
    print_colored_message "Options:" "blue"
    print_colored_message "  -h, --help                                               Show this help message and exit."
    print_colored_message "  --views [view1, view2...]                                Injects the names of the views (Stops this interactive section)"
    print_colored_message "  --viewsPath [./path/to/views]                            Injects path to new views folder (Stops this interactive section)"
    print_colored_message "  --viewsLocalBoilerplate [./path/to/localBoilerplate.file]     Uses local boilerplate as base file for new views (Stops this interactive section)"
    print_colored_message "  --dryMode                                                Run Sript without creating files"
}

validate_component_name() {
    local first_char=${PROJECT_NAME:0:1}

    if [[ ! "$first_char" =~ [[:lower:]] ]]; then
        print_colored_message "$ERROR_UPPERCASE" "red"
        exit 1
    fi
}

# Generates main project in NextJS
generate_project() {
    print_colored_message "Starting to create NextJS project" green
    if [[ $dryMode = false ]]; then
        npx create-next-app $PROJECT_NAME --ts --eslint --src-dir --no-tailwind --import-alias '@/*' --app
    fi
    print_colored_message "Ended creating NextJS project" green
}

install_dependencies() {
    print_colored_message "Starting to install dependencies" green
    if [[ $dryMode = false ]]; then
        npm install --prefix ./$PROJECT_NAME/ sass
    fi
    print_colored_message "Ended installing dependencies" green
}

# @deprecated Hay que comprobara si se puede reutilizar
# move_styles() {
#     print_colored_message "Starting to move library files" green
#     cp $SCRIPTPATH/styles/main.scss ./$PROJECT_NAME/src/presentation/styles/main.scss
#     cp $SCRIPTPATH/styles/base/grid-system.scss ./$PROJECT_NAME/src/presentation/styles/base/grid-system.scss
#     print_colored_message "Ended moving library files" green
# }

# @deprecated El script ahora se monta de otra manera
# create_root_dir_front() {
#     print_colored_message "Creating folders tree in root" green
#     mkdir ./$PROJECT_NAME/src/presentation/
#     mkdir ./$PROJECT_NAME/src/presentation/pages
#     mkdir ./$PROJECT_NAME/src/presentation/layouts
#     mkdir ./$PROJECT_NAME/src/presentation/components
#     mkdir ./$PROJECT_NAME/src/presentation/styles
#     mkdir ./$PROJECT_NAME/src/presentation/styles/utilities
#     mkdir ./$PROJECT_NAME/src/presentation/styles/base
#     mkdir ./$PROJECT_NAME/src/presentation/styles/pages
#     mkdir ./$PROJECT_NAME/src/presentation/styles/layouts
#     mkdir ./$PROJECT_NAME/src/presentation/styles/components
#     print_colored_message "Ended creating folders tree in root" green
# }

main() {
    print_colored_message "Starting to create project" green
    generate_project
    install_dependencies
    generate_views
    # create_root_dir_front
    # move_styles
    print_colored_message "Ended creating project" green
}

if [[ $PROJECT_NAME = '' || $PROJECT_NAME = '-h' || $PROJECT_NAME = '--help' ]]; then
    show_help
    exit 1
else
    validate_component_name
    parse_flags $@
    main
    exit 0
fi
