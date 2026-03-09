# Until I can have my own HomeLab, we cannot afford to have TS in the backend. Once I get it, this functionality will be enabled again.
_CREATE_BACK_DEPRECATED_TS=1

create_back_project() {
    set_prefix "BACK"

    log "Starting to create Back project"

    create_structure

    log "Ended creating Back project"

    erase_prefix
}

create_structure() {
    log "Creating project structure"

    if [[ $dryMode == false ]]; then
        mkdir -p $PROJECT_NAME
        cd $PROJECT_NAME
    else
        log_on_dry "Dry mode is active. Project structure not created"
        log_on_dry "Expected structure: ./$PROJECT_NAME/"
    fi

    log "Generating package.json"

    if [[ $dryMode == false ]]; then
        npm init -y >"$LOGSPATH/npm_init.log"

        if [[ $? -ne 0 ]]; then
            log "Failed to generate package.json. Check $LOGSPATH/npm_init.log for more details"
            exit 1
        fi
    else
        log_on_dry "Dry mode is active. package.json not generated"
        log_on_dry "Expected file: ./$PROJECT_NAME/package.json"
    fi

    if [[ $_CREATE_BACK_DEPRECATED_TS -eq 1 ]]; then
        log "Skipping TypeScript installation and initialization for Back project. This functionality is currently deprecated until HomeLab is available."
        log "Once HomeLab is available, this will be re-enabled and the project will be created with TypeScript support by default."
    else
        log "Installing typescript and initializing tsconfig"

        if [[ $dryMode == false ]]; then
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
            log_on_dry "Dry mode is active. Typescript not installed and tsconfig not initialized"
            log_on_dry "Expected files: ./$PROJECT_NAME/node_modules/typescript, ./$PROJECT_NAME/tsconfig.json"
        fi

        log "Installing express"

    fi

    if [[ $dryMode == false ]]; then
        npm i express >"$LOGSPATH/npm_express_install.log"

        if [[ $? -ne 0 ]]; then
            log "Failed to install Express. Check $LOGSPATH/npm_express_install.log for more details"
            exit 1
        fi
    else
        log_on_dry "Dry mode is active. Express not installed"
        log_on_dry "Expected files: ./$PROJECT_NAME/node_modules/express"
    fi

    local scripts=(
        "dev WITH_VALUE node --env-file=.env.development index.js"
    )

    add_scripts_to_package_json "${scripts[@]}"

    log "Cleaning placeholder scripts"
    remove_scripts_from_package_json "test" "start"

    modify_env_vars
    
    cd - || exit 1
}

modify_env_vars() {
    log "Creating environment files"

    # TODO: Implement flags support (--back-end-port, --front-end-port)
    # TODO: Implement interactive mode for port selection
    # TODO: Implement .route-table system for intelligent port assignment
    # TODO: Implement logic to detect -backend suffix and find corresponding frontend project
    
    local back_end_port=4000
    local front_end_port=3000

    # Create environment files content
    local env_content="BACK_END_PORT=${back_end_port}
FRONT_END_PORT=${front_end_port}"

    local env_example_content="BACK_END_PORT=4000
FRONT_END_PORT=3000"

    if [[ $dryMode == false ]]; then
        # Create .env file
        echo "$env_content" > .env
        if [[ $? -ne 0 ]]; then
            log_error "Failed to create .env file"
            exit 1
        fi
        log "Created .env file with BACK_END_PORT=${back_end_port} and FRONT_END_PORT=${front_end_port}"

        # Create .env.example file
        echo "$env_example_content" > .env.example
        if [[ $? -ne 0 ]]; then
            log_error "Failed to create .env.example file"
            exit 1
        fi
        log "Created .env.example file"

        # Create .env.development file (same as .env for now)
        echo "$env_content" > .env.development
        if [[ $? -ne 0 ]]; then
            log_error "Failed to create .env.development file"
            exit 1
        fi
        log "Created .env.development file"
    else
        log_on_dry "Dry mode is active. Environment files not created"
        log_on_dry "Expected files:"
        log_on_dry "  - ./$PROJECT_NAME/.env (BACK_END_PORT=${back_end_port}, FRONT_END_PORT=${front_end_port})"
        log_on_dry "  - ./$PROJECT_NAME/.env.example"
        log_on_dry "  - ./$PROJECT_NAME/.env.development"
    fi
}