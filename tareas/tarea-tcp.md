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

### 2. Captura de tráfico

Es necesario realizar una captura del tráfico de red que se genera para la comunicación entre el cliente y el servidor, para esto se puede utilizar cualquiera de las siguientes herramientas:

#### A. Utilizando `tcpdump`

Abrir una nueva ventana de terminal y hacer una captura de tráfico con `tcpdump` especificando que se guarde en el archivo `www_unam_mx.pcap`

```
# tcpdump -n -w www_unam_mx.pcap 'host www.unam.mx'
```

Dejar abierta esta ventana y esperar a completar el siguiente paso

> Ajustar el filtro para que capture únicamente los paquetes del equipo al que se haga la petición HTTP

#### B. Utilizando `wireshark`

##### Configuración para `wireshark`

Configurar el paquete `wireshark-common` y contestar `<Yes>` a la pregunta del cuadro de diálogo:

```
# dpkg-reconfigure -p low wireshark-common

	┌─────────────────────┤ Configuring wireshark-common ├──────────────────────┐
	│                                                                           │
	│ Dumpcap can be installed in a way that allows members of the "wireshark"  │
	│ system group to capture packets. This is recommended over the             │
	│ alternative of running Wireshark/Tshark directly as root, because less    │
	│ of the code will run with elevated privileges.                            │
	│                                                                           │
	│ For more detailed information please see                                  │
	│ /usr/share/doc/wireshark-common/README.Debian.                            │
	│                                                                           │
	│ Enabling this feature may be a security risk, so it is disabled by        │
	│ default. If in doubt, it is suggested to leave it disabled.               │
	│                                                                           │
	│ Should non-superusers be able to capture packets?                         │
	│                                                                           │
	│                    <Yes>                       <No>                       │
	│                                                                           │
	└───────────────────────────────────────────────────────────────────────────┘
```

Revisar que exista el grupo `wireshark` y agregar al usuario normal a este grupo para que pueda capturar paquetes:

```
# getent group wireshark
wireshark:x:123:

# adduser tonejito wireshark
Adding user `tonejito' to group `wireshark' ...
Adding user tonejito to group wireshark
Done.

# id tonejito
uid=1000(tonejito) gid=100(users) groups=100(users), ... ,123(wireshark)
```

Después de agregar el usuario al grupo, cerrar la sesión y volverla abrir o bien, reiniciar el equipo.

##### Captura de tráfico

Abrir `wireshark` en una terminal:

```
$ wireshark &
```

En el panel **izquierdo** seleccionar la interfaz para realizar la captura.

> **Protip**: Si no se sabe en que interfaz se debe capturar, seleccionar `any` y explicar por que se utilizó así.

Dar clic en el botón **Capture options** para introducir el filtro de captura (_capture filter_)

+ `host www.unam.mx`

> Ajustar el filtro para que capture únicamente los paquetes del equipo al que se haga la petición HTTP

Dar clic en el botón **Start** para comenzar la captura.

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

#### A. Utilizando `tcpdump`

Al finalizar la petición HTTP con `curl` realizada en el paso anterior, cambiar a la terminal donde se ejecutó `tcpdump`

Salir de `tcpdump` presionando `^C` (Control + C)

```
# tcpdump -n -w www_unam_mx.pcap 'host www.unam.mx'
^C
11 packets captured
11 packets received by filter
0 packets dropped by kernel
```


#### B. Utilizando `wireshark`

Detener la captura de tráfico:

+ Presionar el botón **Stop** en la barra de herramientas
+ Seleccionar el menú **Capture** y dar clic en la opción **Stop**
+ Presionar `^E` (Control + E)

Guardar la captura de tráfico en formato `pcap`:

+ Seleccionar el menú **File** y dar clic en la opción **Save**
+ Presionar `^S` (Control + S)

En el cuadro de diálogo seleccionar la ubicación y guardar como `www_unam_mx.pcap`

+ Seleccionar el formato `Wireshark/tcpdump/... - pcap`
+ Dar clic en **Save**

#### Guardar la versión en texto de la captura `pcap`

Guardar la versión en texto de la captura realizada en el archivo `www_unam_mx.pcap.txt`

```
# tcpdump -#envr www_unam_mx.pcap 2>&1 | tee www_unam_mx.pcap.txt
    1  06:38:54.967619 08:00:27:8d:c0:4d > 52:54:00:12:35:02, ethertype IPv4 (0x0800), length 74: (tos 0x0, ttl 64, id 16216, offset 0, flags [DF], proto TCP (6), length 60)
    10.0.2.15.48981 > 132.247.70.37.80: Flags [S], cksum 0xd759 (incorrect -> 0xfb83), seq 48628646, win 29200, options [mss 1460,sackOK,TS val 1195262 ecr 0,nop,wscale 6], length 0

	...

```

#### Diagrama de la captura realizada

Realizar un diagrama [en ASCII][captura-ditaa] o en formato de [imagen][captura-png] donde se pueda visualizar lo siguiente:

+ Dirección del paquete (del cliente al servidor o viceversa)
+ Banderas de TCP
+ Número de secuencia y número de ACK
+ Tamaño de la ventana
+ Longitud de los datos enviados
+ Si el paquete contiene datos de TCP, incluir la primer línea de la petición o respuesta

Ver la [sección de TCP][seccion-tcp] o tomar los archivos mencionados arriba como ejemplo

[seccion-tcp]: /tcp.md
[captura-ditaa]: /files/captura.ditaa "Captura de tráfico en formato ditaa"
[captura-png]:   /files/captura.png   "Captura de tráfico en formato png"

### 5. Documentar los pasos realizados y subir al repositorio

Documentar los pasos realizados, así como los problemas encontrados y como se solucionaron en el archivo `tarea-tcp.md`

> Si utilizaste `wireshark` para hacer la captura, debes subir las pantallas que muestren el procedimiento que seguiste


#### Enviar al repositorio

Agregar los archivos generados en la carpeta `tareas` dentro del repositorio:

+ `tarea-tcp.md`
+ `www_unam_mx.http.html`
+ `www_unam_mx.http.log`
+ `www_unam_mx.pcap`
+ `www_unam_mx.pcap.txt`

Hacer _push_ al repositorio remoto en `gitlab.com`

Generar _issue_ para avisar que ya se terminó la tarea

## Referencias

[ListaRedes-2018-2]: http://tinyurl.com/ListaRedes-2018-2 "Lista Redes Semestre 2018-2"
+ <https://wiki.wireshark.org/SampleCaptures>
+ <https://wiki.wireshark.org/TcpDump>
+ <https://wiki.wireshark.org/CaptureSetup/>
+ <https://wiki.wireshark.org/CaptureSetup/Ethernet>
+ <https://wiki.wireshark.org/CaptureSetup/CapturePrivileges>
+ <https://wiki.wireshark.org/CaptureSetup/CaptureSupport>
