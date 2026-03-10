# Until I can have my own HomeLab, we cannot afford to have TS in the backend. Once I get it, this functionality will be enabled again.
_CREATE_BACK_DEPRECATED_TS=1

create_back_project() {
    set_prefix "BACK"

    log "Starting to create Back project"

    create_structure

    log "Ended creating Back project"
}

create_structure() {
    log "Creating project structure"

    if [[ $_DRY_MODE == false ]]; then
        mkdir -p $PROJECT_NAME
        cd $PROJECT_NAME
    else
        log "Dry mode is active. Project structure not created"
        log "Expected structure: ./$PROJECT_NAME/"
    fi

    log "Generating package.json"

    if [[ $_DRY_MODE == false ]]; then
        npm init -y >"$LOGSPATH/npm_init.log"

        if [[ $? -ne 0 ]]; then
            log "Failed to generate package.json. Check $LOGSPATH/npm_init.log for more details"
            exit 1
        fi
    else
        log "Dry mode is active. package.json not generated"
        log "Expected file: ./$PROJECT_NAME/package.json"
    fi

    if [[ $_CREATE_BACK_DEPRECATED_TS -eq 1 ]]; then
        log "Skipping TypeScript installation and initialization for Back project. This functionality is currently deprecated until HomeLab is available."
        log "Once HomeLab is available, this will be re-enabled and the project will be created with TypeScript support by default."
    else
        log "Installing typescript and initializing tsconfig"

        if [[ $_DRY_MODE == false ]]; then
            npm i typescript >"$LOGSPATH/npm_typescript_install.log"

            if [[ $? -ne 0 ]]; then
                log "Failed to install TypeScript. Check $LOGSPATH/npm_typescript_install.log for more details"
                exit 1
            fi

            npx tsc --init >"$LOGSPATH/tsc_init.log"

            if [[ $? -ne 0 ]]; then
                log "Failed to initialize TypeScript. Check $LOGSPATH/tsc_init.log for more details"
                exit 1
            fi
        else
            log "Dry mode is active. Typescript not installed and tsconfig not initialized"
            log "Expected files: ./$PROJECT_NAME/node_modules/typescript, ./$PROJECT_NAME/tsconfig.json"
        fi

        log "Installing express"

    fi

    if [[ $_DRY_MODE == false ]]; then
        npm i express >"$LOGSPATH/npm_express_install.log"

        if [[ $? -ne 0 ]]; then
            log "Failed to install Express. Check $LOGSPATH/npm_express_install.log for more details"
            exit 1
        fi
    else
        log "Dry mode is active. Express not installed"
        log "Expected files: ./$PROJECT_NAME/node_modules/express"
    fi

    local scripts=(
        "dev WITH_VALUE node --env-file=.env index.js"
    )

    add_scripts_to_package_json "${scripts[@]}"

    log "Cleaning placeholder scripts"
    remove_scripts_from_package_json "test" "start"

    modify_env_vars
}

