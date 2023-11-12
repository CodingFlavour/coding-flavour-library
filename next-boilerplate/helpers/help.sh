show_help() {
    print_colored_message "---------------" "green"
    print_colored_message "|     HELP    |" "green"
    print_colored_message "---------------" "green"
    print_colored_message "Create a component directory structure with the given name."
    print_colored_message
    print_colored_message "Usage:" "blue"
    print_colored_message "sh ./createComponent.sh"
    print_colored_message
    print_colored_message "Options:" "blue"
    print_colored_message
    print_colored_message "  -h, --help                      Show this help message and exit."
    print_colored_message "  --routes [view1, view2...]      Creates pages with the routes template. If this object is not provided, the Script will skip this type"
    print_colored_message "  --routePath [./path/to/routes]  Saves the created pages in this folder. If this object is not provided, the Script will skip this type"
    print_colored_message "  --dryMode                       Run Sript without creating files"
    print_colored_message "  --debug                         Prints more messages that can be helpful to fix an issue"
}
