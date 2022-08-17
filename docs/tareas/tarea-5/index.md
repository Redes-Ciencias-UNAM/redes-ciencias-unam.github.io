---
# https://www.mkdocs.org/user-guide/writing-your-docs/#meta-data
title: Tarea 3 - Captura de tráfico de red en WireShark
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Tarea 3: Captura de tráfico de red con WireShark

--------------------------------------------------------------------------------

## Objetivo

- El alumno realizará algunas capturas de tráfico de red donde identificará los protocolos asociados a cada capa del modelo OSI.

## Elementos de apoyo

Te invitamos a leer la documentación:

- [Página de manual de `dig`][dig-man]
- [Página de manual de `nslookup`][nslookup-man]
- [Página de manual de `tcpdump`][tcpdump-man]
- [Página de manual de `windump`][windump-man]
- [Manual de usuario de `nmap`][nmap-reference]
- [Guía del usuario de **WireShark**][wireshark-docs]
- [Preguntas frecuentes de **WireShark**][wireshark-faq]

## Restricciones

- La fecha límite de entrega es el **lunes 2 de mayo de 2022** a las 23:59 horas
- Esta actividad debe ser entregada **en equipo** de acuerdo al [flujo de trabajo para la entrega de tareas y prácticas][flujo-de-trabajo]
    - Utilizar la carpeta `docs/tareas/tarea-3/Equipo-ABCD-EFGH-IJKL-MNOP` para entregar la práctica
        - Donde `Equipo-ABCD-EFGH-IJKL-MNOP` representa el nombre del equipo que debió anotarse previamente en la [lista del grupo][lista-redes]
    - Crear un _merge request_ en el [repositorio de tareas][repo-tareas] para entregar la actividad

## Entregables

- Archivo `README.md`
    - Explicación de los comandos utilizados
    - Explicación de los filtros de captura utilizados
    - Filtro de captura para la capa de aplicación
    - Resultados de las pruebas de conectividad

- Carpeta `files`
    - Archivos de las capturas de tráfico de cada capa del modelo OSI en formato PCAP
        - Las capturas de tráfico no deben pesar más de `1 MB`
    - Explicación el tráfico encontrado en cada captura de tráfico de red

--------------------------------------------------------------------------------

## Procedimiento

- Verifica que las siguientes herramientas estén instaladas en tu máquina física.
    - Se recomienda instalar las dependencias en Windows utilizando [chocolatey]

| GNU/Linux Debian        | macOS                    | Windows                               |
|:-----------------------:|:------------------------:|:-------------------------------------:|
| `apt install wireshark` | `brew install wireshark` | `choco install wireshark`
| `apt install tcpdump`   | `brew install tcpdump`   | `choco install wireshark` <br/> ([windump])
| `apt install nmap`      | `brew install nmap`      | `choco install nmap`

### Solicitar una nueva dirección IP al servidor DHCP

Expira el _lease_ de la dirección de DHCP y solicita una nueva

- Reemplaza `${IFACE}` por el nombre de tu interfaz de red

| GNU/Linux                         | macOS                          | Windows             |
|:---------------------------------:|:------------------------------:|:-------------------:|
| `dhclient -r ${IFACE}`            | `ipconfig set "${IFACE}" NONE` | `ipconfig /release`
| `ifdown ${IFACE} ; ifup ${IFACE}` | `ipconfig set "${IFACE}" DHCP` | `ipconfig /renew`

Obtén la dirección MAC e IP de tu interfaz de red

| GNU/Linux     | macOS         | Windows         |
|:-------------:|:-------------:|:---------------:|
| `ifconfig -a` | `ifconfig -a` | `ipconfig /all`
| `ip addr`     |               |

Obtén la dirección IPv4 e IPv6 del ruteador

| GNU/Linux       | macOS               | Windows         |
|:---------------:|:-------------------:|:---------------:|
| `netstat -rn`   | `netstat -rn`       | `netstat -rn`
| `route -n`      | `route get default` | `ipconfig /all`
| `ip route show` |                     |

### Captura de tráfico

!!! note
    Deberás hacer una captura de tráfico nueva para las pruebas de cada una de las capas de red

Identifica la interfaz por la que te conectas a Internet, ya sea alámbrica o inalámbrica

| GNU/Linux     | macOS                                | Windows         |
|:-------------:|:------------------------------------:|:---------------:|
| `ifconfig -a` | `ifconfig -a`                        | `ipconfig /all`
| `ip addr`     | `networksetup -listallhardwareports` |

Inicia una captura de tráfico con `tcpdump` o **WireShark** en la máquina física

