`# Ruteo con OSPF

## Topología de red

Se utilizará la misma topología para todos los protocolos de ruteo internos:

* [Topología de red](routing-topology.md)

|    |
|:--:|
|![](../img/routing-topology.png)|
|Topología para protocolos de ruteo internos|
|[Archivo de Packet Tracer con la topología de red](../files/routing-topology.pkt)|
|[Archivo de Packet Tracer con la implementación de ruteo OSPF](../files/routing-ospf.pkt)|

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

#### Agregar interfaz loopback

```
enable
configure terminal
! Configurar la interfaz loopback
interface loopback 0
ip address 172.31.255.1 255.255.255.0
! Finalizar la configuración
end
```

#### Configurar OSPF

```
enable
configure terminal
! Habilitar OSPF en el ruteador con el PID=1
router ospf 1
! Establecer el ID del ruteador para OSPF
router-id 172.31.255.1
! Publicar las redes mediante OSPF
network 192.168.0.254 0.0.0.255 area 0
network 172.16.0.1    0.0.0.3   area 0
network 172.16.3.2    0.0.0.3   area 0
! Finalizar la configuración
end
```

##### Mensajes de confirmación de vecinos OSPF

Después de configurar adecuadamente todos los ruteadores se verán los mensajes que confirman que el ruteador pudo establecer relación con los vecinos

```
00:00:40: %OSPF-5-ADJCHG: Process 1, Nbr 172.31.255.4 on GigabitEthernet1/0 from LOADING to FULL, Loading Done

00:00:45: %OSPF-5-ADJCHG: Process 1, Nbr 172.31.255.2 on GigabitEthernet0/0 from LOADING to FULL, Loading Done
```

--------------------------------------------------------------------------------

### Configuración para `Router-1`

# Agregar interfaz loopback

```
enable
configure terminal
! Configurar la interfaz loopback
interface loopback 0
ip address 172.31.255.2 255.255.255.0
! Finalizar la configuración
end
```

# Configurar OSPF

```
enable
configure terminal
! Habilitar OSPF en el ruteador con el PID=1
router ospf 1
! Establecer el ID del ruteador para OSPF
router-id 172.31.255.2
! Publicar las redes mediante OSPF
network 10.10.10.254 0.0.0.255 area 0
network 172.16.0.2   0.0.0.3   area 0
network 172.16.1.1   0.0.0.3   area 0
! Finalizar la configuración
end
```

##### Mensajes de confirmación de vecinos OSPF

```
00:00:40: %OSPF-5-ADJCHG: Process 1, Nbr 172.31.255.1 on GigabitEthernet0/0 from LOADING to FULL, Loading Done

00:00:45: %OSPF-5-ADJCHG: Process 1, Nbr 172.31.255.3 on GigabitEthernet1/0 from LOADING to FULL, Loading Done
```

--------------------------------------------------------------------------------

### Configuración para `Router-2`

#### Agregar interfaz loopback

```
enable
configure terminal
! Configurar la interfaz loopback
interface loopback 0
ip address 172.31.255.3 255.255.255.0
! Finalizar la configuración
end
```

#### Configurar OSPF

```
enable
configure terminal
! Habilitar OSPF en el ruteador con el PID=1
router ospf 1
! Establecer el ID del ruteador para OSPF
router-id 172.31.255.3
! Publicar las redes mediante OSPF
network 10.20.20.254 0.0.0.255 area 0
network 172.16.1.2   0.0.0.3   area 0
network 172.16.2.1   0.0.0.3   area 0
! Finalizar la configuración
end
```

##### Mensajes de confirmación de vecinos OSPF

```
00:00:40: %OSPF-5-ADJCHG: Process 1, Nbr 172.31.255.2 on GigabitEthernet1/0 from LOADING to FULL, Loading Done

00:00:45: %OSPF-5-ADJCHG: Process 1, Nbr 172.31.255.4 on GigabitEthernet0/0 from LOADING to FULL, Loading Done
```

--------------------------------------------------------------------------------

### Configuración para `Router-3`

#### Agregar interfaz loopback

```
enable
configure terminal
! Configurar la interfaz loopback
interface loopback 0
ip address 172.31.255.4 255.255.255.0
! Finalizar la configuración
end
```

#### Configurar OSPF

```
enable
configure terminal
! Habilitar OSPF en el ruteador con el PID=1
router ospf 1
! Establecer el ID del ruteador para OSPF
router-id 172.31.255.4
! Publicar las redes mediante OSPF
network 192.168.100.254 0.0.0.255 area 0
network 172.16.2.2      0.0.0.3   area 0
network 172.16.3.1      0.0.0.3   area 0
! Finalizar la configuración
end
```

##### Mensajes de confirmación de vecinos OSPF

```
00:00:40: %OSPF-5-ADJCHG: Process 1, Nbr 172.31.255.1 on GigabitEthernet0/0 from LOADING to FULL, Loading Done

