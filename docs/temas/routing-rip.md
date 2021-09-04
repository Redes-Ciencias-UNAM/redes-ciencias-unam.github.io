# Ruteo con RIPv2

## Topología de red

Se utilizará la misma topología para todos los protocolos de ruteo internos:

* [Topología de red](routing-topology.md)

|    |
|:--:|
|![](../img/routing-topology.png)|
|Topología para protocolos de ruteo internos|
|[Archivo de Packet Tracer con la topología de red](../files/routing-topology.pkt)|
|[Archivo de Packet Tracer con la implementación de ruteo RIP](../files/routing-rip.pkt)|

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

```
enable
configure terminal
! Habilitar RIPv2
router rip
version 2
! Publicar las redes seleccionadas mediante RIP
network 192.168.0.0
network 172.16.0.0
network 172.16.3.0
end
```

#### Tabla de rutas para `Router-0`

```
show ip route

Gateway of last resort is not set
 
R    10.0.0.0/8 [120/1] via 172.16.0.2, 00:00:11, GigabitEthernet0/0
     172.16.0.0/30 is subnetted, 4 subnets
C       172.16.0.0 is directly connected, GigabitEthernet0/0
R       172.16.1.0 [120/1] via 172.16.0.2, 00:00:11, GigabitEthernet0/0
R       172.16.2.0 [120/1] via 172.16.3.1, 00:00:03, GigabitEthernet1/0
C       172.16.3.0 is directly connected, GigabitEthernet1/0
C    192.168.0.0/24 is directly connected, GigabitEthernet2/0
R    192.168.100.0/24 [120/1] via 172.16.3.1, 00:00:03, GigabitEthernet1/0
```

#### Tabla RIP para `Router-0`

```
show ip rip database

10.0.0.0/8    auto-summary
10.0.0.0/8
    [1] via 172.16.0.2, 00:00:17, GigabitEthernet0/0
172.16.0.0/30    auto-summary
172.16.0.0/30    directly connected, GigabitEthernet0/0
172.16.1.0/30    auto-summary
172.16.1.0/30
    [1] via 172.16.0.2, 00:00:17, GigabitEthernet0/0
172.16.2.0/30    auto-summary
172.16.2.0/30
    [1] via 172.16.3.1, 00:00:05, GigabitEthernet1/0
172.16.3.0/30    auto-summary
172.16.3.0/30    directly connected, GigabitEthernet1/0
192.168.0.0/24    auto-summary
192.168.0.0/24    directly connected, GigabitEthernet2/0
192.168.100.0/24    auto-summary
192.168.100.0/24
    [1] via 172.16.3.1, 00:00:05, GigabitEthernet1/0
```

--------------------------------------------------------------------------------

### Configuración para `Router-1`

```
enable
configure terminal
! Habilitar RIPv2
router rip
version 2
! Publicar las redes seleccionadas mediante RIP
network 10.10.10.0
network 172.16.0.0
network 172.16.1.0
end
```

#### Tabla de rutas para `Router-1`

```
show ip route

Gateway of last resort is not set
 
     10.0.0.0/24 is subnetted, 1 subnets
C       10.10.10.0 is directly connected, GigabitEthernet2/0
     172.16.0.0/30 is subnetted, 4 subnets
C       172.16.0.0 is directly connected, GigabitEthernet1/0
C       172.16.1.0 is directly connected, GigabitEthernet0/0
R       172.16.2.0 [120/1] via 172.16.1.2, 00:00:08, GigabitEthernet0/0
R       172.16.3.0 [120/1] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
R    192.168.0.0/24 [120/1] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
R    192.168.100.0/24 [120/2] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
                      [120/2] via 172.16.1.2, 00:00:08, GigabitEthernet0/0
```

#### Tabla RIP para `Router-1`

```
show ip rip database

10.10.10.0/24    auto-summary
10.10.10.0/24    directly connected, GigabitEthernet2/0
172.16.0.0/30    auto-summary
172.16.0.0/30    directly connected, GigabitEthernet1/0
172.16.1.0/30    auto-summary
172.16.1.0/30    directly connected, GigabitEthernet0/0
172.16.2.0/30    auto-summary
172.16.2.0/30
    [1] via 172.16.1.2, 00:00:08, GigabitEthernet0/0
172.16.3.0/30    auto-summary
172.16.3.0/30
    [1] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
192.168.0.0/24    auto-summary
192.168.0.0/24
    [1] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
192.168.100.0/24    auto-summary
192.168.100.0/24
    [2] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
    [2] via 172.16.1.2, 00:00:08, GigabitEthernet0/0
```