- En el caso de **WireShark** selecciona la interfaz de red adecuada
    - **WireShark** pide el filtro de captura cuando se selecciona la interfaz de red antes de iniciar la captura de tráfico
- Para `tcpdump` reemplaza `${IFACE}` por el nombre de tu interfaz de red
    - Asegúrate de incluir las comillas si el nombre de la interfaz de red contiene espacios (Windows)
    - El **filtro de captura**, debe ir encerrado entre comilas simples `'`
    
```
% tcpdump -pevvvni "${IFACE}" -w captura.pcap 'FILTRO'
```

#### Limpiar la tabla ARP

!!! warning
    Para esta actividad **deberás limpiar la tabla ARP** cuando inicies una captura de tráfico de red

Limpia la tabla ARP de la maquina física después de iniciar la captura de tráfico

<!-- -->

[man-arp]: https://linux.die.net/man/8/arp

| GNU/Linux                | macOS       | Windows                              |
|:------------------------:|:-----------:|:------------------------------------:|
| `ip neighbour flush all` | `arp -d -a` | `arp -d *`
|                          |             | `netsh interface IP delete arpcache`

<!-- -->

#### Mostrar la tabla ARP

Muestra la tabla ARP de la máquina física **al finalizar la captura de tráfico**

- Agrega la tabla ARP al final de tu reporte en el archivo `README.md`

<!-- -->

| GNU/Linux                | macOS       | Windows  |
|:------------------------:|:-----------:|:--------:|
| `arp -an`                | `arp -a -n` | `arp -a`
| `ip neighbour show`      |             | 

<!-- -->

#### Limpiar el caché de DNS

!!! warning
    Para esta actividad **deberás limpiar el caché de DNS** cuando inicies una captura de tráfico de red

- Limpia el caché de DNS en la máquina física

| GNU/Linux                        | macOS                        | Windows              |
|:--------------------------------:|:----------------------------:|:--------------------:|
| `systemd-resolve --flush-caches` | `dscacheutil -flushcache`    | `ipconfig /flushDNS`
| `resolvectl flush-caches`        | `killall -HUP mDNSResponder` |
| `service dnsmasq restart`        |

[mac-dns-cache]: https://help.dreamhost.com/hc/en-us/articles/214981288-Flushing-your-DNS-cache-in-Mac-OS-X-and-Linux
[clear-dns-cache]: https://linuxize.com/post/how-to-clear-the-dns-cache/
[linux-dns-cache]: https://www.cyberciti.biz/faq/rhel-debian-ubuntu-flush-clear-dns-cache/

- Haz una consulta al DNS

| `dig` | `nslookup` |
|:-----:|:----------:|
| `dig TIPO NOMBRE @SERVIDOR`      | `nslookup -type=TIPO NOMBRE SERVIDOR`
| `dig AAAA example.com. @1.1.1.1` | `nslookup -type=AAAA example.com. 1.1.1.1`

--------------------------------------------------------------------------------

### Pruebas de conectividad

#### Capa 2 - Enlace

<details open>
  <summary>Utiliza este filtro para tcpdump o WireShark</summary>
```
'arp or (ether src host 00:00:00:00:00:00 or ether dst host ff:ff:ff:ff:ff:ff)'
```
</details>

- Hacer un descubrimiento de la red con `nmap`
    - Reemplaza `192.168.X.0/24` por el segmento de red que tienes en la máquina física

```
nmap -v -sP 192.168.X.0/24
```

- Separa la captura de red en 2: **tráfico ARP** y **tráfico broadcast**
    - ¿Qué tráfico de red aparece además de ARP?

--------------------------------------------------------------------------------

#### Capa 3 - Red

<details open>
  <summary>Utiliza este filtro para tcpdump o WireShark</summary>
```
'ip6 or icmp or ( host ( 0.0.0.0 or 255.255.255.255 ) or ip6 host :: or ip6 net ::ffff )'
```
</details>

- Hacer pruebas de conectividad hacia el router

```
% ping -c 10 ${ROUTER}

% ping6 -c 10 ${ROUTER}
```

- Hacer pruebas de conectividad hacia Internet

```
% ping -c 10 1.1.1.1

% ping6 -c 10 2606:4700:4700::1111

% ping -c 10 www.fciencias.unam.mx  # 132.248.181.220  # pagina de la FC (IPv4)

% ping6 -c 10 www.unam.mx  # 2606:4700::6811:752e  # pagina de la UNAM (IPv6)
```

- Hacer el descubrimiento de la ruta hacia esos destinos