00:00:45: %OSPF-5-ADJCHG: Process 1, Nbr 172.31.255.3 on GigabitEthernet1/0 from LOADING to FULL, Loading Done
```

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

## Diagnóstico de OSPF en los ruteadores

### Información de diagnóstico para `Router-0`

#### Tabla de rutas

```
Router-0# show ip route

Gateway of last resort is not set

     172.16.0.0/30 is subnetted, 2 subnets
C       172.16.0.0 is directly connected, GigabitEthernet0/0
C       172.16.3.0 is directly connected, GigabitEthernet1/0
     172.31.0.0/24 is subnetted, 1 subnets
C       172.31.255.0 is directly connected, Loopback0
C    192.168.0.0/24 is directly connected, GigabitEthernet2/0
```

##### Tabla de rutas obtenidas por OSPF

```
Router-0# show ip route ospf
     10.0.0.0/24 is subnetted, 2 subnets
O       10.10.10.0 [110/2] via 172.16.0.2, 00:00:06, GigabitEthernet0/0
O       10.20.20.0 [110/3] via 172.16.0.2, 00:00:06, GigabitEthernet0/0
                   [110/3] via 172.16.3.1, 00:00:06, GigabitEthernet1/0
     172.16.0.0/30 is subnetted, 4 subnets
O       172.16.1.0 [110/2] via 172.16.0.2, 00:00:06, GigabitEthernet0/0
O       172.16.2.0 [110/2] via 172.16.3.1, 00:00:06, GigabitEthernet1/0
O    192.168.100.0 [110/2] via 172.16.3.1, 00:00:06, GigabitEthernet1/0
```

#### Información de OSPF

```
Router-0# show ip ospf
 Routing Process "ospf 1" with ID 172.31.255.1
 Supports only single TOS(TOS0) routes
 Supports opaque LSA
 SPF schedule delay 5 secs, Hold time between two SPFs 10 secs
 Minimum LSA interval 5 secs. Minimum LSA arrival 1 secs
 Number of external LSA 0. Checksum Sum 0x000000
 Number of opaque AS LSA 0. Checksum Sum 0x000000
 Number of DCbitless external and opaque AS LSA 0
 Number of DoNotAge external and opaque AS LSA 0
 Number of areas in this router is 1. 1 normal 0 stub 0 nssa
 External flood list length 0
    Area BACKBONE(0)
        Number of interfaces in this area is 3
        Area has no authentication
        SPF algorithm executed 2 times
        Area ranges are
        Number of LSA 8. Checksum Sum 0x056de8
        Number of opaque link LSA 0. Checksum Sum 0x000000
        Number of DCbitless LSA 0
        Number of indication LSA 0
        Number of DoNotAge LSA 0
        Flood list length 0
```

#### Información detallada de interfaces con OSPF

```
Router-0# show ip ospf interface

GigabitEthernet0/0 is up, line protocol is up
  Internet address is 172.16.0.1/30, Area 0
  Process ID 1, Router ID 172.31.255.1, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State BDR, Priority 1
  Designated Router (ID) 172.31.255.2, Interface address 172.16.0.2
  Backup Designated Router (ID) 172.31.255.1, Interface address 172.16.0.1
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:06
  Index 1/1, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 1, Adjacent neighbor count is 1
    Adjacent with neighbor 172.31.255.2  (Designated Router)
  Suppress hello for 0 neighbor(s)
GigabitEthernet1/0 is up, line protocol is up
  Internet address is 172.16.3.2/30, Area 0
  Process ID 1, Router ID 172.31.255.1, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State BDR, Priority 1
  Designated Router (ID) 172.31.255.4, Interface address 172.16.3.1
  Backup Designated Router (ID) 172.31.255.1, Interface address 172.16.3.2
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:06
  Index 2/2, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 1, Adjacent neighbor count is 1
    Adjacent with neighbor 172.31.255.4  (Designated Router)
  Suppress hello for 0 neighbor(s)
