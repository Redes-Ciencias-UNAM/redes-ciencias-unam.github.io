# Tarea TCP

## Instrucciones

+ Esta tarea debe ser entregada de manera **personal**
+ Se utilizará el mismo nombre de dominio que se anotó en la [lista del grupo][ListaRedes-2018-2]

### 1. Verificar que el dominio tenga el servicio de HTTP

Revisar que el nombre `www` para el dominio seleccionado responda al protocolo HTTP por el puerto `80/tcp`:

```
$ cat dominio.txt
unam.mx

$ dig +short www.unam.mx | tee ip.txt
132.247.70.37

$ nc -vz www.unam.mx 80
www.unam.mx [132.247.70.37] 80 (http) open
```

### 2. Captura de tráfico con `tcpdump`

Abrir una nueva ventana de terminal y hacer una captura de tráfico con `tcpdump` especificando que se guarde en el archivo `www_unam_mx.pcap`

```
# tcpdump -n -w www_unam_mx.pcap 'host www.unam.mx'
```

Dejar abierta esta ventana y esperar a completar el siguiente paso

> Ajustar el filtro para que capture únicamente los paquetes del equipo al que se haga la petición HTTP

### 3. Petición HTTP

Realizar una petición HTTP utilizando `curl`, donde:

+ La opción `-o` guarda la salida en el archivo `www_unam_mx.http.html`
+ `tr -d` borra todas las ocurrencias del caracter `\r` (CR)
+ `tee` imprime la salida y al mismo tiempo la guarda en el archivo `www_unam_mx.http.log`

```
$ curl -v# 'http://www.unam.mx/' -o www_unam_mx.http.html 2>&1 | tr -d '\r' | tee www_unam_mx.http.log
* Hostname was NOT found in DNS cache
*   Trying 132.247.70.37...
* Connected to www.unam.mx (132.247.70.37) port 80 (#0)
> GET / HTTP/1.1
> User-Agent: curl/7.38.0
> Host: www.unam.mx
> Accept: */*
> 
< HTTP/1.1 301 Moved Permanently
< Date: Fri, 13 Apr 2018 06:32:18 GMT
* Server Apache is not blacklisted
< Server: Apache
< Location: https://www.unam.mx/
< Cache-Control: max-age=1209600
< Expires: Fri, 27 Apr 2018 06:32:18 GMT
< Content-Length: 228
< Content-Type: text/html; charset=iso-8859-1
< 
{ [data not shown]
########################## 100.0%* Connection #0 to host www.unam.mx left intact

```

### 4. Cerrar la captura de tráfico y visualizar el resultado

Al finalizar la petición HTTP con `curl` realizada en el paso anterior, cambiar a la terminal donde se ejecutó `tcpdump`

Salir de `tcpdump` presionando `^C` (Control+C)

Guardar la versión en texto de la captura realizada en el archivo `www_unam_mx.pcap.txt`

```
# tcpdump -#envr www_unam_mx.pcap 2>&1 | tee www_unam_mx.pcap.txt
```

### 5. Documentar los pasos realizados y subir al repositorio

Documentar los pasos realizados, así como los problemas encontrados y como se solucionaron en el archivo `tarea-tcp.md`

Agregar los archivos generados en la carpeta `tareas` dentro del repositorio:

+ `tarea-tcp.md`
+ `www_unam_mx.http.html`
+ `www_unam_mx.http.log`
+ `www_unam_mx.pcap`
+ `www_unam_mx.pcap.txt`

Hacer _push_ al repositorio remoto en `gitlab.com`

Generar _issue_ para avisar que ya se terminó la tarea

[ListaRedes-2018-2]: http://tinyurl.com/ListaRedes-2018-2 "Lista Redes Semestre 2018-2"