modify_env_vars() {
    log "Creating environment files"

    local front_end_port=0
    local back_end_port=0
    local path="$CF_PROJECTS_PATH/$PROJECT_NAME"

    if [[ $_DRY_MODE == false ]]; then
        _modify_env_vars "$PROJECT_NAME" "FRONT_END_PORT" "0"
        _modify_env_vars "$PROJECT_NAME" "BACK_END_PORT" "0"

        if ! mv "$path/.env" "$path/.env.example"; then
            log "Failed to rename .env to .env.example for project $PROJECT_NAME. Check if the file exists and if you have the necessary permissions."
            exit 1
        fi
    else
        log "Dry mode is active. Environment variables not modified and .env file not renamed to .env.example"
        log "Expected modifications to .env files:"
        log "  - FRONT_END_PORT=0"
        log "  - BACK_END_PORT=0"
        log "Expected file changes: ./$PROJECT_NAME/.env renamed to ./$PROJECT_NAME/.env.example"
    fi

    if [[ -n "$_FRONT_END_PORT" ]]; then
        front_end_port=$_FRONT_END_PORT
    fi

    if [[ -n "$_BACK_END_PORT" ]]; then
        back_end_port=$_BACK_END_PORT
    fi

    if [[ $_INTERACTIVE_MODE == true ]]; then
        if [[ "$front_end_port" == "0" ]]; then
            read -p "* Enter the port for the Frontend (default: 3000 - automatic: 0): " front_end_port

            if [[ "$front_end_port" != "0" ]]; then
                front_end_port=${front_end_port:-3000}
            fi
        fi

        if [[ "$back_end_port" == "0" ]]; then
            read -p "* Enter the port for the Backend (default: 4000 - automatic: 0): " back_end_port

            if [[ "$back_end_port" != "0" ]]; then
                back_end_port=${back_end_port:-4000}
            fi
        fi
    fi

    if [[ "$front_end_port" == "0" && "$PROJECT_NAME" == *_BACKEND ]]; then
        local base_name=${PROJECT_NAME%_BACKEND}
        local corresponding_frontend_port

        log "Project name ends with -backend but no Frontend port specified. Attempting to find corresponding Frontend project in route table."
        corresponding_frontend_port=$(get_N_port_by_application 1 "$base_name")

        if [[ -n "$corresponding_frontend_port" ]]; then
            front_end_port=$corresponding_frontend_port
            log "Found corresponding Frontend project with port $front_end_port. Assigned to FRONT_END_PORT."
        else
            log "No corresponding Frontend project found in route table. Will assign automatic port later."
        fi
    fi

    if [[ "$front_end_port" == "0" ]]; then
        log "No Frontend port specified. Searching for next available port starting from 3000"
        front_end_port=$(get_next_available_port 3000 1)
        log "Assigned Frontend port: $front_end_port"
    fi

    if [[ "$back_end_port" == "0" ]]; then
        log "No Backend port specified. Searching for next available port starting from 4000"
        back_end_port=$(get_next_available_port 4000 2)
        log "Assigned Backend port: $back_end_port"
    fi

    # @TODO: esto va a cambiar en la siguiente alpha para quitarle el '_' porque no es privada la funcion en devups, cuidadito
    if [[ $_DRY_MODE == false ]]; then
        _modify_env_vars "$PROJECT_NAME" "FRONT_END_PORT" "$front_end_port"
        _modify_env_vars "$PROJECT_NAME" "BACK_END_PORT" "$back_end_port"
    else
        log "Dry mode is active. Environment variables not modified"
        log "Expected modifications to .env files:"
        log "  - FRONT_END_PORT=$front_end_port"
        log "  - BACK_END_PORT=$back_end_port"
    fi
}

# |------------------------------------------------------------|
# | Tests rapidos hasta que implemente el framework de testing |
# |------------------------------------------------------------|

# Comprobando Modify Env Vars Unitariamente
# SCRIPT_DIR=$(dirname "$FULLSCRIPTPATH")
# CODING_FLAVOUR_PROJECTS_PATH="$SCRIPT_DIR/test-projects"
# source $SCRIPT_DIR/../../dev-ups-scripts/config/modify-env-vars.sh
# source $SCRIPT_DIR/../../dev-ups-scripts/config/config.sh
# source $SCRIPT_DIR/../../dev-ups-scripts/utils/log/log.sh
# source $SCRIPT_DIR/../../dev-ups-scripts/utils/utils/utils.sh
# source $SCRIPT_DIR/../../dev-ups-scripts/utils/route-table/route-table.sh
# set_prefix "TEST_MODIFY_ENV_VARS"
# PROJECT_NAME="test-app"

# _test=2
# if [[ $_test -eq 1 ]]; then
#     # CODING_FLAVOUR_PROJECTS_PATH="$PWD/test-projects"
#     # export ROUTE_TABLE_PATH="$CF_PROJECTS_PATH/test-route-table"
#     # source $PWD/../../config/config.sh

#     modify_env_vars
# # Esperado: Mensaje de .env.example + .route-table no encontrado + Mensaje asignados puertos 3000 y 4000
# fi

# if [[ $_test -eq 2 ]]; then
#     _DRY_MODE=false
#     mkdir -p "$CF_PROJECTS_PATH/$PROJECT_NAME"
#     modify_env_vars

# # Esperado: Se crea un .env.example con FRONT_END_PORT=0 y BACK_END_PORT=0, y un .env con FRONT_END_PORT=3000 y BACK_END_PORT=4000
# # Recuerda borrar el proyecto de prueba después de correr el test, aqui no lo borramos para que lo podamos verificar manualmente
# fi
