---
title: Configuración de servidor DHCP en GNU/Linux
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Configuración de servidor DHCP en GNU/Linux

!!! note
    Realiza esta configuración en la máquina **Debian**

## Configuración de `isc-dhcp-server`

Instala el _software_ que brinda el servicio de DHCP.

```
root@debian:~# apt -qy install isc-dhcp-server
```

Crea una copia del archivo de configuración original.

```
root@debian:~# cp -v /etc/dhcp/dhcpd.conf ~/dhcpd.conf.orig
```

Modifica las siguientes líneas en el archivo `/etc/dhcp/dhcpd.conf` para configurar el programa.

```
# https://linux.die.net/man/5/dhcpd.conf
# https://linux.die.net/man/5/dhcp-options

option  domain-name  "ciencias.local"
option  domain-name-servers  192.168.56.254;

# No se dará servicio en la red externa (NAT de VirtualBox)
subnet 10.0.2.0 netmask 255.255.255.0 {
}

# Rango de direcciones a asignar
subnet  192.168.56.0  netmask  255.255.255.0 {
    range  192.168.56.100  192.168.56.200;
    option  routers  192.168.56.254;
}
```

!!! warning
    - Verifica el tipo, nombre, dirección MAC e IP de tus interfaces de red.

!!! note
    - Anexa el archivo `/etc/dhcp/dhcpd.conf` a tu reporte de la práctica.

Especifica la interfaz de red donde se brindará el servicio de DHCP en el archivo  `/etc/default/isc-dhcp-server`.

```
INTERFACESv4="eth0"
```

!!! warning
    - Verifica el tipo, nombre, dirección MAC e IP de tus interfaces de red.

!!! note
    - Anexa el archivo `/etc/default/isc-dhcp-server` a tu reporte de la práctica.

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

## Verificar configuración

Reinicia el equipo para verificar que los cambios sean persistentes.

```
root@debian:~# reboot
```

!!! danger
    - Verifica que **TODAS** las configuraciones que hiciste estén presentes respués de reiniciar la máquina antes de seguir con las pruebas del cliente.

--------------------------------------------------------------------------------

Continúa con las [pruebas de conectividad en el cliente][pruebas-conectividad]

[pruebas-conectividad]: pruebas-conectividad.md
