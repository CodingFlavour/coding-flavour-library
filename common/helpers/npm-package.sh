add_scripts_to_package_json() {
    local scripts=("$@")

    push_prefix "NPM_PACKAGE"

    log "Adding scripts to <package.json>"
    log_debug "Scripts to add: ${scripts[@]}"

    for script in "${scripts[@]}"; do
        local arr=(${script//"WITH_VALUE"/ })
        local script_name=${arr[0]}
        local script_value=${arr[@]:1}

        log_debug "|- Script Value: ${script_value}"

        local script_value_arr=(${script_value//"WITH_PROJECT_TYPE"/ })
        local script_command=${script_value_arr[0]}
        local project_type_raw=${script_value_arr[@]:1}
        local project_type=""

        log_debug "Processing script: ${script_name} with command: ${script_command} and project type: ${project_type_raw}"

        if [[ -n $project_type_raw ]]; then
            project_type=$(echo $project_type_raw | sed "s/PROJECT_TYPE/--type=$PROJECT_TYPE/g")
        fi
        
        log "Adding script <${script_name}: ${script_command} ${project_type}> to <package.json>"
        log_debug "Running command: npm pkg set scripts.${script_name}=\"${script_command} ${project_type}\""
        
        if [[ $_DRY_MODE == false ]]; then    
            if ! npm pkg set scripts.${script_name}="${script_command} ${project_type}"; then
                log "Failed to add script ${script_name} to package.json"

                exit 1
            fi
        else 
            log "Dry mode is active. Script ${script_name} not added to package.json"
        fi
    done

    pop_prefix
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