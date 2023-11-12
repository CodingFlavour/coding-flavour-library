parse_flags() {
    local caseFlag=''
    for i in $@; do
        # Activating flags
        case $i in
        '--views')
            caseFlag='views'
            interactiveMode=false
            ;;
        '--viewsPath')
            caseFlag='viewsPath'
            interactiveMode=false
            ;;
        '--viewsLocalBoilerplate')
            caseFlag='viewsLocalBoilerplate'
            interactiveMode=false
            ;;
        '--dryMode')
            dryMode=true
            ;;
        '--debug')
            debug=true
            ;;
        esac

        # Adding all params to corresponding var
        if [[ $i != *'--'* ]]; then
            if [[ $caseFlag = 'views' ]]; then
                views="${views} ${i}"
            fi
            if [[ $caseFlag = 'viewsPath' ]]; then
                path=$i
            fi
            if [[ $caseFlag = 'viewsLocalBoilerplate' ]]; then
                localBoilerplate=$i
            fi
        fi
    done
}