GigabitEthernet2/0 is up, line protocol is up
  Internet address is 192.168.0.254/24, Area 0
  Process ID 1, Router ID 172.31.255.1, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State DR, Priority 1
  Designated Router (ID) 172.31.255.1, Interface address 192.168.0.254
  No backup designated router on this network
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:06
  Index 3/3, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 0, Adjacent neighbor count is 0
  Suppress hello for 0 neighbor(s)
```

#### Tabla de vecinos de OSPF

```
Router-0# show ip ospf neighbor


Neighbor ID     Pri   State           Dead Time   Address         Interface
172.31.255.2      1   FULL/DR         00:00:36    172.16.0.2      GigabitEthernet0/0
172.31.255.4      1   FULL/DR         00:00:36    172.16.3.1      GigabitEthernet1/0
```

#### Detalle de vecinos OSPF

```
Router-0# show ip ospf neighbor detail 
 Neighbor 172.31.255.2, interface address 172.16.0.2
    In the area 0 via interface GigabitEthernet0/0
    Neighbor priority is 1, State is FULL, 6 state changes
    DR is 172.16.0.2 BDR is 172.16.0.1
    Options is 0x00
    Dead timer due in 00:00:38
    Neighbor is up for 00:04:01
    Index 1/1, retransmission queue length 0, number of retransmission 0
    First 0x0(0)/0x0(0) Next 0x0(0)/0x0(0)
    Last retransmission scan length is 0, maximum is 1
    Last retransmission scan time is 0 msec, maximum is 0 msec
 Neighbor 172.31.255.4, interface address 172.16.3.1
    In the area 0 via interface GigabitEthernet1/0
    Neighbor priority is 1, State is FULL, 6 state changes
    DR is 172.16.3.1 BDR is 172.16.3.2
    Options is 0x00
    Dead timer due in 00:00:38
    Neighbor is up for 00:04:01
    Index 2/2, retransmission queue length 0, number of retransmission 0
    First 0x0(0)/0x0(0) Next 0x0(0)/0x0(0)
    Last retransmission scan length is 0, maximum is 0
    Last retransmission scan time is 0 msec, maximum is 0 msec
```

#### Base de datos OSPF

```
Router-0# show ip ospf database
            OSPF Router with ID (172.31.255.1) (Process ID 1)

                Router Link States (Area 0)

Link ID         ADV Router      Age         Seq#       Checksum Link count
172.31.255.2    172.31.255.2    207         0x80000005 0x007802 3
172.31.255.1    172.31.255.1    207         0x80000006 0x009c90 3
172.31.255.3    172.31.255.3    207         0x80000005 0x0087d8 3
172.31.255.4    172.31.255.4    207         0x80000006 0x00dde0 3

                Net Link States (Area 0)
Link ID         ADV Router      Age         Seq#       Checksum
172.16.1.2      172.31.255.3    212         0x80000001 0x00e1eb
172.16.0.2      172.31.255.2    207         0x80000001 0x005ed3
172.16.3.1      172.31.255.4    207         0x80000001 0x00d3f7
172.16.2.2      172.31.255.4    207         0x80000002 0x00dee9
```

--------------------------------------------------------------------------------

### Información de diagnóstico para `Router-1`

#### Tabla de rutas

```
Router-1# show ip route

Gateway of last resort is not set

     10.0.0.0/24 is subnetted, 2 subnets
C       10.10.10.0 is directly connected, GigabitEthernet2/0
O       10.20.20.0 [110/2] via 172.16.1.2, 00:00:24, GigabitEthernet0/0
     172.16.0.0/30 is subnetted, 4 subnets
C       172.16.0.0 is directly connected, GigabitEthernet1/0
C       172.16.1.0 is directly connected, GigabitEthernet0/0
O       172.16.2.0 [110/2] via 172.16.1.2, 00:00:24, GigabitEthernet0/0
O       172.16.3.0 [110/2] via 172.16.0.1, 00:00:14, GigabitEthernet1/0
     172.31.0.0/24 is subnetted, 1 subnets
C       172.31.255.0 is directly connected, Loopback0
O    192.168.0.0/24 [110/2] via 172.16.0.1, 00:00:14, GigabitEthernet1/0
O    192.168.100.0/24 [110/3] via 172.16.0.1, 00:00:14, GigabitEthernet1/0
                      [110/3] via 172.16.1.2, 00:00:14, GigabitEthernet0/0
```

##### Tabla de rutas obtenidas por OSPF

```
Router-1# show ip route ospf
     10.0.0.0/24 is subnetted, 2 subnets
