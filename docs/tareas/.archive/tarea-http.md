---
# https://www.mkdocs.org/user-guide/writing-your-docs/#meta-data
title: Tarea HTTP
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Tarea HTTP

## Instrucciones

Esta tarea debe ser entregada de manera **personal**

### 0. Localizar Crear la carpeta `tareas`

Localizar el dominio DNS _utilizado en la tarea anterior_

  + Ver el archivo `tareas/dominio.txt`
  + Utilizar la [lista del grupo][ListaRedes]

### 1. Anotar la direccion IP a la que resuelve el nombre DNS

+ Ubicar la consulta DNS _realizada en la tarea anterior_ dentro del archivo `tareas/dns.log`

+ Guardar la dirección IPv4 en el archivo `tareas/ip.txt`

```
$ cd /ruta/hacia/repositorio/local
$ mkdir -vp tareas
mkdir: created directory ‘tareas’
$ touch tareas/.keep
$ ls -lA tareas/
total 0
-rw-r--r-- 1 tonejito users 0 Mar  1 18:00 .keep
$ cd tareas/
$ git add .keep
$ git commit -m 'Agregando carpeta de tareas' .keep
$ git pull
$ git push
```

### 2. Hacer una petición al servidor

Utilizar el programa con `curl` para hacer una petición al servidor:

+ Guardar las cabeceras de la petición y la respuesta en el archivo `.log`
+ Guardar las _cookies_ que regresa en el archivo `cookies.txt`
+ Guardar el código HTML de la página solicitada en el archivo `.html`

```
$ curl -v#L --cookie-jar cookies.txt -o www_unam_mx.html 'http://www.unam.mx/' 2>&1 | tee www_unam_mx.log
```

Agregar los archivos al repositorio:

```
$ git add  cookies.txt www_unam_mx.log www_unam_mx.html
$ git commit -m 'Peticion al servidor web y respuesta' cookies.txt www_unam_mx.log www_unam_mx.html
```

### 3. Crear una captura de pantalla de la página web

Guardar una imagen de la página que devuelve el servidor utilizando el programa `wkhtmltoimage`:

+ Instalar el programa `wkhtmltoimage` con privilegios de _`root`_

  * En Debian o Ubuntu: `# aptitude install wkhtmltopdf`
  * En CentOS o Red Hat: `# yum install wkhtmltopdf`
  * En Mac OS X con MacPorts: `# port install wkhtmltopdf`

```
$ which wkhtmltoimage
/usr/bin/wkhtmltoimage
```

+ Es importante pasar las _cookies_ para que el servidor reconozca que estamos en la misma sesión

  * Opcional: Crear el directorio `/tmp/cache` y especificar la opción `--cache-dir` para guardar un caché intermedio de los recursos que descarga el programa

```
$ mkdir -vp /tmp/cache
$ wkhtmltoimage --format png --images --cookie-jar cookies.txt 'http://www.unam.mx/' www_unam_mx.png
```

Agregar los archivos al repositorio:

```
$ git add  cookies.txt www_unam_mx.png
$ git commit -m 'Captura de pantalla de la página solicitada' cookies.txt www_unam_mx.png
```

### 4. Abrir una página en un navegador y _reutilizar_ las `cookies`

Abrir un navegador web e iniciar sesión en algún sitio utilizando el nombre de usuario y contraseña

Abrir el inspector para visualizar las peticiones de red que hace el navegador

  + Abrir el inspector de red en [Mozilla Firefox][Inspector-Red-Firefox]
  + Abrir el inspector de red en [Google Chrome][Inspector-Red-Chrome]

Localizar al principio de la lista la petición de alguna página utilizando el método `GET` y seleccionarla, dar _clic derecho_ y seleccionar la opción _copiar como cURL_

Organizar la línea de comandos de `curl` y tomar especial atención en las _cookies_, un comando parecido al siguiente debería guardarlas en el archivo `cookies-externas.txt`

Realizar las siguientes modificaciones a la línea de comandos de `curl`:

  + Quitar la opción `--compressed` de la línea de comandos
  + Cambiar la cabecera `Accept` por `Accept: text/html`

```
$ curl -v#L --cookie-jar cookies-externas.txt -o www_unam_mx+cookies.html \
  'https://www.unam.mx/' \
  -H 'Host: www.unam.mx' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0' \
  -H 'Accept: text/html' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'Cookie: _ga=GA1.0.123456789.0123456789' \
  -H 'Cookie: __utma=123456789.123456789.0123456789.0123456789.0123456789.0; __utmz=123456789.0123456789.0.1.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided)' \
2>&1 | tee www_unam_mx+cookies.log
```

### 5. Comparar archivos de salida y obtener conclusiones

Comparar el código HTML inicial del archivo `www_unam_mx.html` con el nuevo archivo `www_unam_mx+cookies.html` obtenido en el paso anterior

Ver el código fuente del archivo HTML generado con `curl` en el paso anterior (`www_unam_mx+cookies.html`) y compararlo con el código fuente de la página visitada en el navegador

Después de comparar los archivos, responder a las siguientes preguntas:

  + ¿Existen diferencias entre los archivos?, ¿Cuáles?
  + ¿Cambia la respuesta del servidor cuando se pasa la _cookie_ en la petición?
  + ¿Por qué se envian las _cookies_ en la petición al servidor?
  + ¿Por qué se quitó la opción `--compressed` en la línea de comandos de `curl`?
  + ¿Por qué se alteró el valor de la cabecera `Accept` que se mandó en la petición?

[ListaRedes]: http://tinyurl.com/ListaRedes-2019-2 "Lista Redes Semestre 2019-2"
[Inspector-Red-Firefox]: https://developer.mozilla.org/en-US/docs/Tools/Network_Monitor "Abrir el inspector de red en Mozilla Firefox"
[Inspector-Red-Chrome]: https://developer.chrome.com/devtools#improving-network-performance "Abrir el inspector de red en Google Chrome"
