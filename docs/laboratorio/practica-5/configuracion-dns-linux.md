---
title: Configuración de servidor forwarder DNS en GNU/Linux
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Configuración de servidor _forwarder_ DNS en GNU/Linux

!!! note
    Realiza esta configuración en la máquina **Debian**

## Configuración de `dnsmasq`

Instala el programa `dnsmasq`.

```
root@debian:~# apt -qy install dnsmasq
```

Crea una copia del archivo de configuración original.

```
root@debian:~# cp -v /etc/dnsmasq.conf ~/dnsmasq.conf.orig
```

Modifica las siguientes líneas en el archivo `/etc/dnsmasq.conf` para configurar el programa.

```
# https://linux.die.net/man/8/dnsmasq

# Archivo que contiene las reglas para resolver DNS
# El archivo puede tener cualquier nombre
resolv-file=/etc/resolv-upstream.conf

# Asigna una dirección IP a un nombre DNS arbitrario
address=/gateway.local/192.168.56.254
address=/dns.local/192.168.56.254

# Especificar la red por donde escuchará
# Al ser un DNS local será la interfaz interna
interface=eth0
bind-interfaces
```

!!! warning
    - Verifica el tipo, nombre, dirección MAC e IP de tus interfaces de red.

!!! note
    - Anexa el archivo `/etc/dnsmasq.conf` a tu reporte de la práctica.

Crea el archivo `/etc/resolv-upstream.conf` con las direcciones IP de servidores DNS públicos.

```
# https://linux.die.net/man/5/resolv.conf
# dnsmasq envía las consultas DNS a los servidores externos
nameserver	1.1.1.1
nameserver	8.8.8.8
nameserver	9.9.9.9
```

!!! note
    - Anexa el archivo `/etc/resolv-upstream.conf` a tu reporte de la práctica.

Reinicia el servicio de red

```
root@debian:~# systemctl restart dnsmasq
```

Verifica que el servicio se encuentre en ejecución

```
root@debian:~# systemctl status dnsmasq
```

## Configuración de resolución local de DNS

Modifica el archivo `/etc/resolv.conf` para enviar las consultas locales de DNS a la instancia de `dnsmasq`.

```
# https://linux.die.net/man/5/resolv.conf
# Envía la consultas de DNS a dnsmasq local
nameserver  127.0.0.1
```

!!! note
    Anexa el archivo `/etc/resolv.conf` a tu reporte de la práctica.

## Verificación de resolución DNS

Intenta resolver algún dominio utilizando el servidor DNS local

```
tonejito@debian:~$ dig   example.com. @127.0.0.1
	...

tonejito@debian:~$ dig gateway.local. @127.0.0.1
	...
```

Compara la salida con la resolución hacia alguno de los servidores DNS listados en el archivo `/etc/resolv-upstream.conf`

```
tonejito@debian:~$ dig   example.com. @1.1.1.1
	...

tonejito@debian:~$ dig gateway.local. @1.1.1.1
	...
```

!!! note
    - Agrega la salida de estos comandos al reporte de tu práctica.

--------------------------------------------------------------------------------

## Verificar configuración

Reinicia el equipo para verificar que los cambios sean persistentes.

```
root@debian:~# reboot
```

!!! danger
    - Verifica que **TODAS** las configuraciones que hiciste estén presentes respués de reiniciar la máquina antes de seguir con la demás configuración.

--------------------------------------------------------------------------------

Continúa con la [configuración del servidor DHCP en GNU/Linux][config-dhcp-linux]

[config-dhcp-linux]: configuracion-dhcp-linux.md
