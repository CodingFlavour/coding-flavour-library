# Registro de cambios

## 🚀 V.1.33

- General
  - Añadidas funciones helper al sistema de log: `erase_prefix()`, `log_debug()`, `log_on_dry()`, `set_debug()`.
- *Configure Project - Backend*
  - Implementada función `modify_env_vars()` para crear archivos de entorno (.env, .env.example, .env.development).
  - Agregadas variables de entorno BACK_END_PORT (4000) y FRONT_END_PORT (3000) con valores por defecto.
  - Dejados comentarios TODO para futuras mejoras: flags de puerto, modo interactivo y sistema .route-table.

## ✨ V.1.32

- General
  - Nuevo archivo `coding-flavour-libraries.sh` para instalar todas las dependencias de Coding Flavour (@coding-flavour/companion, vscode-settings, icons, styles, common).
  - Agregada lógica de capitalización del primer carácter en nombres de archivo generados.
- *Next Boilerplate*
  - Corregida generación de nombre de archivo capitalizando la primera letra en `generator.sh`.
- *Configure Project*
  - Integración del script de instalación de librerías Coding Flavour en el flujo principal.
  - Agregado flag `--yes` al comando `create-next-app` para evitar prompts interactivos.
  - Corrección en `generateViews.sh`: verificación de modo interactivo en `get_path()` y `get_local_boilerplate()`.
- *Documentación*
  - Corregida ruta del alias `configureProject` en README-ES.md y README-EN.md.

## ✨ V.1.31

- General
  - Creación de `common` para mantener la lógica utilizada entre todos los Scripts.
  - Añadido un sistema de nivel al logger, donde el nivel es el número de tabulaciones que se agregarán al mensaje antes de imprimirlo. Si no se proporciona ningún nivel, se toma `0` por defecto.
  - Actualización del `README`.
- *Next Boilerplate*
  - Fusionada esta herramienta con el proyecto para combinar todas las utilidades.
  - Añadida plantilla de página como archivo por defecto para las rutas.
  - Modificado `example` a `templates` y reestructurados los archivos en carpetas con sus tipos correspondientes.
  - Actualización de `--help` para mantenerlo al día.
  - Añadido modo de depuración. Activable utilizando la bandera `--debug`.
  - Añadido `dry mode` para ejecutar el Script en modo de lectura, sin aplicar cambios. Consulta `-h | --help` para obtener más información.
  - Se deprecaron varias funciones que no cumplen con la arquitectura actual de Coding Flavour.
    - Habla con Daniel para obtener más información si quieres resolver este problema.
  - Se añadieron varias banderas para acomodar la creación de los nuevos archivos.
    - `--routes`: Nombre para los archivos del tipo `route`.
    - `--routePath`: Ruta para guardar los archivos mencionados.
      - _Si no se proporciona alguna de estas opciones, el Script omitirá el paso._
    - Cada _tipo_ tiene su propio _boilerplate_ definido.
- *Configure Proyect*
  - Actualización de `--help` para mantenerlo al día.
  - Añadido modo de depuración. Actívalo utilizando la bandera `--debug`.
  - Eliminado la creación de los archivos en este Script. Ahora ejecutará `next-boilerplate`, que está preparado para realizar esta tarea, manteniendo este Script como un orquestador.

## 🚀 V.1.3

- Generador de rutas: Genera rutas para los proyectos, hay 2 formas:
	- Modo interactivo: El Script pedirá varias cosas:
		- Nombres de las rutas: Cadena con todas las rutas que se deben crear, separadas por comas. Ejemplo: `> inicio, sobre, [idArtículo]`
		- Ruta: Si deseas anular la ruta predeterminada para guardar las páginas. Ejemplo: `> ./src/presentación/rutas`
		- Plantilla: Si quieres proporcionar tu propio archivo de plantilla. Ejemplo: `> ~/proyectos/proyecto-personal/src/páginas/index.ts`
	- Modo no interactivo: Los valores mencionados anteriormente se pueden anular con varias banderas. Consulta `-h | --help` para obtener más información.
- Se deprecaron varias funciones que no cumplen con la arquitectura actual de Coding Flavour.
- `configureProject.move_styles` => Necesita actualización con todos los archivos nuevos.
- `configureProject.create_root_dir_front` => Necesita actualizarse después de la función anterior.
- Añadido `dry mode` para ejecutar el Script en modo de lectura, sin aplicar cambios. Consulta `-h | --help` para obtener más información.
- Analizador de banderas aislado (nuevo) y registrador en la carpeta `help`.
- Actualizado `--help` con las nuevas banderas.
