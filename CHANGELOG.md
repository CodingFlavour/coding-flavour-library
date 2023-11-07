# Changelog

## V.1.3

- Routes generator: Generates routes for the projects, there are 2 ways:
  - Interactive mode: The Script will ask for several things:
    - Route names: String with all the routes that needs to be created, separated by comma. Example: `> home, about, [articleId]`
    - Path: If you want to override the default path to save the pages. Example: `> ./src/presentation/routes`
    - Boilerplate: If you want to provide your own boilerplate file. Example: `> ~/projects/custom-project/src/pages/index.ts`
  - Non-interactive mode: The values mentioned earlier can be overridden with several flags. Check `-h | --help` to get more information.
- Deprecated several functions that are not in compliance with the current Coding Flavour architecture
  - `configureProject.move_styles` => Needs update with all new files
  - `configureProject.create_root_dir_front` => Needs update after previous function
- Added dry mode to execute the Script in read mode, without applying changes. Check `-h | --help` to get more information.
- Isolated flags parser (new) and logger to `helpers` folder
- Updated `--help` with the new flags
