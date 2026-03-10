add_scripts_to_package_json() {
    local scripts=("$@")

    set_prefix "NPM_PACKAGE"

    log "Adding scripts to package.json"
    log_debug "Scripts to add: ${scripts[@]}"

    for script in "${scripts[@]}"; do

        if [[ $_DRY_MODE == false ]]; then
            local arr=(${script//"WITH_VALUE"/ })
            local script_name=${arr[0]}
            local script_command=${arr[@]:1}

            log "Adding script <${script_name}: ${script_command}> to <package.json>"
            log_debug "Running command: npm pkg set scripts.${script_name}=\"${script_command}\""
            
            if ! npm pkg set scripts.${script_name}="${script_command}"; then
                log "Failed to add script ${script_name} to package.json"

                exit 1
            fi
        else 
            log "Dry mode is active. Script ${script_name} not added to package.json"
        fi
    done
}

remove_scripts_from_package_json() {
    local scripts=("$@")

    for script in "${scripts[@]}"; do
        log "Removing script ${script} from package.json"

        if [[ $_DRY_MODE == false ]]; then
            if ! npm pkg delete scripts.$script; then
                log "Script ${script} not found in package.json"

                exit 1
            fi
        else 
            log "Dry mode is active. Script ${script} not removed from package.json"
        fi
    done
}