O       10.20.20.0 [110/2] via 172.16.1.2, 00:00:38, GigabitEthernet0/0
     172.16.0.0/30 is subnetted, 4 subnets
O       172.16.2.0 [110/2] via 172.16.1.2, 00:00:38, GigabitEthernet0/0
O       172.16.3.0 [110/2] via 172.16.0.1, 00:00:28, GigabitEthernet1/0
O    192.168.0.0 [110/2] via 172.16.0.1, 00:00:28, GigabitEthernet1/0
O    192.168.100.0 [110/3] via 172.16.0.1, 00:00:28, GigabitEthernet1/0
                   [110/3] via 172.16.1.2, 00:00:28, GigabitEthernet0/0
```

#### Información de OSPF

```
Router-1# show ip ospf
 Routing Process "ospf 1" with ID 172.31.255.2
 Supports only single TOS(TOS0) routes
 Supports opaque LSA
 SPF schedule delay 5 secs, Hold time between two SPFs 10 secs
 Minimum LSA interval 5 secs. Minimum LSA arrival 1 secs
 Number of external LSA 0. Checksum Sum 0x000000
 Number of opaque AS LSA 0. Checksum Sum 0x000000
 Number of DCbitless external and opaque AS LSA 0
 Number of DoNotAge external and opaque AS LSA 0
 Number of areas in this router is 1. 1 normal 0 stub 0 nssa
 External flood list length 0
    Area BACKBONE(0)
        Number of interfaces in this area is 3
        Area has no authentication
        SPF algorithm executed 3 times
        Area ranges are
        Number of LSA 8. Checksum Sum 0x04f163
        Number of opaque link LSA 0. Checksum Sum 0x000000
        Number of DCbitless LSA 0
        Number of indication LSA 0
        Number of DoNotAge LSA 0
        Flood list length 0
```

#### Información detallada de interfaces con OSPF

```
Router-1# show ip ospf interface

GigabitEthernet1/0 is up, line protocol is up
  Internet address is 172.16.0.2/30, Area 0
  Process ID 1, Router ID 172.31.255.2, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State DR, Priority 1
  Designated Router (ID) 172.31.255.2, Interface address 172.16.0.2
  Backup Designated Router (ID) 172.31.255.1, Interface address 172.16.0.1
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:03
  Index 1/1, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 1, Adjacent neighbor count is 1
    Adjacent with neighbor 172.31.255.1  (Backup Designated Router)
  Suppress hello for 0 neighbor(s)
GigabitEthernet2/0 is up, line protocol is up
  Internet address is 10.10.10.254/24, Area 0
  Process ID 1, Router ID 172.31.255.2, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State DR, Priority 1
  Designated Router (ID) 172.31.255.2, Interface address 10.10.10.254
  No backup designated router on this network
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:03
  Index 2/2, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 0, Adjacent neighbor count is 0
  Suppress hello for 0 neighbor(s)
GigabitEthernet0/0 is up, line protocol is up
  Internet address is 172.16.1.1/30, Area 0
  Process ID 1, Router ID 172.31.255.2, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State BDR, Priority 1
  Designated Router (ID) 172.31.255.3, Interface address 172.16.1.2
  Backup Designated Router (ID) 172.31.255.2, Interface address 172.16.1.1
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:03
  Index 3/3, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 1, Adjacent neighbor count is 1
    Adjacent with neighbor 172.31.255.3  (Designated Router)
  Suppress hello for 0 neighbor(s)
```

#### Tabla de vecinos de OSPF

```
Router-1# show ip ospf neighbor


Neighbor ID     Pri   State           Dead Time   Address         Interface
172.31.255.1      1   FULL/BDR        00:00:30    172.16.0.1      GigabitEthernet1/0
172.31.255.3      1   FULL/DR         00:00:31    172.16.1.2      GigabitEthernet0/0
```

#### Detalle de vecinos OSPF

```
Router-1# show ip ospf neighbor detail
 Neighbor 172.31.255.1, interface address 172.16.0.1
    In the area 0 via interface GigabitEthernet1/0
    Neighbor priority is 1, State is FULL, 5 state changes
    DR is 172.16.0.2 BDR is 172.16.0.1
    Options is 0x00
    Dead timer due in 00:00:36
    Neighbor is up for 00:02:23
    Index 1/1, retransmission queue length 0, number of retransmission 0
    First 0x0(0)/0x0(0) Next 0x0(0)/0x0(0)
    Last retransmission scan length is 0, maximum is 0
    Last retransmission scan time is 0 msec, maximum is 0 msec
 Neighbor 172.31.255.3, interface address 172.16.1.2
    In the area 0 via interface GigabitEthernet0/0
    Neighbor priority is 1, State is FULL, 6 state changes
    DR is 172.16.1.2 BDR is 172.16.1.1
    Options is 0x00
    Dead timer due in 00:00:36
    Neighbor is up for 00:02:23
    Index 2/2, retransmission queue length 0, number of retransmission 0
    First 0x0(0)/0x0(0) Next 0x0(0)/0x0(0)
    Last retransmission scan length is 0, maximum is 0
    Last retransmission scan time is 0 msec, maximum is 0 msec
