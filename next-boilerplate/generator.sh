source $SCRIPTPATH/helpers/utils.sh
source $SCRIPTPATH/index.sh
source $SCRIPTPATH/interface.sh
source $SCRIPTPATH/mock.sh
source $SCRIPTPATH/insert.sh
source $SCRIPTPATH/i18n/texts.sh
source $SCRIPTPATH/hook.sh
source $SCRIPTPATH/test_hook.sh
# @deprecated Reintegrar en algun punto
# source $SCRIPTPATH/component.sh
# source $SCRIPTPATH/test.sh

generate_files() {
    create_folders
    # @deprecated Reintegrar en algun punto
    # create_files
}

create_folders() {
    print_colored_message "$CREATING_FOLDERS" green 1
    # create_folder $SELECTED_USERNAME
    create_folder "$routePath" "${routeNames}" "${routeBoilerplate}" "routes" "page.tsx"
    # @deprecated Reintegrar en algun punto
    # create_folder "$SELECTED_USERNAME/interfaces" "interfaces"
    # create_folder "$SELECTED_USERNAME/mocks" "mocks"
    # create_folder "$SELECTED_USERNAME/components" "components"
    # create_folder "$SELECTED_USERNAME/hooks" "hooks"
    print_colored_message "$CREATING_FOLDERS_END" green 1
}

create_folder() {
    local path=$1
    local files=$2
    local boilerplate=$3
    local type=$4
    local filename=$5
    local processable=true
    debug "Files: ${files}" 2

    print_colored_message "${CREATE_FOLDER} ${type}" green 2

    # Path not provided by the user. Skipping
    if [[ $path = "" ]]; then
        print_colored_message "${ERROR_NOT_PROVIDED_PATH}" red 3
        processable=false
    fi

    # File names not provided by the user. Skipping
    if [[ $files = "" && $processable = true ]]; then
        print_colored_message "${ERROR_NOT_PROVIDED_FILES}" red 3
        processable=false
    fi

    if [[ $processable = true ]]; then
        # Loop user provided file names
        for i in $files; do
            # Erase comma from String
            file=$(echo "$i" | cut -d ',' -f 1)
            process_file $path $file
        done
    fi

    print_colored_message "${CREATE_FOLDER_END} ${type}" green 2
}

process_file() {
    local path=$1
    local file=$2

    print_colored_message "Processing file: ${file}" "green" 2

    # Folder does not exist in path
    if [[ ! -d "${path}/${file}" ]]; then
        if [[ $dryMode = false ]]; then
            mkdir -p $path/$file
        fi

        # Generating boilerplate code from file
        codeBoilerplate=$(<$boilerplate)
        code=${codeBoilerplate//REPLACE/$file}

        debug "Path to filename:" 2
        debug "${path}" 3
        debug "${file}" 3
        debug "${filename}" 3

        create_file "${path}/${file}/${filename}" "${code}"
    else
        print_colored_message "${ERROR_CREATE_FOLDER_1} ${path} ${ERROR_CREATE_FOLDER_2}" red 2
    fi
}

create_file() {
    local FILEPATH=$1
    local FILECONTENT=$2
    local FILENAME=$(basename "$FILEPATH")

    # File does not exist in path
    if [ ! -f "$FILEPATH" ]; then
        print_colored_message "${CREATE_FILE} ${FILENAME}" green 3
        print_colored_message "$FILEPATH/" yellow 3

        if [[ $dryMode = false ]]; then
            echo "$FILECONTENT" >"$USERPATH/$FILEPATH"
        fi
    else
        print_colored_message "${ERROR_CREATE_FILE_1} ${FILENAME} ${ERROR_CREATE_FILE_2}" red
    fi
}

# @deprecated Reintegrar en algun punto
# create_files() {
#     print_colored_message "Creating code" blue
#     create_file
# local FILENAME=$(basename "$SELECTED_USERNAME")
# create_file "$INDEX_PATH" "$INDEX_BOILERPLATE"
# create_file "$COMPONENT_PATH" "$COMPONENT_CODE"
# create_file "$SELECTED_USERNAME/styles.module.scss" ""
# create_file "$SELECTED_USERNAME/interfaces/index.ts" "$INTERFACE_BOILERPLATE"
# create_file "$SELECTED_USERNAME/$FILENAME.test.tsx" "$TEST_BOILERPLATE"
# create_file "$MOCK_PATH" "$MOCK_CODE"
# create_file "$HOOK_PATH" "$HOOK_CODE"
# create_file "$TEST_HOOK_PATH" "$TEST_HOOK_CODE"
# }
