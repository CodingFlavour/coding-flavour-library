#!/bin/bash
PROJECT_NAME=$1
# Esto tendria que ir a un config o algo
# STATICS
ERROR_UPPERCASE="Error: Project name must start with a lowercase letter."
DEFAULT_VIEWS_ROUTE=./$PROJECT_NAME/src/app
PATH_TO_LOCALE_FILE="./template/tsx/page.tsx"

# DYNAMICS
dryMode=false
debug=false
FULLSCRIPTPATH="${BASH_SOURCE[0]}"
SCRIPTPATH=$(dirname "$FULLSCRIPTPATH")
LOGSPATH="$PWD/logs"

# import core scripts
source $SCRIPTPATH/../dev-ups-scripts/utils/log/log.sh
source $SCRIPTPATH/../dev-ups-scripts/config/modify-env-vars.sh
# import helpers
source $SCRIPTPATH/helpers/flags.sh
source $SCRIPTPATH/../common/helpers/npm-package.sh
source $SCRIPTPATH/../dev-ups-scripts/utils/log/log.sh
# import main generators
source $SCRIPTPATH/front/create-front-project.sh
source $SCRIPTPATH/back/create-back-project.sh
source $SCRIPTPATH/coding-flavour-libraries.sh

# Views related
interactiveMode=true
views=''
path=$DEFAULT_VIEWS_ROUTE
localBoilerplate=$PATH_TO_LOCALE_FILE

validate_component_name() {
    local first_char=${PROJECT_NAME:0:1}

    if [[ ! "$first_char" =~ [[:lower:]] ]]; then
        print_colored_message "$ERROR_UPPERCASE" "red"
        exit 1
    fi
}

get_arch() {
    if [[ $interactiveMode = true ]]; then
        read -p "* Do you want to create a front project? (y/n) " -n 1 -r
        echo

        if [[ $REPLY =~ ^[Nn]$ ]]; then
            read -p "* Do you want to create a back project? (y/n) " -n 1 -r
            echo

            if [[ $REPLY =~ ^[Nn]$ ]]; then
                log "No architecture selected. Exiting."
                exit 1
            else 
                create_back_project
            fi
        else 
            create_front_project
        fi
    fi
}

create_logs_dir_if_not_exists() {
    if [[ ! -d "$LOGSPATH" ]]; then
        if ! mkdir -p "$LOGSPATH" 2> /dev/null; then
            log "Failed to create logs directory at $LOGSPATH. Check permissions and available space."
            exit 1
        fi
    fi
}

main() {
    set_prefix "MAIN"
    log "Starting to create project"
    create_logs_dir_if_not_exists
    get_arch
    install_common_coding_flavour_libraries
    log "Ended creating project"
}

if [[ $PROJECT_NAME = '' || $PROJECT_NAME = '-h' || $PROJECT_NAME = '--help' ]]; then
    source $SCRIPTPATH/helpers/help.sh
    show_help
    exit 0
fi

validate_component_name
parse_flags $@
main
exit 0
