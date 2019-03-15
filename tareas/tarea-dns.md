#	Tarea DNS y WHOIS

##	Instrucciones

Esta tarea debe ser entregada de manera **personal**

###	0. Crear la carpeta `tareas/tarea01`

Crear una carpeta llamada `tareas` y otra llamada `tareas/tarea01` en el repositorio **personal** de GitLab y agregarla al control de versiones:

###	1. Elegir el nombre de dominio

Elegir el nombre de dominio y anotarlo en la [lista del grupo][ListaRedes-2019-2], además anotar el nombre de dominio seleccionado en el archivo `dominio.txt`

  + El nombre DNS elegido debe ser **único** para cada persona
  + Revisar la [lista del grupo][ListaRedes-2019-2] y ponerse de acuerdo en caso de haber duplicidad de nombres
  + Únicamente se debe elegir un nombre de dominio como `example.com` y no se permite elegir subdominios (ej. `www.example.com`)
  + El dominio debe ser _completamente_ diferente, no se permite elegir `example.com` y que otra persona elija `example.com.mx`
  + No se permite elegir el _dominio_ `unam.mx` ni un _subdominio_ de el (ej. `fciencias.unam.mx`)

```
$ echo "unam.mx" > dominio.txt
$ cat dominio.txt
unam.mx
$ git add dominio.txt
$ git commit -m 'Dominio DNS seleccionado'
```

###	2. Consulta `whois`

Realizar en la terminal una consulta `whois` para el dominio seleccionado y guardar la salida en el archivo `whois.log`

```
$ whois unam.mx | tee whois.log
$ git add whois.log
$ git commit -m 'Consulta WHOIS'
```

###	3. Archivo /etc/resolv.conf

Listar el contenido del archivo `/etc/resolv.conf` y hacer una copia en el directorio `tareas`

```
$ cp -v /etc/resolv.conf .
‘/etc/resolv.conf’ -> ‘resolv.conf’
$ git add resolv.conf
$ git commit -m 'Archivo /etc/resolv.conf'
```

###	4. Búsqueda iterativa de DNS

Hacer manualmente una **[búsqueda iterativa de DNS][Busqueda-iterativa-DNS]** para el registro `www` del dominio seleccionado. Guardar la salida de la terminal en el archivo `tareas/dns.log`

```
$ dig +all NS .

	...

$ dig +all NS mx. @a.root-servers.net.

	...

$ dig +all unam.mx. @x.mx-ns.mx.

	...

$ dig +all www.unam.mx. @ns3.unam.mx.

	...

```

```
$ git add dns.log
$ git commit -m 'Búsqueda iterativa de DNS' dns.log
```

###	5. Diagrama de búsqueda iterativa DNS

Elaborar un [diagrama como este][Diagrama-busqueda-iterativa] y explicar lo que sucede desde el paso 2 al 8 utilizando las secciones de las consultas que se hicieron al DNS:

  + `QUESTION SECTION`
  + `ANSWER SECTION`
  + `AUTHORITY SECTION`
  + `ADDITIONAL SECTION`

<img src='https://upload.wikimedia.org/wikipedia/commons/6/68/Iterative.jpg' alt='Diagrama de la búsqueda iterativa de DNS - WikiBooks' />

####	Notas

  + Recuerda que los pasos 1 y 8 son los referentes a la búsqueda recursiva
  + El diagrama debe contener la sección apropiada de pregunta (question) y respuesta (answer)
  + Subir el archivo fuente del diagrama y exportarlo al formato PDF y/o PNG
  + Se sugiere el uso del programa **DIA** disponible en [el sitio web][dia-installer], [en SourceForge][dia-sourceforge] y [en PortableApps][dia-portableapps]

```
$ git add diagrama-dns.dia diagrama-dns.pdf diagrama-dns.png
$ git commit -m 'Diagrama de la búsqueda iterativa de DNS'
```

###	6. Enviar cambios a GitLab

Hacer `git push` para subir todos los cambios realizados al repositorio y hacer _merge request_ para entregar la tarea

--------------------------------------------------------------------------------

[ListaRedes-2019-2]: http://tinyurl.com/ListaRedes-2019-2
[Busqueda-iterativa-DNS]: /dns.md#búsqueda-iterativa "Búsqueda iterativa manual de DNS"
[WikiBooks-DNS]: https://en.wikibooks.org/wiki/Communication_Networks/DNS "Página de DNS en WikiBooks"
[Diagrama-busqueda-iterativa]: https://commons.wikimedia.org/wiki/File:Iterative.jpg "Diagrama de la búsqueda iterativa de DNS - WikiBooks"
[dia-installer]: http://dia-installer.de/ "Sitio web de DIA"
[dia-sourceforge]: https://sourceforge.net/projects/dia-installer/ "Dia en SourceForge"
[dia-portableapps]: https://portableapps.com/apps "DIA en PortableApps"
