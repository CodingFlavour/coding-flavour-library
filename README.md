# Generador de Proyectos de Coding Flavour

## ¿Qué es?

Este proyecto es una conjunción de librerias creadas para cualquier proyecto generado para Coding Flavour, con una serie de componentes, paletas y estilos por defecto, además de un Script que se encargará de la generación del proyecto y de la vinculación de todas las herramientas.

## ¿Cómo se usa?

Para usarlo, lanzaremos el comando principal de Script Bash de la siguiente manera y sintaxis:

```sh
sh configureProject.sh <nombre_del_proyecto>
```

- _nombre_de_proyecto_: Debe estar en minúsculas.

De esta manera, generara dicho proyecto en la ruta donde lances el comando, envuelto en la carpeta principal del proyecto.

## ¿Qué ofrece?

Con esta herramienta, queremos ofrecer a los desarrolladores:

- Una manera cómoda de generar proyectos.
- Reutilizar todos los componentes necesarios y evitar duplicidades.
- Seguir un diseño base que estará establecido en los estilos, el cual ya estará aceptado y probado por el departamento de Diseño.

A continuación, se detallan estos puntos con lo que nos encontraremos en esta librería.

### Grid System

_Nombre de archivo: grid-system.scss_

Este archivo de SCSS controla la posicion del contenido en el HTML.

Para poder mantener una estabilidad en cuanto a diseños, este archivo genera varias columnas donde podremos establecer nuestro contenido, y este se generará con puntos de Media por defecto, donde se aplicarán una serie de márgenes para colocar cualquier contenido donde plazca.

De forma regular, trabajamos con un sistema de Grid (consultar diseño), por lo que no se explicará mas aqui.

_Uso_:

Para usarlo, añadimos la clase CSS al elemento que deseamos, siguiendo la sintaxis: _column\_<numero-de-columna>_.

```ts
<div class="column_1">
<span class="column_7">
<header class="column_12">
```

Ejemplo de uso:

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

_Modificación_

Si en algun caso se necesita modificar, se exponen varias variables que facilitan el control de todo, en sus version mobiles y de escritorio:

- _Margin_: Márgen externo del componente. Se aplica a izquierda y derecha de todo el contenido
- _WidthColumn_: Tamaño de la columna. Afecta sobre todo al posicionamiento del resto de columnas en el Grid.
- _MarginColumn_: De la misma manera que el tamaño de la columna, pero afectando a la posicion del contenido.

### Configure Project

_Nombre de archivo: configureProject.sh_

Este archivo Bash inicializa el proyecto introducido y conecta las librerias en el árbol de directorios del proyecto.

El nombre del proyecto debe ser con letras minúsculas.

_Uso_

```sh
sh configureProject.sh <nombre_del_proyecto>
```

Permite el argumento '-h' para obtener ayuda acerca de su funcionamiento.

_Transpilación de mensaje de ayuda_

```sh
---------------
|     HELP    |
---------------
Creates a project with all the utilities needed for a new Coding Flavour project by the given name.

Usage:
sh ./configureProject.sh [project_name]

[project_name]: Must start with a lowercase letter

Options:

  -h, --help   Show this help message and exit.
```

Este Script ejecutará varias acciones:

1. Instalación de proyecto con NPX de NextJS, con los siguientes parámetros:

- --ts: Typescript
- --eslint: ESLint
- --src-dir: Directorio src/
- --no-tailwind: Sin Tailwind
- --import-alias '@/\*': Alias por defecto
- --app: App Router

2. Instalación de dependencias en el proyecto:

- SASS

3. Movimiento de archivos de librería:

- Creación de carpeta 'src/styles/'
  - Movimiento de \*grid-system.scss'

## Créditos

Creado por Daniel Sanchez Betancor para el equipo Coding Flavour