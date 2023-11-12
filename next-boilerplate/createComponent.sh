#!/bin/bash

# Grabbing user path to create the files
USERPATH=$(pwd)
FULLSCRIPTPATH="${BASH_SOURCE[0]}"
SCRIPTPATH=$(dirname "$FULLSCRIPTPATH")

# User input
FILENAME=$1
FILEPATH=$2

# Flags
routePath=""
routeNames=""
routeBoilerplate="${SCRIPTPATH}/templates/routes/base-page.tsx"
dryMode=false
help=false
debug=false

# Import files
source $SCRIPTPATH/../common/helpers/log.sh
source $SCRIPTPATH/helpers/utils.sh
source $SCRIPTPATH/helpers/flags.sh
source $SCRIPTPATH/main.sh

# Parsing user flags
parse_flags $@

if [[ $help = true ]]; then
    source $SCRIPTPATH/helpers/help.sh
    show_help
    exit 1
else
    # validate_component_name

    if [[ $dryMode = true ]]; then
        print_colored_message "Dry mode activated. No changes will be persisted." yellow
    fi
    if [[ $debug = true ]]; then
        debug "Debug mode activated. More logs will print with the [DEBUG] tag."
    fi

    main
    exit 0
fi