```

#### Base de datos OSPF

```
Router-1# show ip ospf database
            OSPF Router with ID (172.31.255.2) (Process ID 1)

                Router Link States (Area 0)

Link ID         ADV Router      Age         Seq#       Checksum Link count
172.31.255.4    172.31.255.4    110         0x80000006 0x007d41 3
172.31.255.2    172.31.255.2    110         0x80000006 0x000a6f 3
172.31.255.3    172.31.255.3    110         0x80000006 0x00d985 3
172.31.255.1    172.31.255.1    110         0x80000006 0x009c90 3

                Net Link States (Area 0)
Link ID         ADV Router      Age         Seq#       Checksum
172.16.1.2      172.31.255.3    115         0x80000001 0x00e1eb
172.16.2.2      172.31.255.4    115         0x80000001 0x00e0e8
172.16.3.1      172.31.255.4    110         0x80000002 0x00d1f8
172.16.0.2      172.31.255.2    110         0x80000001 0x005ed3
```

--------------------------------------------------------------------------------

### Información de diagnóstico para `Router-2`

#### Tabla de rutas

```
Router-2# show ip route

Gateway of last resort is not set

     10.0.0.0/24 is subnetted, 2 subnets
O       10.10.10.0 [110/2] via 172.16.1.1, 00:10:38, GigabitEthernet1/0
C       10.20.20.0 is directly connected, GigabitEthernet2/0
     172.16.0.0/30 is subnetted, 4 subnets
O       172.16.0.0 [110/2] via 172.16.1.1, 00:10:38, GigabitEthernet1/0
C       172.16.1.0 is directly connected, GigabitEthernet1/0
C       172.16.2.0 is directly connected, GigabitEthernet0/0
O       172.16.3.0 [110/2] via 172.16.2.2, 00:10:38, GigabitEthernet0/0
     172.31.0.0/24 is subnetted, 1 subnets
C       172.31.255.0 is directly connected, Loopback0
O    192.168.0.0/24 [110/3] via 172.16.1.1, 00:10:28, GigabitEthernet1/0
                    [110/3] via 172.16.2.2, 00:10:28, GigabitEthernet0/0
O    192.168.100.0/24 [110/2] via 172.16.2.2, 00:10:38, GigabitEthernet0/0
```

##### Tabla de rutas obtenidas por OSPF

```
Router-2# show ip route ospf
     10.0.0.0/24 is subnetted, 2 subnets
O       10.10.10.0 [110/2] via 172.16.1.1, 00:10:43, GigabitEthernet1/0
     172.16.0.0/30 is subnetted, 4 subnets
O       172.16.0.0 [110/2] via 172.16.1.1, 00:10:43, GigabitEthernet1/0
O       172.16.3.0 [110/2] via 172.16.2.2, 00:10:43, GigabitEthernet0/0
O    192.168.0.0 [110/3] via 172.16.1.1, 00:10:33, GigabitEthernet1/0
                 [110/3] via 172.16.2.2, 00:10:33, GigabitEthernet0/0
O    192.168.100.0 [110/2] via 172.16.2.2, 00:10:43, GigabitEthernet0/0
```

#### Información de OSPF

```
Router-2# show ip ospf
 Routing Process "ospf 1" with ID 172.31.255.3
 Supports only single TOS(TOS0) routes
 Supports opaque LSA
 SPF schedule delay 5 secs, Hold time between two SPFs 10 secs
 Minimum LSA interval 5 secs. Minimum LSA arrival 1 secs
 Number of external LSA 0. Checksum Sum 0x000000
 Number of opaque AS LSA 0. Checksum Sum 0x000000
 Number of DCbitless external and opaque AS LSA 0
 Number of DoNotAge external and opaque AS LSA 0
 Number of areas in this router is 1. 1 normal 0 stub 0 nssa
 External flood list length 0
    Area BACKBONE(0)
        Number of interfaces in this area is 3
        Area has no authentication
        SPF algorithm executed 3 times
        Area ranges are
        Number of LSA 8. Checksum Sum 0x056de8
        Number of opaque link LSA 0. Checksum Sum 0x000000
        Number of DCbitless LSA 0
        Number of indication LSA 0
        Number of DoNotAge LSA 0
        Flood list length 0
