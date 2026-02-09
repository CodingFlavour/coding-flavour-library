#!/bin/bash

# import helpers
source $SCRIPTPATH/../common/helpers/log.sh

# Static variables
CODING_FLAVOUR_DEPENDENCIES=(
    "companion",
    "vscode-settings",
    "icons",
    "styles",
    "common"
)

SCRIPTS=(
    '"companion:install": "tsx -r tsconfig-paths/register ./node_modules/@coding-flavour/companion/src/bin/companion.ts install"',
    'vscode:install": "vscode-settings install"'
)

# Main function to install coding flavour libraries

install_coding_flavour_libraries() {
    print_colored_message "Starting to install Coding Flavour libraries" green

    if [[ $dryMode = false ]]; then
        install_dependencies
        add_scripts_to_package_json
        execute_scripts
    fi
    
    print_colored_message "Ended installing Coding Flavour libraries" green
}

install_dependencies() {
    for library in "${CODING_FLAVOUR_DEPENDENCIES[@]}"; do
        npm install --prefix ./$PROJECT_NAME/ @coding-flavour/$library
    done
}

add_scripts_to_package_json() {
    for script in "${SCRIPTS[@]}"; do
        npx --prefix ./$PROJECT_NAME/ json -I -f ./$PROJECT_NAME/package.json -e "this.scripts[${script%%:*}] = ${script#*:}"
    done
}

execute_scripts() {
    npm run --prefix ./$PROJECT_NAME/ companion:install
    npm run --prefix ./$PROJECT_NAME/ vscode:install
}