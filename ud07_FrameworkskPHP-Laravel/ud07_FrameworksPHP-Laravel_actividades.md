---
   unit: unidad didáctica 7
   title: actividades
   language: ES
   author: Arturo Blasco
   subject: Desarrollo Web en Entorno Servidor
   keywords: [DWES, 2023, PHP, Laravel]
   IES: IES Mestre Ramón Esteve (Catadau) [iesmre.es]
   header: ${unit}: ${title} - ${subject} (versión: ${today})
   footer: ${currentFileName}.pdf - ${author} - ${IES} - ${pageNo}|${pageCount}
   typora-root-url:${filename}/../
   typora-copy-images-to:${filename}/../assets
---





[TOC]

# MySQLi

**Actividad 601**

Crea una nueva base de datos con el nombre `lol` y cotejamiento de datos `utf8mb4_unicode_ci`.



**Actividad 602**

En nuestra base de datos `lol` que acabamos de crear, vamos a crear la tabla `campeon` con los siguientes campos (no olvides poner el tipo de datos de cada uno de los campos).

- id [*]
- nombre
- rol
- dificultad
- descripcion

[*] clave primaria.



**Actividad 603**

Rellena la tabla `campeon` con, al menos 5 registros, con los datos que tú quieras o si lo prefieres, puedes basarte en la [página oficial del juego](https://www.leagueoflegends.com/es-es/champions) pero **¡¡ NO TE PONGAS A JUGAR !!**



**Actividad 604**

Crea `604campeones.php` y lista todos los campeones del LOL que has metido en tu base de datos (1º conexión a BD y 2º `foreach` para cada campeón que tengas en la tabla `campeon`).



**Actividad 605**

Modifica el archivo `604campeones.php` y guárdalo como `606campeones.php` pero pon al lado de cada uno de los campeones listados un botón para `editar` y otro para `borrar`. Cada uno de esos botones hará la correspondiente función dependiendo del id del campeón seleccionado.

- Al pinchar en editar, el usuario será redirigido al archivo `605editando.php` donde mostrará un formulario con los campos rellenos por los datos del campeón seleccionado. Al darle al botón de `guardar` los datos se guardarán en la base de datos y el usuario será redirigido a la lista de campones para poder ver los cambios.
- Al pinchar en borrar, el usuario será preguntado a través de un mensaje de JavaScript (prompt) si está seguro de que quiere borrar al campeón seleccionado. En el mensaje de confirmación debe aparecer el **nombre del campeón seleccionado**. Si el usuario pincha en Aceptar el campeón será eliminado de la base de datos y el usuario será redirigido nuevamente al listado de campeones para comprobar que, efectivamente dicho campeón se ha eliminado de la lista.

# filtros y comodines

**Actividad 606**

Modifica el archivo `604campeones.php` y guárdalo como `606campeones.php` para que se muestre como una tabla con las columnas de la propia tabla de la base de datos, es decir; id, nombre, rol, dificultad, descripción. Al lado de cada nombre de cada columna, pon 2 iconos que sean ˄ ˅ y que cada uno de ellos ordene el listado en función de cuál se haya pinchado.

- Si se ha pulsado en Nombre el icono de ˄, el listado debe aparecer ordenado por nombre ascendente. Si por el contrario se ha pulsado ˅ tendrá que ordenarse por nombre descendente.
- Ten en cuenta que cada icono debe llevar consigo un enlace al listado que contenga parámetros en la URL que satisfagan las opciones seleccionadas así que haced uso de $_GET para poder capturarlos y escribid las consultas SQL que sean necesarias para hacer cada uno de los filtros.
- Puedes usar [Font Awesome](https://fontawesome.com/) para los iconos pero es algo opcional.
