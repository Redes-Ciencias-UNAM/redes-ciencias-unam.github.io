---
title: Reservar dirección IP en DHCP
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Reservar dirección IP en DHCP

## Crear máquina virtual Alpine Linux

Descargar la [imagen ISO de Alpine Linux][alpine-linux-iso] y crear una nueva máquina virtual que inicie desde esa imagen.

- 1 vCPU
- 256 MB de RAM
- Sin disco persistente, iniciar desde la imagen ISO
- Interfaz de red host-only (sin NAT)

Inicia sesión con el usuario `root`, el LiveCD no pide contraseña.

```
Welcome to Alpine Linux 3.15
Kernel 5.15.32-0-virt on an x86_64 (/dev/tty1)

localhost login: root
```

Configurar el nombre de host

```
localhost:~# hostname alpine
alpine:~#
```

Obtener la dirección MAC con el comando `ip`.

```
alpine:~# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 0e:45:5a:65:14:8f brd ff:ff:ff:ff:ff:ff
```

!!! note
    - En este caso, la dirección MAC de la interfaz `eth0` es `0e:45:5a:65:14:8f`

!!! warning
    - Verifica el tipo, nombre, dirección MAC e IP de tus interfaces de red.

--------------------------------------------------------------------------------

## Configurar dirección reservada en DHCP

!!! note
    - Realiza esta configuración en la máquina **Debian**

Modificar el archivo `/etc/dhcp/dhcpd.conf` para reservar una dirección IP que esté en el rango de direcciones que da el servidor DHCP.

```
# https://linux.die.net/man/5/dhcpd.conf
# https://linux.die.net/man/5/dhcp-options

host alpine {
  hardware ethernet 0e:45:5a:65:14:8f;
  fixed-address 192.168.56.200;
  option host-name "alpine.ciencias.local";
}
```

!!! warning
    - Verifica el tipo, nombre, dirección MAC e IP de tus interfaces de red.

Reinicia el servicio de red.

```
root@debian:~# service isc-dhcp-server restart
```

Verifica que el servicio se encuentre en ejecución

```
root@debian:~# systemctl status isc-dhcp-server
	...
```

--------------------------------------------------------------------------------

## Verificar la dirección reservada en el cliente

!!! note
    - Realiza esta configuración en la máquina **Alpine**

Levantar la interfaz de red

```
alpine:~# ip link set eth0 up
```

Pedir una nueva dirección IP al servidor DHCP.

```
alpine:~# udhcpc -i eth0
udhcpc: started, v1.34.1
udhcpc: broadcasting discover
udhcpc: broadcasting select for 192.168.56.200, server 192.168.56.254
udhcpc: lease of 192.168.56.200 obtained from 192.168.56.254, lease time 3600
```

!!! warning
    - Verifica el tipo, nombre, dirección MAC e IP de tus interfaces de red.

Verificar que la interfaz de red tiene la dirección que se reservó en el DHCP.

```
alpine:~# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 0e:45:5a:65:14:8f brd ff:ff:ff:ff:ff:ff
    inet 192.168.56.200/24 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fd60:c153:ae78:3482:c45:5aff:fe65:148f/64 scope global dynamic flags 100 
       valid_lft 2591965sec preferred_lft 604765sec
    inet6 fe80::c45:5aff:fe65:148f/64 scope link 
       valid_lft forever preferred_lft forever
```

!!! warning
    - Verifica el tipo, nombre, dirección MAC e IP de tus interfaces de red.

## Verificar la conectividad de red

Después de la configuración, verifica los nuevos parámetros de red, la conectividad local y externa hacia Internet.

!!! note
    - Agrega la salida de todos estos comandos al reporte de tu práctica.

  - Conectividad local

```
alpine:~# ping -c 4 192.168.56.254
	...

alpine:~# ping -c 4 192.168.56.100
	...

alpine:~# ping -c 4 dns.local
	...
```

  - Conectividad externa

```
alpine:~# ping -c 4 1.1.1.1
	...

alpine:~# ping -c 4 example.com.
	...

alpine:~# wget -qcO - http://example.com/ | egrep '</?title>'
    <title>Example Domain</title>
```

--------------------------------------------------------------------------------

## Verificar configuración

Reinicia el equipo para verificar que los cambios sean persistentes.

```
alpine:~# reboot
```

!!! danger
    - Verifica que **TODAS** las configuraciones que hiciste estén presentes respués de reiniciar la máquina antes de seguir con la configuración del servidor DHCP.

--------------------------------------------------------------------------------

Continúa con la [captura de tráfico de red][captura-de-trafico]

[captura-de-trafico]: index.md#captura-de-trafico

[alpine-requirements]: https://wiki.alpinelinux.org/wiki/Requirements
[alpine-install]: https://docs.alpinelinux.org/user-handbook/0.1a/Installing/setup_alpine.html
[alpine-repositories]: https://wiki.alpinelinux.org/wiki/Enable_Community_Repository
