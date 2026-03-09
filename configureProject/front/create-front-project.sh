
source $SCRIPTPATH/generateViews.sh

create_front_project() {
    set_prefix "FRONT"
    generate_project
    install_dependencies
    generate_views
    install_front_coding_flavour_libraries
}

# Generates main project in NextJS
generate_project() {
    print_colored_message "Starting to create NextJS project" green
    if [[ $dryMode == false ]]; then
        npx create-next-app \
        $PROJECT_NAME \
        --ts \
        --eslint \
        --src-dir \
        --no-tailwind \
        --import-alias '@/*' \
        --app \
        --yes
    fi
    print_colored_message "Ended creating NextJS project" green
}

install_dependencies() {
    print_colored_message "Starting to install dependencies" green
    if [[ $dryMode == false ]]; then
        npm install --prefix ./$PROJECT_NAME/ sass
    fi
    print_colored_message "Ended installing dependencies" green
}