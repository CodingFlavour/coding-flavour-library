# Changelog

## ✨V.1.31

- General
  - Create `common` to keep the logic that is used between all Scripts
  - Added a level system to the logger, where the level is the number of tabulations you want to append to the message before printing. If no level is provided, `0` is taken by default.
  - Updated `README`
- *Next Boilerplate*
  - Merged this tool to the project to combine all utilities
  - Added page boilerplate as default file for routes
  - Changed `example` to `templates` and restructured files in folders with their types
  - Updated `--help` to keep it up-to-date
  - Added debug mode. Activate it by using the `--debug` flag
  - Added dry mode to execute the Script in read mode, without applying changes. Check `-h | --help` to get more information.
  - Deprecated several functions that are not in compliance with the current Coding Flavour architecture
    - Talk to Daniel to get more information if you want to fix this issue
  - Added several flags to accommodate the creation of the new files
    - `--routes`: Name for the files of type `route`
    - `--routePath`: Path to save the mentioned files.
      - _If any of this isn't provided, the Script will skip the step_
    - Each _type_ has it's own boilerplate defined
- *Configure Project*
  - Updated `--help` to keep it up-to-date
  - Added debug mode. Activate it by using the `--debug` flag
  - Erased the creation of the files in this Script. Now it will execute `next-boilerplate`, which is prepared to do this task, keeping this Script as an orchestrator

## 🚀 V.1.3

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
