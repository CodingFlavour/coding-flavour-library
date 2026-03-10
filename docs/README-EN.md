# 📚 Coding Flavour Library

![It's time to build!](https://i.makeagif.com/media/1-11-2016/ZTXL-q.gif)

## What is it?

This project is a combination of libraries created for any project generated for Coding Flavour. It contains a set of default components, palettes, and styles, along with a script responsible for project generation and linking all the tools.

## How to use it?

After cloning the repository, you need to add it as a Bash alias to be accessible from anywhere.

### Git Bash

Edit the file located at: `C:/Program Files/Git/etc/profile.d/aliases`

Add the following lines to the end of the file:

_NOTE: Do not use backslashes (\)_

```bash
alias createComponent="sh <path>/coding-flavour-library/next-boilerplate/createComponent.sh " $1 $2
alias configureProject="sh <path>/coding-flavour-library/configureProject/configureProject.sh " $1
```

This allows launching any script from any path.

### Zsh

For this terminal, navigate to the root _(If you're not sure, `cd` should get you there)_

Here, you need to determine your Source file.

To determine which file you have:

```bash

ls -ltrah .zshrc

ls -ltrah .bashrc

```

After identification, edit the file and add the following line at the end:

_NOTE: Do not use backslashes (\)_

```bash

alias createComponent="sh <path>/coding-flavour-library/next-boilerplate/createComponent.sh " $1 $2
alias configureProject="sh <path>/coding-flavour-library/configureProject/configureProject.sh " $1

```

## Usage

### Generate Project

#### Description

This Bash file initializes the introduced project and connects the libraries in the project's directory tree.

#### Basic launch

To use this script, execute the primary command of the Bash Script as follows:

```bash

sh configureProject.sh <project_name>

```

- _project_name_: Should be in lowercase.

Upon execution, it will guide you through configuring the different sections of the new project.

#### Flags

This command allows using various flags to expedite the process and skip the interactive mode of each provided flag.

- `-h, --help`: Displays a help message.
- `--views [view1, view2...]`: Creates files of type `route` with each of the provided names.
- `--viewsPath [./path/to/routes]` / `--views-path`: Stores the files in the provided path.
- `--viewsLocalBoilerplate [./path/to/localBoilerplate.file]` / `--views-local-boilerplate`: Uses a customized file as _boilerplate_ for others.
- `--dry-mode` / `--dryMode`: Starts the script in read-only mode without saving any changes.
- `--front-end-port [port]` / `--frontEndPort`: Sets `FRONT_END_PORT` in the backend project's `.env`.
- `--back-end-port [port]` / `--backEndPort`: Sets `BACK_END_PORT` in the backend project's `.env`.
- `--debug`: Displays more log messages.

_Example of launch with all possible arguments_

```bash

configureProject my-new-project --views home, about, [userId] --viewsPath ./test/routes --viewsLocalBoilerplate ./styles/base/grid-system.scss --dry-mode --debug

```

#### Script Details

The Script starts by asking what type of architecture to create.

**Frontend project (NextJS)**

1. Project installation with NPX of NextJS, using the following parameters:

   - --ts: Typescript (Deprecated)
   - --eslint: ESLint
   - --src-dir: src/ directory
   - --no-tailwind: Without Tailwind
   - --import-alias '@/*': Default alias
   - --app: App Router

2. Installation of dependencies

   - SASS

3. [Route Generator](#route-generator)

**Backend project (Express)**

1. Initialization with `npm init`.
2. Installation of Express.
3. Creation of `.env` and `.env.example` with `BACK_END_PORT` and `FRONT_END_PORT`.
   - Port resolution priority: flags > interactive mode > automatic assignment.
   - If the project name ends with `_BACKEND`, the corresponding frontend port is looked up in `.route-table`.

In both cases, the common Coding Flavour libraries are installed at the end.

> **Note:** For `.route-table` lookup to work, configure `ROUTE_TABLE_PATH` in your `.bashrc`. See `.bashrc.example` at the root of this repository.

### Next Boilerplate

#### Description

This Bash file creates components with the available types in any architecture (routes, components, hooks, test files...)

#### Basic launch

To use this script, execute the main command of the Bash Script as follows:

```bash

sh createComponent.sh <flags>

```

#### Flags

This command uses flags for the process. **It doesn't have an interactive mode**. Omitting a flag skips the process.

- `-h, --help`: Displays a help message.
- `--routes [view1, view2...]`: Creates files of type `route` with each of the names provided.
- `--routePath [./path/to/routes]`: Stores the files in the provided path.
- `--dryMode`: Starts the script in read-only mode without saving any changes.
- `--debug`: Displays more log messages.

#### Script Details

1. Flag detection and assignments by type
2. Looping through all types and their parameters to generate folders and files

## What does this toolkit offer?

This tool aims to provide developers with:

- A convenient way to generate projects.
- Reuse all necessary components and avoid duplications.
- Follow a base design that will be established in the styles, already accepted and tested by the Design department.
- Follow best practices, as the _boilerplate_ files will always be up-to-date with the file architecture and the main script will always build the healthiest and most scalable architecture.

Below, we detail what you will find in this library.

### Grid System

<h3 style="color: red">@Deprecated</h3>

_File name: grid-system.scss_

This SCSS file controls the position of content in the HTML.

To maintain design consistency, this file generates several columns where content can be placed. It comes with default media breakpoints applying margins to position content as desired.

We typically work with a Grid system (consult the design team), so no further explanation is provided here.

_Usage_:

Add the CSS class to the desired element using the following syntax:

column\_\<column-number>\_

```ts

<div class="column_1">

<span class="column_7">

<header class="column_12">

```

Example:

```ts

[...]

  return (

    <header

      className={`${headerLayout} ${open ? menuOpen : ""}`}

      data-testid={"header"}

    >

      <div className={`column_1 ${headerWrapper}`}>

[...]



```

_Modification_

If modification is needed, several variables are exposed to control everything in both mobile and desktop versions:

- _Margin_: Outer margin of the component. Applied to the left and right of all content.

- _WidthColumn_: Column width. Mainly affects the positioning of other columns in the Grid.

- _MarginColumn_: Same as column width, but affecting content position.

### Route Generator

Enables the creation of all application routes. The basic usage of this script will enter interactive mode. In this mode, the user will be asked about different needs to create views.

Requirements:

- Route names: Used to generate different folders for the routes. The result will be `<name>/page.ts`.

Note: When entering names, use commas and spaces.

_Correct_

`> home, contact, [articleId]`

_Incorrect_

`> home,contact,[articleId]`

- Path to store new routes: Where we want to create folders for the routes. By default, it will use the path considered by the current architecture of Coding Flavour.

`> ./path/save`

- Boilerplate file: File from which we want to propagate all the new files. By default, a page considered by the current architecture of Coding Flavour will be used as boilerplate.

`> ~/path/file/boilerplate.file`

All these needs can be provided without using interactive mode by using several flags. Review [Generate project - Flags](<#Generate\ Project#flags>).

<h3 style="color: red">@Deprecated</h3>

3. Movement of library files:

- Creation of the 'src/styles/' folder
- Moving the \*grid-system.scss file

## Credits

Created by Daniel Sánchez Betancor for the Coding Flavour team
