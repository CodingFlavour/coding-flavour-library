source "${SCRIPTPATH}/helpers/utils.sh"

parse_flags() {
    local caseFlag=''
    for i in $@; do
        # Activating flags
        case $i in
        '--routes')
            caseFlag='routes'
            ;;
        '--routePath')
            caseFlag='routePath'
            ;;
        '--dryMode')
            dryMode=true
            ;;
        '--help')
            help=true
            ;;
        '--debug')
            debug=true
            ;;
        esac

        # Adding all params to corresponding var
        if [[ $i != *'--'* ]]; then
            if [[ $caseFlag = 'routes' ]]; then
                routeNames="${routeNames} ${i}"
            fi
            if [[ $caseFlag = 'routePath' ]]; then
                routePath=$i
            fi

        fi
    done
}
