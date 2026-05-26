show_help() {
    push_prefix "HELP"

    log "---------------"
    log "|     HELP    |"
    log "---------------"
    log "Creates a project with all the utilities needed for a new Coding Flavour project by the given name."
    log
    log "Usage:"
    log "sh ./configureProject.sh [project_name]"
    log
    log "[project_name]: Must start with a lowercase letter"
    log
    log "Regular usage starts with full interactive mode"
    log
    log "Options:"
    log "  -h, --help                                                 Show this help message and exit."
    log "  --views [view1, view2...]                                  Injects the names of the views (Stops this interactive section)"
    log "  --viewsPath [./path/to/views]                              Injects path to new views folder (Stops this interactive section)"
    log "  --viewsLocalBoilerplate [./path/to/localBoilerplate.file]  Uses local boilerplate as base file for new views (Stops this interactive section)"
    log "  --dryMode                                                  Run Sript without creating files"
    log "  --debug                                                    Prints more messages that can be helpful to fix an issue"

    pop_prefix
}
