# Ruteo con BGP

## Topología de red

Se utilizará la misma topología para todos los protocolos de ruteo internos:

* [Topología de red](routing-topology.md)

|    |
|:--:|
|![](../img/routing-topology.png)|
|Topología para protocolos de ruteo internos|
|[Archivo de Packet Tracer con la topología de red](../files/routing-topology.pkt)|
<!--
|[Archivo de Packet Tracer con la implementación de ruteo OSPF](../files/routing-bgp.pkt)|
-->

Cada router tiene las siguientes interfaces

| Interfaz           | Tipo         | Conexión          |
|:------------------:|:------------:|:-----------------:|
| GigabitEthernet0/0 | Fibra Óptica | Hacia otro router |
| GigabitEthernet1/0 | Fibra Óptica | Hacia otro router |
| GigabitEthernet2/0 | Ethernet     | Hacia red LAN     |

|    |
|:--:|
|![](../img/router-interfaces.png)|
|Interfaces de red de routers|

Las redes presentes en esta topología son las siguientes:

Redes de equipos

| Red | Equipo   | Dirección IP    | Máscara de red  |
|:---:|:--------:|:---------------:|:---------------:|
| A   | PC-0     | 192.168.0.1     | 255.255.255.0   |
| A   | SW-0     | 192.168.0.253   | 255.255.255.0   |
| A   | R1       | 192.168.0.254   | 255.255.255.0   |
| B   | Server-1 | 10.10.10.1      | 255.255.255.0   |
| B   | SW-1     | 10.10.10.253    | 255.255.255.0   |
| B   | R1       | 10.10.10.254    | 255.255.255.0   |
| C   | Server-2 | 10.20.20.1      | 255.255.255.0   |
| C   | SW-2     | 10.20.20.253    | 255.255.255.0   |
| C   | R2       | 10.20.20.254    | 255.255.255.0   |
| D   | Laptop-3 | 192.168.100.1   | 255.255.255.0   |
| D   | SW-3     | 192.168.100.253 | 255.255.255.0   |
| D   | R3       | 192.168.100.254 | 255.255.255.0   |

Redes que interconectan a los ruteadores

| Red | Equipo | Dirección IP     | Máscara de red  |
|:---:|:------:|:----------------:|:---------------:|
| W   | R0     | 172.16.0.1       | 255.255.255.252 |
| W   | R1     | 172.16.0.2       | 255.255.255.252 |
| X   | R1     | 172.16.1.1       | 255.255.255.252 |
| X   | R2     | 172.16.1.2       | 255.255.255.252 |
| Y   | R2     | 172.16.2.1       | 255.255.255.252 |
| Y   | R3     | 172.16.2.2       | 255.255.255.252 |
| Z   | R3     | 172.16.3.1       | 255.255.255.252 |
| Z   | R0     | 172.16.3.2       | 255.255.255.252 |

## Configuración en Cisco IOS

La configuración se realiza en tres partes por cada _router_

1. Equipos directamente conectados
2. Redes intermedias de interconexión
3. Red con destino indirecto

La configuración se debe realizar en el modo de configuración global

```
Router-0> enable
Router-0# configure terminal
Enter configuration commands, one per line.  End with CNTL/Z.
Router-0(config)#
```

Al finalizar la configuración se debe ejecutar el comando `end` para aplicar los cambios

```
Router-0(config)# end
Router-0#
%SYS-5-CONFIG_I: Configured from console by console
```

Para mostrar la tabla de rutas se utiliza el comando `show ip route` que muestra la siguiente leyenda sobre las rutas del equipo:

```
Router-0# show ip route

Codes: C - connected, S - static, I - IGRP, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2, E - EGP
       i - IS-IS, L1 - IS-IS level-1, L2 - IS-IS level-2, ia - IS-IS inter area
       * - candidate default, U - per-user static route, o - ODR
       P - periodic downloaded static route
```

--------------------------------------------------------------------------------

### Configuración para `Router-0`

--------------------------------------------------------------------------------

### Configuración para `Router-1`

--------------------------------------------------------------------------------

### Configuración para `Router-2`

--------------------------------------------------------------------------------

### Configuración para `Router-3`

--------------------------------------------------------------------------------

## Diagnóstico de BGP en los ruteadores

### Información de diagnóstico para `Router-0`

--------------------------------------------------------------------------------

### Información de diagnóstico para `Router-1`

--------------------------------------------------------------------------------

### Información de diagnóstico para `Router-2`

--------------------------------------------------------------------------------

### Información de diagnóstico para `Router-3`

--------------------------------------------------------------------------------

# Referencias

+ <https://en.wikipedia.org/wiki/Autonomous_system_%28Internet%29>
+ <https://www.cisco.com/c/en/us/td/docs/ios/iproute_bgp/command/reference/irg_book.html>
+ <https://www.cisco.com/c/en/us/support/docs/ip/border-gateway-protocol-bgp/13751-23.html>
+ <https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/iproute_bgp/configuration/15-mt/irg-15-mt-book/irg-int-features.html>
+ <https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/iproute_bgp/configuration/xe-16/irg-xe-16-book/eibgp-multipath-for-non-vrf-interfaces-ipv-ipv.html>
+ <https://www.packettracernetwork.com/tutorials/bgp.html>
+ <https://ipcisco.com/lesson/bgp-configuration-example-on-packet-tracer/>
+ <https://www.flackbox.com/cisco-bgp-neighbor-configuration>
+ <https://networkel.com/bgp-configuration-example/>
+ <https://www.ciscopress.com/articles/article.asp?p=2756480&seqNum=13>