```

#### Información detallada de interfaces con OSPF

```
Router-2# show ip ospf interface

GigabitEthernet2/0 is up, line protocol is up
  Internet address is 10.20.20.254/24, Area 0
  Process ID 1, Router ID 172.31.255.3, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State DR, Priority 1
  Designated Router (ID) 172.31.255.3, Interface address 10.20.20.254
  No backup designated router on this network
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:07
  Index 1/1, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 0, Adjacent neighbor count is 0
  Suppress hello for 0 neighbor(s)
GigabitEthernet1/0 is up, line protocol is up
  Internet address is 172.16.1.2/30, Area 0
  Process ID 1, Router ID 172.31.255.3, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State DR, Priority 1
  Designated Router (ID) 172.31.255.3, Interface address 172.16.1.2
  Backup Designated Router (ID) 172.31.255.2, Interface address 172.16.1.1
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:07
  Index 2/2, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 1, Adjacent neighbor count is 1
    Adjacent with neighbor 172.31.255.2  (Backup Designated Router)
  Suppress hello for 0 neighbor(s)
GigabitEthernet0/0 is up, line protocol is up
  Internet address is 172.16.2.1/30, Area 0
  Process ID 1, Router ID 172.31.255.3, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State BDR, Priority 1
  Designated Router (ID) 172.31.255.4, Interface address 172.16.2.2
  Backup Designated Router (ID) 172.31.255.3, Interface address 172.16.2.1
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:07
  Index 3/3, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 1, Adjacent neighbor count is 1
    Adjacent with neighbor 172.31.255.4  (Designated Router)
  Suppress hello for 0 neighbor(s)
```

#### Tabla de vecinos de OSPF

```
Router-2# show ip ospf neighbor


Neighbor ID     Pri   State           Dead Time   Address         Interface
172.31.255.4      1   FULL/DR         00:00:35    172.16.2.2      GigabitEthernet0/0
172.31.255.2      1   FULL/BDR        00:00:35    172.16.1.1      GigabitEthernet1/0
```

#### Detalle de vecinos OSPF

```
Router-2# show ip ospf neighbor detail
 Neighbor 172.31.255.4, interface address 172.16.2.2
    In the area 0 via interface GigabitEthernet0/0
    Neighbor priority is 1, State is FULL, 5 state changes
    DR is 172.16.2.2 BDR is 172.16.2.1
    Options is 0x00
    Dead timer due in 00:00:39
    Neighbor is up for 00:12:08
    Index 1/1, retransmission queue length 0, number of retransmission 0
    First 0x0(0)/0x0(0) Next 0x0(0)/0x0(0)
    Last retransmission scan length is 0, maximum is 0
    Last retransmission scan time is 0 msec, maximum is 0 msec
 Neighbor 172.31.255.2, interface address 172.16.1.1
    In the area 0 via interface GigabitEthernet1/0
    Neighbor priority is 1, State is FULL, 6 state changes
    DR is 172.16.1.2 BDR is 172.16.1.1
    Options is 0x00
    Dead timer due in 00:00:39
    Neighbor is up for 00:12:08
    Index 2/2, retransmission queue length 0, number of retransmission 0
    First 0x0(0)/0x0(0) Next 0x0(0)/0x0(0)
    Last retransmission scan length is 0, maximum is 0
    Last retransmission scan time is 0 msec, maximum is 0 msec
```

#### Base de datos OSPF

```
Router-2# show ip ospf database
            OSPF Router with ID (172.31.255.3) (Process ID 1)

                Router Link States (Area 0)

Link ID         ADV Router      Age         Seq#       Checksum Link count
172.31.255.2    172.31.255.2    588         0x80000005 0x007802 3
172.31.255.3    172.31.255.3    588         0x80000005 0x0087d8 3
172.31.255.4    172.31.255.4    588         0x80000006 0x00dde0 3
172.31.255.1    172.31.255.1    588         0x80000006 0x009c90 3

                Net Link States (Area 0)
