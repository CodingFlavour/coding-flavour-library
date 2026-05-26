#!/bin/bash

# Realmente tengo que quitar el modo interactivo si meten flags?
# no estaria mas chulo que solo sea automatico los flags que metan?
# Revisar en el futuro, por ahora los nuevos flags no van a quitar el modo interactivo, pero si lo activan, desactivan el modo interactivo para esa parte concreta del script. Por ejemplo, si meten --front-end-port 5000, se desactiva el modo interactivo solo para la parte de asignacion de puertos y se asigna FRONT_END_PORT a 5000, pero el resto del script sigue siendo interactivo.
parse_flags() {
    set_prefix "FLAGS"

    local caseFlag=''
    for i in "$@"; do
        # Activating flags
        case $i in
        '--views')
            caseFlag='views'
            _INTERACTIVE_MODE=false
            ;;
        '--viewsPath' | '--views-path')
            caseFlag='viewsPath'
            _INTERACTIVE_MODE=false
            ;;
        '--viewsLocalBoilerplate' | '--views-local-boilerplate')
            caseFlag='viewsLocalBoilerplate'
            _INTERACTIVE_MODE=false
            ;;
        '--dryMode' | '--dry-mode')
            caseFlag=''
            log "Activating dry mode. No changes will be made to the system."
            _DRY_MODE=true
            ;;
        '--frontEndPort' | '--front-end-port')
            caseFlag='frontEndPort'
            ;;
        '--backEndPort' | '--back-end-port')
            caseFlag='backEndPort'
            ;;
        '--debug')
            caseFlag=''
            _DEBUG=true
            set_debug
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
            if [[ $caseFlag = 'frontEndPort' ]]; then
                _FRONT_END_PORT=$i
            fi
            if [[ $caseFlag = 'backEndPort' ]]; then
                _BACK_END_PORT=$i
            fi
        fi
    done
}
