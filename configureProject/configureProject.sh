#!/bin/bash
PROJECT_NAME=$1
# Esto tendria que ir a un config o algo
# STATICS
DEFAULT_VIEWS_ROUTE=./$PROJECT_NAME/src/app
PATH_TO_LOCALE_FILE="./template/tsx/page.tsx"

# DYNAMICS
_DRY_MODE=false
_DEBUG=false
PROJECT_TYPE=""
FULLSCRIPTPATH="${BASH_SOURCE[0]}"
SCRIPTPATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOGSPATH="$PWD/logs"

# load .bashrc if exists, to get user custom env vars
if [[ -f "$SCRIPTPATH/.bashrc" ]]; then
    source "$SCRIPTPATH/.bashrc"
fi

# import core scripts
source $SCRIPTPATH/../dev-ups-scripts/utils/log/log.sh
source $SCRIPTPATH/../dev-ups-scripts/config/modify-env-vars.sh
# import helpers
source $SCRIPTPATH/helpers/flags.sh
source $SCRIPTPATH/../common/helpers/npm-package.sh
source $SCRIPTPATH/../dev-ups-scripts/utils/log/log.sh
source $SCRIPTPATH/../i18n/i18n.sh
# import main generators
source $SCRIPTPATH/front/create-front-project.sh
source $SCRIPTPATH/back/create-back-project.sh
source $SCRIPTPATH/coding-flavour-libraries.sh

# Views related
_INTERACTIVE_MODE=true
views=''
path=$DEFAULT_VIEWS_ROUTE
localBoilerplate=$PATH_TO_LOCALE_FILE
# creo que voy a cambiar como declaro estas variables, que sean un poco mas tipo global
_FRONT_END_PORT=
_BACK_END_PORT=

_set_config() {
    local route_path=${ROUTE_TABLE_PATH:-"$PWD"}

    export CODING_FLAVOUR_PROJECTS_PATH="$PWD"
    export ROUTE_TABLE_FILE="$route_path/.route-table"

    # Reload global config variables after setting them
    source $SCRIPTPATH/../dev-ups-scripts/config/config.sh
    source $SCRIPTPATH/../dev-ups-scripts/utils/route-table/route-table.sh
}

validate_component_name() {
    local first_char=${PROJECT_NAME:0:1}

    if [[ ! "$first_char" =~ [[:lower:]] ]]; then
        log_error "$ERROR_PROJECT_NOT_UPPERCASE"
        exit 1
    fi
}

get_arch() {
    if [[ $_INTERACTIVE_MODE = true ]]; then
        read -p "* Do you want to create a front project? (y/n) " -n 1 -r
        echo

        if [[ $REPLY =~ ^[Nn]$ ]]; then
            read -p "* Do you want to create a back project? (y/n) " -n 1 -r
            echo

            if [[ $REPLY =~ ^[Nn]$ ]]; then
                log_error "No architecture selected. Exiting."
                exit 1
            else
                PROJECT_TYPE="back"
                create_back_project
            fi
        else
            PROJECT_TYPE="front"
            create_front_project
        fi
    fi
}

create_logs_dir_if_not_exists() {
    if [[ ! -d "$LOGSPATH" ]]; then
        if ! mkdir -p "$LOGSPATH" 2>/dev/null; then
            log_error "Failed to create logs directory at $LOGSPATH. Check permissions and available space."
            exit 1
        fi
    fi
}

main() {
    push_prefix "MAIN"
    log "Starting to create project"
    
    _set_config
    create_logs_dir_if_not_exists
    get_arch
    install_common_coding_flavour_libraries
    
    log "Ended creating project"
    pop_prefix
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
