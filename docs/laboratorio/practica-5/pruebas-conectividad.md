---
title: Pruebas de conectividad en el cliente
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Pruebas de conectividad en el cliente

!!! note
    - Realiza esta configuración en la máquina **CentOS**

## Obtener dirección por DHCP

Reinicia la interfaz de red para obtener una nueva dirección por DHCP.

```
[root@centos ~]# ifdown eth0
[root@centos ~]# ifup eth0
```

!!! warning
    - Verifica el tipo, nombre, dirección MAC e IP de tus interfaces de red.

!!! note
    - También puedes reiniciar la máquina virtual para obtener los nuevos parámetros de red.

Instala los comandos para la utilerias de red.

```
[root@centos ~]# yum -y install net-tools elinks
```

## Verificar la configuración de red

Después de la configuración, verifica los nuevos parámetros de red, la conectividad local y externa hacia Internet.

!!! note
    - Agrega la salida de todos estos comandos al reporte de tu práctica.

  - Configuración de red

```
[root@centos ~]# ifconfig -a
	...

[root@centos ~]# route -n
	...

[root@centos ~]# cat /etc/resolv.conf
	...
```

## Verificar la conectividad de red

  - Conectividad local

```
[tonejito@centos ~]$ ping -c 4 192.168.56.254
	...

[tonejito@centos ~]$ ping -c 4 gateway.local
	...

[tonejito@centos ~]$ ping -c 4 dns.local
	...
```

  - Resolución de DNS

```
[tonejito@centos ~]$ dig example.com. @192.168.56.254
	...

[tonejito@centos ~]$ dig example.com. @dns.local
	...

[tonejito@centos ~]$ dig example.com.
	...
```

  - Conectividad externa

```
[tonejito@centos ~]$ ping -c 4 1.1.1.1
	...

[tonejito@centos ~]$ ping -c 4 example.com.
	...

[tonejito@centos ~]$ links -dump http://example.com/
	...
```

--------------------------------------------------------------------------------

## Verificar configuración

Reinicia el equipo para verificar que los cambios sean persistentes.

```
[root@centos ~]# reboot
```

!!! danger
    - Verifica que **TODAS** las configuraciones que hiciste estén presentes respués de reiniciar la máquina antes de seguir con la configuración del servidor DHCP.

--------------------------------------------------------------------------------

Continúa con la configuración para [reservar dirección IP en DHCP][reservar-ip-dhcp]

[reservar-ip-dhcp]: reservar-ip-dhcp.md
