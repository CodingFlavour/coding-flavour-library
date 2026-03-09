add_scripts_to_package_json() {
    local scripts=("$@")

    set_prefix "NPM_PACKAGE"

    log "Adding scripts to package.json"
    log_debug "Scripts to add: ${scripts[@]}"

    for script in "${scripts[@]}"; do
        log "Adding script ${script%%:*} to package.json"

        if [[ $dryMode == false ]]; then
            local arr=(${script//"WITH_VALUE"/ })
            local script_name=${arr[0]}
            local script_command=${arr[@]:1}

            log_debug "Running command: npm --prefix ./${PROJECT_NAME}/ pkg set scripts.${script_name}=${script_command}"
            
            if ! npm --prefix ./${PROJECT_NAME}/ pkg set scripts.${script_name}="${script_command}"; then
                log "Failed to add script ${script_name} to package.json"

                exit 1
            fi
        else 
            log "Dry mode is active. Script ${script_name} not added to package.json"
        fi
    done

    erase_prefix
}

remove_scripts_from_package_json() {
    local scripts=("$@")

    for script in "${scripts[@]}"; do
        log "Removing script ${script} from package.json"

        if [[ $dryMode == false ]]; then
            if ! npm --prefix ./${PROJECT_NAME}/ pkg delete scripts.$script; then
                log "Script ${script} not found in package.json"

                exit 1
            fi
        else 
            log "Dry mode is active. Script ${script} not removed from package.json"
        fi
    done
}