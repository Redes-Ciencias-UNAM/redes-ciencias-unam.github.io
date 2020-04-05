# Ruteo estático

## Topología de red

La configuración del ruteo se realizará utilizando la siguiente topología:

|    |
|:--:|
|![](../img/routing-topology.png)|
|Topología para protocolos de ruteo internos|
|[Archivo de Packet Tracer con la topología de red](../files/routing-topology.pkt)|

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