--------------------------------------------------------------------------------

### Configuración para `Router-2`

```
enable
configure terminal
! Habilitar RIPv2
router rip
version 2
! Publicar las redes seleccionadas mediante RIP
network 10.20.20.0
network 172.16.1.0
network 172.16.2.0
end
```

#### Tabla de rutas para `Router-2`

```
show ip route

Gateway of last resort is not set
 
     10.0.0.0/24 is subnetted, 1 subnets
C       10.10.10.0 is directly connected, GigabitEthernet2/0
     172.16.0.0/30 is subnetted, 4 subnets
C       172.16.0.0 is directly connected, GigabitEthernet1/0
C       172.16.1.0 is directly connected, GigabitEthernet0/0
R       172.16.2.0 [120/1] via 172.16.1.2, 00:00:08, GigabitEthernet0/0
R       172.16.3.0 [120/1] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
R    192.168.0.0/24 [120/1] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
R    192.168.100.0/24 [120/2] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
                      [120/2] via 172.16.1.2, 00:00:08, GigabitEthernet0/0
```

#### Tabla RIP para `Router-2`

```
show ip rip database

10.10.10.0/24    auto-summary
10.10.10.0/24    directly connected, GigabitEthernet2/0
172.16.0.0/30    auto-summary
172.16.0.0/30    directly connected, GigabitEthernet1/0
172.16.1.0/30    auto-summary
172.16.1.0/30    directly connected, GigabitEthernet0/0
172.16.2.0/30    auto-summary
172.16.2.0/30
    [1] via 172.16.1.2, 00:00:08, GigabitEthernet0/0
172.16.3.0/30    auto-summary
172.16.3.0/30
    [1] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
192.168.0.0/24    auto-summary
192.168.0.0/24
    [1] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
192.168.100.0/24    auto-summary
192.168.100.0/24
    [2] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
    [2] via 172.16.1.2, 00:00:08, GigabitEthernet0/0
```

--------------------------------------------------------------------------------

### Configuración para `Router-3`

```
enable
configure terminal
! Habilitar RIPv2
router rip
version 2
! Publicar las redes seleccionadas mediante RIP
network 192.168.100.0
network 172.16.2.0
network 172.16.3.0
end
```

#### Tabla de rutas para `Router-3`

```
show ip route

Gateway of last resort is not set
 
     10.0.0.0/24 is subnetted, 1 subnets
C       10.10.10.0 is directly connected, GigabitEthernet2/0
     172.16.0.0/30 is subnetted, 4 subnets
C       172.16.0.0 is directly connected, GigabitEthernet1/0
C       172.16.1.0 is directly connected, GigabitEthernet0/0
R       172.16.2.0 [120/1] via 172.16.1.2, 00:00:08, GigabitEthernet0/0
R       172.16.3.0 [120/1] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
R    192.168.0.0/24 [120/1] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
R    192.168.100.0/24 [120/2] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
                      [120/2] via 172.16.1.2, 00:00:08, GigabitEthernet0/0
```

#### Tabla RIP para `Router-2`

```
show ip rip database

10.10.10.0/24    auto-summary
10.10.10.0/24    directly connected, GigabitEthernet2/0
172.16.0.0/30    auto-summary
172.16.0.0/30    directly connected, GigabitEthernet1/0
172.16.1.0/30    auto-summary
172.16.1.0/30    directly connected, GigabitEthernet0/0
172.16.2.0/30    auto-summary
172.16.2.0/30
    [1] via 172.16.1.2, 00:00:08, GigabitEthernet0/0
172.16.3.0/30    auto-summary
172.16.3.0/30
    [1] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
192.168.0.0/24    auto-summary
192.168.0.0/24
    [1] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
192.168.100.0/24    auto-summary
192.168.100.0/24
    [2] via 172.16.0.1, 00:00:05, GigabitEthernet1/0
    [2] via 172.16.1.2, 00:00:08, GigabitEthernet0/0
```

--------------------------------------------------------------------------------

# Referencias

+ <https://www.cisco.com/c/en/us/td/docs/ios/iproute_rip/command/reference/irr_book/irr_rip.html>
+ <https://www.computernetworkingnotes.com/ccna-study-guide/rip-protocol-configuration-guide-with-examples.html>

