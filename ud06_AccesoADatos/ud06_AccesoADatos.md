---
   unit: unidad didáctica 6
   title: Acceso a datos
   language: ES
   author: Arturo Blasco
   subject: Desarrollo Web en Entorno Servidor
   keywords: [DWES, 2023, PHP]
   IES: IES Mestre Ramón Esteve (Catadau) [iesmre.es]
   header: ${unit}: ${title} - ${subject} (versión: ${today})
   footer: ${currentFileName}.pdf - ${author} - ${IES} - ${pageNo}|${pageCount}
   typora-root-url:${filename}/../
   typora-copy-images-to:${filename}/../assets

---







[TOC]

# duración y criterios de evaluación

En esta unidad vamos a aprender a acceder a datos que se encuentran en un servidor; recuperando, editando y creando dichos datos a través de una base de datos.

A través de las distintas capas o niveles, de las cuales 2 de ellas ya conocemos (*Apache*, *PHP*) y *MySQL* la que vamos a estudiar en este tema.

**Duración estimada**: - sesiones

------

**Resultado de aprendizaje y criterios de evaluación**:

x. ---

# instalación

A través de **XAMPP** es muy sencillo, simplemente nos descargaríamos el programa y lo activaríamos. Para descargar XAMPP [pulsa aquí](https://www.apachefriends.org/es/download.html).

Con **Docker** nos descargaremos [esta imagen de docker](http://localhost:51236/UD06_ES/resources/plantilla-APCM.zip) y lanzamos

```bash
docker-compose up -d
```

Si todo ha salido bien y el contenedor está en marcha, podremos visitar la página de phpMyAdmin de la siguiente manera

```bash
http://localhost:8000
```

<img src="/assets/img01_06-bbdd-phpMyAdmin-login.png" style="zoom:40%;" />

Para acceder debemos utilizar las siguientes credenciales que vienen configuradas en el alrchivo docker-compose.yml

```sh
usuario: root
contraseña: 1234
```

# estructura de una base de datos

Sabemos que una base de datos tiene muchos campos con sus nombres y valores, pero además sabemos que la base de datos debe tener un nombre. por tanto tendríamos la siguiente estructura para una base de datos:

```bash
NombreBaseDeDatos
    |__Tabla-#1
    |         |__DatosTabla-#1
    |
    |__Tabla-#2
    |         |__DatosTabla-#2
    |    
    |__Tabla-#3
    |         |__DatosTabla-#3
    [...]
```

Veámoslo en un ejemplo real:

```bash
Ryanair
    |__pasajero
    |     |__id[*]
    |     |__nombre
    |     |__apellidos
    |     |__edad
    |     |__id_vuelo[^]
    |
    |__vuelo
    |     |__id[*]
    |     |__n_plazas
    |     |__disponible
    |     |__id_pais[^]
    |
    |__pais
          |__id[*]
          |__nombre
```

[*] *Clave primaria*     [^] *Clave Foránea*

<img src="/assets/img02_06-bbdd-estructura.png" style="zoom: 50%;" />



# CholloSevero

Como muy bien habéis elegido, a lo largo de esta unidad vamos a trabajar con una base de datos que iremos confeccionando conforme avancemos, donde almacenaremos la información relacionada con ofertas que publiquen los usuarios y los listaremos en función de varios filtros; nuevos, más votados, más vistos, más comentados entre otros, al más puro estilo [Chollometro](https://www.chollometro.com/).



![](/assets/img03_06-chollometro.gif)

# SQL

Este lenguaje de consulta estructurada (Structured Query Language) es el que vamos a utilizar para realizar las consultas a nuestras bases de datos para mostrar el contenido en las distintas interfaces web que creemos a lo largo de la unidad. Si quieres saber más detalles visita [Wiki SQL](https://es.wikipedia.org/wiki/SQL).

Ejemplo de una sentencia SQL donde seleccionamos todas las filas y columnas de nuestra tabla llamada '**pais**'

```sql
SELECT * FROM pais
```

Estas sentencias pueden invocarse desde la consola de comandos mediante el intérprete *mysql* (previamente instalado en el sistema) o a través de la herramienta phpMyAdmin.

Las sentencias SQL también las podemos usar dentro de nuestro código php, de tal manera que cuando se cargue nuestra interfaz web, lance una sentecia SQL para mostrar los datos que queramos.

```php
<?php
	// Listado de clientes, ordenados por DNI de manera ASCendente
	$clientesOrdenadosPorDNI = "SELECT * FROM `pasajero` ORDER BY `dni`" ASC;
?>
```

# phpMyAdmin

Este software funciona bajo Apache y PHP y es más que nada una interfaz web para gestionar las bases de datos que tengamos disponibles en nuestro servidor local. Muchos *hostings* ofrecen esta herramienta por defecto para poder gestionar las BBDD que tengamos configuradas bajo nuestra cuenta.

<img src="/assets/img04_06-bbdd-phpMyAdmin-logo.png" style="zoom:25%;" />

## Creando una base de datos dentro de phpMyAdmin

1. Para crear una nueva base de datos debemos entrar en phpMyAdmin como **usuario root** y pinchar en la opción ***Nueva*** del menú de la izquierda.

2. En la nueva ventana de creación pondremos un **nombre** a nuestra bbdd.

3. También estableceremos el **cotejamiento** utf8m4_unicode_ci\ para que nuestra bbdd soporte todo tipo de caracteres (como los asiáticos) e incluso emojis ;)

4. Le damos al botón de **Crear** para crear la bbdd y empezar a escribir las distintas tablas que vayamos a introducir en ella.

<img src="/assets/img05_06-bbdd-phpMyAdmin.gif" style="zoom:35%;" />

El sistema generará el código SQL para crear todo lo que le hemos puesto y creará la base de datos con las tablas que le hayamos metido.

```sql
CREATE TABLE `persona`. ( `id` INT NOT NULL AUTO_INCREMENT , `nombre` TINYTEXT NOT NULL , `apellidos` TEXT NOT NULL , `telefono` TINYTEXT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
```

## opciones en phpMyAdmin

Cuando seleccionamos una base de datos de la lista, el sistema nos muestra varias pestañas con las cuales interactuar con la base de datos en cuestión:

- `Estructura` : Podemos ver las distintas tablas que consolidan nuestra base de datos.
- `SQL` : Por si queremos inyectar código SQL para que el sistema lo interprete.
- `Buscar` : Sirve para buscar por términos, en nuestra base de datos, aplicando distintos filtros de búsqueda.
- `Generar consulta` : parecido a SQL pero de una manera más gráfica, sin tener que saber nada del lenguaje.
- `Exportar` e `importar` : Como su nombre indica, para hacer cualquiera de las 2 operaciones sobre la base de datos.
- `Operaciones` : Distintas opciones avanzadas para realizar en nuestra base de datos, de la cual destacaremos la opción **Cotejamiento** donde podremos cambiar el cotejamiento de nuestra tabla pero **OJO CON ÉSTO porque podemos eliminar datos sin querer, ya que al cambiar el cotejamiento podemos suprimir caracteres no soportados por el nuevo cotejamiento**.

No vamos a profundizar en el resto de opciones pero, en la pestaña **Más** existe la opción **Diseñador** para poder editar las relaciones entre tablas de una manera gráfica (pinchando y arrastrando) que veremos más adelante.

# MySQLi

PHP hace uso de esta extensión mejorada para poder comunicarse con las bases de datos, ya sean MySQL (4.1 o superior) o MariaDB.

Cualquier consulta que queramos hacer a una base de datos necesitaremos hacer uso de la extensión mysqli().

Veamos como conectarnos con una base de datos a través del código PHP:

```php
<?php
    // ▒▒▒▒▒▒▒▒ pruebas.php ▒▒▒▒▒▒▒▒

    // "SERVIDOR", "USUARIO", "CONTRASEÑA", "BASE DE DATOS"
    $conexion = mysqli_connect("d939ebf6a741","tuUsuario","1234","pruebas");

    // COMPROBAMOS LA CONEXIÓN
    if(mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
    exit();
    }

    echo "<h1>Bienvenid@ a MySQL !!</h1>";
?>
```

- `servidor`: El servidor donde se encuentra la base de datos que queremos usar suele ser **localhost**, pero en nuestro caso, al utilizar Docker será el nombre de la imagen **mysql:8.0** que aparece al dejar el ratón encima en el Visual Studio Code.

<img src="/assets/img06_06-mysql-servidor-docker.gif" style="zoom:50%;" />

- `usuarioDB`: El usuario de la base de datos.
- `passwordDB`: La contraseña para ese usuario de la base de datos.
- `baseDeDatos`: Nombre de la base de datos que queramos usar.

Si todo ha salido bien habréis visto un mensaje diciendo **Bienvenid@ a MySQL !!**

## recuperando datos de una BD

Ahora que ya sabemos cómo conectarnos a una base de datos alojada en nuestro servidor, lo que necesitamos saber es cómo recuperar datos almacenados en la base de datos.

Durante la instalación de la imagen de Docker, se ha creado una tabla llamada **Pruebas** que contiene varios registros de distintas personas.

Vamos a recuperar esos datos para ver de qué forma se hace con PHP.

```php
<?php
   // ▒▒▒▒▒▒▒▒ pruebas.php ▒▒▒▒▒▒▒▒

   $conexion = mysqli_connect("d939ebf6a741", "lupa", "1234", "pruebas");

   // COMPROBAMOS LA CONEXIÓN
   if (mysqli_connect_errno()) {
       echo "Failed to connect to MySQL: " . mysqli_connect_error();
       exit();
   }

   // CONSULTA A LA BASE DE DATOS
   $consulta = "SELECT * FROM `Person`";
   $listaUsuarios = mysqli_query($conexion, $consulta);

   // COMPROBAMOS SI EL SERVIDOR NOS HA DEVUELTO RESULTADOS
   if($listaUsuarios) {

     // RECORREMOS CADA RESULTADO QUE NOS DEVUELVE EL SERVIDOR
     foreach ($listaUsuarios as $usuario) {
        echo "
              $usuario[id]
              $usuario[name]
               <br>
             ";
        }
     }
?>
```

Si todo ha salido bien, por pantalla verás el siguiente listado

```processing
▒▒▒▒▒▒▒▒ http://localhost/pruebas.php ▒▒▒▒▒▒▒▒

1 William
2 Marc
3 John
4 Antonio Moreno
```

# PHP Data Objects :: PDO

De la misma manera que hemos visto con mysqli, PHP Data Objects (o PDO) es un driver de PHP que se utiliza para trabajar bajo una interfaz de objetos con la base de datos. A día de hoy es lo que más se utiliza para manejar información desde una base de datos, ya sea relacional o no relacional.

De igual manera que pasaba con los objetos en PHP nativos, en la interfaz de MySQL la cosa cambia la hora de conectarnos con una base de datos.

```php
<?php
   $conexion = new PDO('mysql:host=localhost; dbname=dwes', 'dwes', 'abc123');
```

Además, con PDO podemos usar las excepciones con try catch para gestionar los errores que se produzcan en nuestra aplicación, para ello, como hacíamos antes, debemos encapsular el código entre bloques try / catch.

```php
<?php
   $dsn = 'mysql:dbname=prueba;host=127.0.0.1';
   $usuario = 'usuario';
   $contraseña = 'contraseña';

   try {
        $mbd = new PDO($dsn, $usuario, $contraseña);
        $mbd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
   } catch (PDOException $e) {
        echo 'Falló la conexión: ' . $e->getMessage();
   }
```

En primer lugar, creamos la conexión con la base de datos a través del constructor PDO pasándole la información de la base de datos. 

En segundo lugar, establecemos los parámetros para manejar las excepciones, en este caso hemos utilizado:

- `PDO::ATTR_ERRMODE` indicándole a PHP que queremos un reporte de errores.
- `PDO::ERRMODE_EXCEPTION` con este atributo obligamos a que lance excepciones, además de ser la opción más humana y legible que hay a la hora de controlar errores.

Cualquier error que se lance a través de PDO, el sistema lanzará una **PDOException**.



# referencias

- [Tutorial de Composer](https://desarrolloweb.com/manuales/tutorial-composer.html)
- [Web Scraping with PHP – How to Crawl Web Pages Using Open Source Tools](https://www.freecodecamp.org/news/web-scraping-with-php-crawl-web-pages/)
- [PHP Monolog](https://zetcode.com/php/monolog/)
- [Unit Testing con PHPUnit — Parte 1,](https://medium.com/@emilianozublena/unit-testing-con-phpunit-parte-1-148c6d73e822) de Emiliano Zublena.