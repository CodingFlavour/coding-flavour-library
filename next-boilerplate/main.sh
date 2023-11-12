source $SCRIPTPATH/generator.sh $1 $2 $3

main() {
    print_colored_message "Starting to create components" green
    generate_files
    print_colored_message "Ended creating components" green
}