Link ID         ADV Router      Age         Seq#       Checksum
172.16.1.2      172.31.255.3    593         0x80000001 0x00e1eb
172.16.0.2      172.31.255.2    588         0x80000001 0x005ed3
172.16.3.1      172.31.255.4    588         0x80000001 0x00d3f7
172.16.2.2      172.31.255.4    588         0x80000002 0x00dee9
```

--------------------------------------------------------------------------------

### Información de diagnóstico para `Router-3`

#### Tabla de rutas

```
Router-3# show ip route

Gateway of last resort is not set

     10.0.0.0/24 is subnetted, 2 subnets
O       10.10.10.0 [110/3] via 172.16.3.2, 00:12:09, GigabitEthernet0/0
                   [110/3] via 172.16.2.1, 00:12:09, GigabitEthernet1/0
O       10.20.20.0 [110/2] via 172.16.2.1, 00:12:09, GigabitEthernet1/0
     172.16.0.0/30 is subnetted, 4 subnets
O       172.16.0.0 [110/2] via 172.16.3.2, 00:12:09, GigabitEthernet0/0
O       172.16.1.0 [110/2] via 172.16.2.1, 00:12:09, GigabitEthernet1/0
C       172.16.2.0 is directly connected, GigabitEthernet1/0
C       172.16.3.0 is directly connected, GigabitEthernet0/0
     172.31.0.0/24 is subnetted, 1 subnets
C       172.31.255.0 is directly connected, Loopback0
O    192.168.0.0/24 [110/2] via 172.16.3.2, 00:12:09, GigabitEthernet0/0
C    192.168.100.0/24 is directly connected, GigabitEthernet2/0
```

##### Tabla de rutas obtenidas por OSPF

```
Router-3# show ip route ospf
     10.0.0.0/24 is subnetted, 2 subnets
O       10.10.10.0 [110/3] via 172.16.3.2, 00:12:22, GigabitEthernet0/0
                   [110/3] via 172.16.2.1, 00:12:22, GigabitEthernet1/0
O       10.20.20.0 [110/2] via 172.16.2.1, 00:12:22, GigabitEthernet1/0
     172.16.0.0/30 is subnetted, 4 subnets
O       172.16.0.0 [110/2] via 172.16.3.2, 00:12:22, GigabitEthernet0/0
O       172.16.1.0 [110/2] via 172.16.2.1, 00:12:22, GigabitEthernet1/0
O    192.168.0.0 [110/2] via 172.16.3.2, 00:12:22, GigabitEthernet0/0
```

#### Información de OSPF

```
outer-3# show ip ospf
 Routing Process "ospf 1" with ID 172.31.255.4
 Supports only single TOS(TOS0) routes
 Supports opaque LSA
 SPF schedule delay 5 secs, Hold time between two SPFs 10 secs
 Minimum LSA interval 5 secs. Minimum LSA arrival 1 secs
 Number of external LSA 0. Checksum Sum 0x000000
 Number of opaque AS LSA 0. Checksum Sum 0x000000
 Number of DCbitless external and opaque AS LSA 0
 Number of DoNotAge external and opaque AS LSA 0
 Number of areas in this router is 1. 1 normal 0 stub 0 nssa
 External flood list length 0
    Area BACKBONE(0)
        Number of interfaces in this area is 3
        Area has no authentication
        SPF algorithm executed 6 times
        Area ranges are
        Number of LSA 8. Checksum Sum 0x04d173
        Number of opaque link LSA 0. Checksum Sum 0x000000
        Number of DCbitless LSA 0
        Number of indication LSA 0
        Number of DoNotAge LSA 0
        Flood list length 0
```

#### Información detallada de interfaces con OSPF

```
Router-3# show ip ospf interface

GigabitEthernet0/0 is up, line protocol is up
  Internet address is 172.16.3.1/30, Area 0
  Process ID 1, Router ID 172.31.255.4, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State DR, Priority 1
  Designated Router (ID) 172.31.255.4, Interface address 172.16.3.1
  Backup Designated Router (ID) 172.31.255.1, Interface address 172.16.3.2
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:09
  Index 1/1, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 1, Adjacent neighbor count is 1
    Adjacent with neighbor 172.31.255.1  (Backup Designated Router)
  Suppress hello for 0 neighbor(s)
GigabitEthernet2/0 is up, line protocol is up
  Internet address is 192.168.100.254/24, Area 0
  Process ID 1, Router ID 172.31.255.4, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State DR, Priority 1
  Designated Router (ID) 172.31.255.4, Interface address 192.168.100.254
  No backup designated router on this network
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:09
  Index 2/2, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 0, Adjacent neighbor count is 0
  Suppress hello for 0 neighbor(s)
