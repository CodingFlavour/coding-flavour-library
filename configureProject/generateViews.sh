#!/bin/bash

# --views page1, page2, [lng] --viewsPath ./example/src/app/views/[lng]

# Main functions
get_if_requires_view() {
    if [[ $_INTERACTIVE_MODE = true ]]; then
        print_colored_message "Does this project requires views?" purple
        echo -n "> "
        read requiresView
    fi
}

parse_views() {
    # Comprobar en no interactivo que haya metido algo
    if [[ $_INTERACTIVE_MODE = true ]]; then
        correct=false

        while [ $correct = false ]; do
            print_colored_message "Insert view names. Regex: page1, page2, page3" purple
            echo -n "> "
            IFS=',' read views

            for i in $views; do
                print_colored_message "- Detected page:  ${i}" blue
            done

            while [[ $correct = false ]]; do
                print_colored_message "Are the views correct?" purple
                echo -n "> "
                read correct
            done

            if [[ $correct != 'y' ]]; then
                correct=false
            fi
        done
    fi
}

# Confirmacion del path en no interactivo quizas?
get_path() {
    if [[ $_INTERACTIVE_MODE = true && $path = $DEFAULT_VIEWS_ROUTE ]]; then
        print_colored_message "Where do you want to save the structure? (Enter for Default: ${DEFAULT_VIEWS_ROUTE})" purple
        echo -n "> "
        read path

        if [[ $path = '' ]]; then
            path=$DEFAULT_VIEWS_ROUTE
        fi
    fi

    print_colored_message "Saving into ${path}" green
}

get_local_boilerplate() {
    if [[ $_INTERACTIVE_MODE = true && $localBoilerplate = $PATH_TO_LOCALE_FILE ]]; then
        print_colored_message "Do you want to use a local file as boilerplate?" purple
        echo -n "> "
        read useLocalFile

        if [[ $useLocalFile = 'y' ]]; then
            print_colored_message "Insert path to local file" purple
            echo -n "> "
            read localBoilerplate
        fi
    fi
}

replicate_views() {
    local is_dry_mode=""
    local is_debug=""

    if [[ $_DRY_MODE == true ]]; then
        is_dry_mode='--dry-mode'
    fi
    if [[ $_DEBUG == true ]]; then
        is_debug='--debug'
    fi

    # Corregir a alias y comprobar que el usuario pueda usar el alias
    source "${SCRIPTPATH}/../next-boilerplate/createComponent.sh" --routes $views --routePath $path $is_dry_mode $is_debug
    # for i in $views; do
    #     view=$(print_colored_message "$i" | cut -d ',' -f 1)
    #     print_colored_message "- Replicating boilerplate from ${localBoilerplate} to ${path}/${view}/page.ts" blue
    #     if [[ $_DRY_MODE = false ]]; then
    #         mkdir -p ./${path}/${view} && cp $localBoilerplate ./${path}/${view}/page.ts
    #     fi
    # done
}

generate_views() {
    local requiresView=''
    get_if_requires_view

    # TODO: Estoy suponiendo que si no es interactivo siempre quiere views?? habria que comprobar si viene algun flag
    if [[ $requiresView = 'y' || $_INTERACTIVE_MODE = false ]]; then
        parse_views
        get_path
        get_local_boilerplate
        replicate_views
    fi
}
