#!/bin/bash

# --views page1, page2, [lng] --viewsPath ./tuputisimamadre

# Main functions
get_if_requires_view() {
    if [[ $interactiveMode = true ]]; then
        print_colored_message "Does this project requires views?" purple
        echo -n "> "
        read requiresView
    fi
}

parse_views() {
    # Comprobar en no interactivo que haya metido algo
    if [[ $interactiveMode = true ]]; then
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
    if [[ $path = $DEFAULT_VIEWS_ROUTE ]]; then
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
    if [[ $localBoilerplate = $PATH_TO_LOCALE_FILE ]]; then
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
    for i in $views; do
        view=$(print_colored_message "$i" | cut -d ',' -f 1)
        print_colored_message "- Replicating boilerplate from ${localBoilerplate} to ${path}/${view}/page.ts" blue
        if [[ $dryMode = false ]]; then
            mkdir -p ./${path}/${view} && cp $localBoilerplate ./${path}/${view}/page.ts
        fi
    done
}

generate_views() {
    local requiresView=''
    get_if_requires_view

    if [[ $requiresView = 'y' || $interactiveMode = false ]]; then
        parse_views
        get_path
        get_local_boilerplate
        replicate_views
    fi
}