```
% traceroute -n 1.1.1.1

% traceroute6 -n 2606:4700:4700::1111

% traceroute -n www.fciencias.unam.mx

% traceroute6 -n www.unam.mx
```

--------------------------------------------------------------------------------

#### Capa 4 - Transporte

<details open>
  <summary>Utiliza este filtro para tcpdump o WireShark</summary>
```
'udp port ( 53 or 67 or 68 ) or tcp port ( 22 or 53 or 5353 or 1024 or 16384 or 32768 or 49152 or 65535 )'
```
</details>

- Realiza pruebas de conexión exitosas y no exitosas

    - 22, 53, 5353, 80, 443, 1024, 16384, 32768, 49152, 65535

--------------------------------------------------------------------------------

#### Capa 7 - Aplicación

!!! note
    - Crea un filtro para únicamente capturar el tráfico hacia los hosts y puertos indicados en los pasos siguientes.

<!--
<details open>
  <summary>Utiliza este filtro para tcpdump o WireShark</summary>
```
'tcp port ( 80 or 443 ) and ( host ( 1.1.1.1 or 93.184.216.34 ) or ip6 host ( 2606:4700:4700::1111 or 2606:2800:220:1:248:1893:25c8:1946 ) )'
```
</details>
-->

- Hacer una resolución de DNS con `dig` o `nslookup`

```
% dig A example.com. @1.1.1.1
% dig AAAA example.com. @1.1.1.1

% nslookup -type=A example.com. 1.1.1.1
% nslookup -type=AAAA example.com. 1.1.1.1
```

- Realiza conexiones HTTP y HTTPS

```
% curl -vk#L http://1.1.1.1/ > /dev/null

% curl -vk#L http://[2606:4700:4700::1111]/ > /dev/null

% curl -4vk# http://example.com/

% curl -6vk# http://example.com/

% curl -4vk# https://example.com/

% curl -6vk# https://example.com/
```

--------------------------------------------------------------------------------

<!--


- Hacer una prueba de conectividad hacia la dirección IP del gateway

```
$ ping ${GATEWAY}
```

- Hacer una prueba de conectividad hacia direcciones externas en Internet

```
$ ping -c 10 1.1.1.1

$ ping -c 10 8.8.8.8

$ ping -c 10 9.9.9.9
```

- Intentar acceder un puerto no disponible

```
$ nc -vz ${GATEWAY} 12345

$ nc -vz ${GATEWAY} 65535
```

- Acceder a un servicio HTTP con curl

```
$ nc -vz 1.1.1.1 80

$ curl -vk# http://1.1.1.1/


$ dig +short A example.com.
93.184.216.34

$ ping -c 10 example.com.

$ nc -vz example.com. 80

$ curl -vk# "http://example.com/"

$ nc -vz example.com. 443

$ curl -vk# "https://example.com/"
```

- Acceder a un servicio HTTPS con curl

```
$ nc -vz 1.1.1.1 443

$ curl -vk# https://1.1.1.1/
```

- Acceder a una página HTTP en el navegador web

- Muestra la tabla ARP de la máquina física

-->
<!--

| GNU/Linux                | macOS       | Windows  |
|:------------------------:|:-----------:|:--------:|
| `arp -an`                | `arp -a -n` | `arp -a`
| `ip neighbour show`      |             | 

-->

--------------------------------------------------------------------------------

[flujo-de-trabajo]: https://redes-ciencias-unam.gitlab.io/2022-2/tareas-redes/workflow/
[repo-tareas]: https://gitlab.com/Redes-Ciencias-UNAM/2022-2/tareas-redes/-/merge_requests

[lista-redes]: https://tinyurl.com/Lista-Redes-2022-2

[chocolatey]: https://chocolatey.org/install
[wireshark]: https://www.wireshark.org/
[tcpdump]: https://www.tcpdump.org/
[windump]: https://www.winpcap.org/windump/
[nmap]: https://nmap.org/download.html

[dig-man]: https://linux.die.net/man/1/dig
[nslookup-man]: https://ss64.com/bash/nslookup.html
[tcpdump-man]: https://www.tcpdump.org/manpages/tcpdump.1.html
[windump-man]: https://www.winpcap.org/windump/docs/manual.htm
[wireshark-faq]: https://www.wireshark.org/faq.html
[wireshark-docs]: https://www.wireshark.org/docs/wsug_html_chunked/
[nmap-reference]: https://nmap.org/book/man.html

[dhclient-nixcraft]: https://www.cyberciti.biz/faq/howto-linux-renew-dhcp-client-ip-address/

[man-dhclient]: https://linux.die.net/man/8/dhclient
