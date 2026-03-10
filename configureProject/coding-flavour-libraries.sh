#!/bin/bash

# Static variables
COMMON_CODING_FLAVOUR_DEPENDENCIES=(
    "companion"
    "vscode-settings"
)

FRONT_CODING_FLAVOUR_DEPENDENCIES=(
    "icons"
    "styles"
    "common"
)

CODING_FLAVOUR_SCRIPTS=(
    "companion:install WITH_VALUE companion install"
    "vscode:install WITH_VALUE vscode-settings install"
)

# Main function to install coding flavour libraries
install_common_coding_flavour_libraries() {
    set_prefix "CODING_FLAVOUR_LIBRARIES"

    log "Starting to install Coding Flavour libraries"

    if [[ $_DRY_MODE == false ]]; then
        install_common_coding_flavour_dependencies
    fi

    add_scripts_to_package_json "${CODING_FLAVOUR_SCRIPTS[@]}"
    execute_scripts

    log "Ended installing Coding Flavour libraries"
}

install_front_coding_flavour_libraries() {
    set_prefix "CODING_FLAVOUR_LIBRARIES"

    log "Starting to install Front Coding Flavour libraries"

    if [[ $_DRY_MODE == false ]]; then
        for library in "${FRONT_CODING_FLAVOUR_DEPENDENCIES[@]}"; do
            npm install @coding-flavour/$library
        done
    fi

    log "Ended installing Front Coding Flavour libraries"
}

install_common_coding_flavour_dependencies() {
    for library in "${COMMON_CODING_FLAVOUR_DEPENDENCIES[@]}"; do
        npm install @coding-flavour/$library
    done
}

execute_scripts() {
    if [[ $_DRY_MODE == false ]]; then
        npm run companion:install
        npm run vscode:install
    fi
}
