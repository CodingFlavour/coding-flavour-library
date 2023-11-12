show_help() {
    print_colored_message "---------------" "green"
    print_colored_message "|     HELP    |" "green"
    print_colored_message "---------------" "green"
    print_colored_message "Creates a project with all the utilities needed for a new Coding Flavour project by the given name."
    print_colored_message
    print_colored_message "Usage:" "blue"
    print_colored_message "sh ./configureProject.sh [project_name]"
    print_colored_message
    print_colored_message "[project_name]: Must start with a lowercase letter"
    print_colored_message
    print_colored_message "Regular usage starts with full interactive mode"
    print_colored_message
    print_colored_message "Options:" "blue"
    print_colored_message "  -h, --help                                                 Show this help message and exit."
    print_colored_message "  --views [view1, view2...]                                  Injects the names of the views (Stops this interactive section)"
    print_colored_message "  --viewsPath [./path/to/views]                              Injects path to new views folder (Stops this interactive section)"
    print_colored_message "  --viewsLocalBoilerplate [./path/to/localBoilerplate.file]  Uses local boilerplate as base file for new views (Stops this interactive section)"
    print_colored_message "  --dryMode                                                  Run Sript without creating files"
    print_colored_message "  --debug                                                    Prints more messages that can be helpful to fix an issue"
}