GigabitEthernet1/0 is up, line protocol is up
  Internet address is 172.16.2.2/30, Area 0
  Process ID 1, Router ID 172.31.255.4, Network Type BROADCAST, Cost: 1
  Transmit Delay is 1 sec, State DR, Priority 1
  Designated Router (ID) 172.31.255.4, Interface address 172.16.2.2
  Backup Designated Router (ID) 172.31.255.3, Interface address 172.16.2.1
  Timer intervals configured, Hello 10, Dead 40, Wait 40, Retransmit 5
    Hello due in 00:00:09
  Index 3/3, flood queue length 0
  Next 0x0(0)/0x0(0)
  Last flood scan length is 1, maximum is 1
  Last flood scan time is 0 msec, maximum is 0 msec
  Neighbor Count is 1, Adjacent neighbor count is 1
    Adjacent with neighbor 172.31.255.3  (Backup Designated Router)
  Suppress hello for 0 neighbor(s)
```

#### Tabla de vecinos de OSPF

```
Router-3# show ip ospf neighbor 


Neighbor ID     Pri   State           Dead Time   Address         Interface
172.31.255.3      1   FULL/BDR        00:00:30    172.16.2.1      GigabitEthernet1/0
172.31.255.1      1   FULL/BDR        00:00:30    172.16.3.2      GigabitEthernet0/0
```

#### Detalle de vecinos OSPF

```
Router-3# show ip ospf neighbor detail 
 Neighbor 172.31.255.3, interface address 172.16.2.1
    In the area 0 via interface GigabitEthernet1/0
    Neighbor priority is 1, State is FULL, 5 state changes
    DR is 172.16.2.2 BDR is 172.16.2.1
    Options is 0x00
    Dead timer due in 00:00:34
    Neighbor is up for 00:13:33
    Index 1/1, retransmission queue length 0, number of retransmission 0
    First 0x0(0)/0x0(0) Next 0x0(0)/0x0(0)
    Last retransmission scan length is 0, maximum is 1
    Last retransmission scan time is 0 msec, maximum is 0 msec
 Neighbor 172.31.255.1, interface address 172.16.3.2
    In the area 0 via interface GigabitEthernet0/0
    Neighbor priority is 1, State is FULL, 6 state changes
    DR is 172.16.3.1 BDR is 172.16.3.2
    Options is 0x00
    Dead timer due in 00:00:34
    Neighbor is up for 00:13:33
    Index 2/2, retransmission queue length 0, number of retransmission 0
    First 0x0(0)/0x0(0) Next 0x0(0)/0x0(0)
    Last retransmission scan length is 0, maximum is 0
    Last retransmission scan time is 0 msec, maximum is 0 msec
```

#### Base de datos OSPF

```
Router-3# show ip ospf database
            OSPF Router with ID (172.31.255.4) (Process ID 1)

                Router Link States (Area 0)

Link ID         ADV Router      Age         Seq#       Checksum Link count
172.31.255.2    172.31.255.2    661         0x80000005 0x007802 3
172.31.255.1    172.31.255.1    661         0x80000006 0x009c90 3
172.31.255.4    172.31.255.4    661         0x80000006 0x00dde0 3
172.31.255.3    172.31.255.3    661         0x80000005 0x0087d8 3

                Net Link States (Area 0)
Link ID         ADV Router      Age         Seq#       Checksum
172.16.1.2      172.31.255.3    666         0x80000001 0x00e1eb
172.16.0.2      172.31.255.2    661         0x80000001 0x005ed3
172.16.3.1      172.31.255.4    661         0x80000001 0x00d3f7
172.16.2.2      172.31.255.4    661         0x80000002 0x00dee9
```

--------------------------------------------------------------------------------

# Referencias

+ <https://www.cisco.com/c/en/us/td/docs/ios/>
+ <https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/iproute_ospf/command/iro-cr-book/ospf-s1.html>
+ <https://www.computernetworkingnotes.com/ccna-study-guide/ospf-fundamental-terminology-explained.html>
+ <https://www.computernetworkingnotes.com/ccna-study-guide/ospf-neighborship-condition-and-requirement.html>
+ <https://www.computernetworkingnotes.com/ccna-study-guide/ospf-neighbor-states-explained-with-example.html>
+ <https://www.computernetworkingnotes.com/ccna-study-guide/ospf-configuration-step-by-step-guide.html>
+ <https://www.computernetworkingnotes.com/ccna-study-guide/ospf-metric-cost-calculation-formula-explained.html>

