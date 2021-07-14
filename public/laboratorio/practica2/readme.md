![UNAM](images/img_logoFC_2019.png)

# Redes de Computadoras

## Configuración de servicios *DHCP*, *NAT* y *DNS* con Virtualbox

Se presentan los pasos para elaborar la configuración de un *NAT*, *DHCP* y *DNS local* utilizando VirtualBox con base en la topología de red que se muestra a continuación:

![Diagrama de red](images/diagrama_red.png "Diagrama de Red")

Esta practica guiada esta basada en el video de la clase que se muestra a continuación. La configuración de VirtualBox está explicada en la primer parte del video.

- [Configuración de NAT, DHCP y Forwarder de DNS en GNU/Linux 📼](https://www.youtube.com/watch?v=BzL3MQkHjwg)
- [Configuración persistente de direcciones IP en GNU/Linux 📼](https://www.youtube.com/watch?v=UErZ4i9XmLM)
- [Protocolo DHCP 📼](https://www.youtube.com/watch?v=6l4WQJfD7o0)
- [Protocolo DNS 📼](https://www.youtube.com/watch?v=r4PntflJs9E&t=51s)


### Objetivos
-------------

* El alumno aplicará los conceptos teóricos de un NAT y DHCP en una topología de red básica
* El alumno configurará un NAT por medio de maquinas virtuales
* El alumno configurará un DHCP con maquinas virtuales
* El alumno montará un servidor *DNS* local

### Creación del *NAT* con `iptables`
-----------------------------------

**Configuración en VirtualBox**

Deshabilitar el servicio de DHCP en la interfaz host only.

- Abrir VirtualBox y dar clic en el menú de herramientas
- Aparecerá la lista de interfaces host-only dar clic en la primera
- Ir a la pestaña del servidor de DHCP y desmarcar la casilla para deshabilitarlo
- Dar clic en aplicar cambios

![VirtualBox host-only DHCP](images/vbox-hostonly-dhcp.png)

**En la máquina Debian 10**

0. Configurar una dirección IP estática en la interfaz host-only `192.168.56.254`.

1. Revisar que no haya reglas existentes en `iptables`:

```shell
# iptables -n -L
```

2. Cambiar la dirección ip para la red *host-only* (Debe ser una ip fija). Editar el archivo `/etc/network/interfaces`
3. Habilitar de manera persistente la funcionalidad de *IP forward* en el kernel para que no se descarten paquetes que no sean destinados a otra máquina:
    * Editar el archivo `/etc/sysctl.conf` y descomentar la linea 
```
net.ipv4.ip_forward = 1
```
    * Recargar la configuración de `sysctl`

```shell
# sysctl -p
```

4. Habilitar la regla en la tabla de NAT de `iptables` 

```shell
# iptables -t nat -A POSTROUTING -o eth1  -j MASQUARADE
```

5. Indicar a `iptables` que se el tráfico puede entrada por *host-only* (`eth0`) y salir por la NAT (`eth1`) y viceversa:

```shell
# iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT
# iptables -A FORWARD -i eth1 -o eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
```

### Configuración del *DHCP*
------------------------------------------------------------------

**En la maquina Debian 10**

1. Actualizar la lista de repositorios

```shell
# apt -q update
```

2. Instalar el programa para configurar DHCP

```shell
# apt -qy install isc-dhcp-server
```

3. Configurar el DHCP en el archivo `/etc/dhcp/dhcpd.conf`. Buscar y sustituir las líneas por defecto con la siguiente información.  **Nota:** Hacer una copia del archivo antes de modificarlo

```bash
option  domain-name  "ciencias.local"
option  domain-name-serves  1.1.1.1 , 8.8.8.8 , 9.9.9.9;

# No se dará servicio en la red externa (NAT de VirtualBox)
subnet 10.0.2.0 netmask 255.255.255.0 {
}

# Rango de direcciones a asignar
subnet  192.168.56.0  netmask  255.255.255.0 {
    range  192.168.56.100  192.168.56.200;
    option  routers  192.168.56.254;
}
```

4. Especificar la interface (*host-only* -> `eth0`) por donde escuchará el DHCP en el archivo `/etc/default/isc-dhcp-server`:

```bash
INTERFACESv4="eth0"
```

5. Reiniciar y revisar que el status del servicio de *DHCP* este corriendo

```shell
# service isc-dhcp-server restart
# systemctl status isc-dhcp-server
```

**En la maquina CentOS**

6. Reiniciar la interface de red para que se le asigne una nueva dirección IP

```shell
# ifdown eth0
# ifup eth0
```

#### **Actividad**

* Configurar una dirección estatica con el DHCP para la máquina CentOS 7
* Anexa en el cuestionario como se asigna la IP estática

### Configuración del _forwarder_ de *DNS*
------------------------------------------------------------------

**En la máquina Debian 10**

1. Instalar el programa `dnsmasq`.

```shell
# apt -qy install dnsmasq
```

2. Modificar las siguientes líneas en el archivo `/etc/dnsmasq.conf` para configurar el programa.

```
# Archivo que contiene las reglas para resolver dns. El archivo puede tener cualquier nombre.
resolv-file=/etc/resolv-upstream.conf

# Redirección
address=/gateway.local/192.168.56.254
address=/dns.local/192.168.56.254

# Especificar la red por donde escuchará. Al ser un dns local será la interfaz interna
interface=eth0
bind-interfaces
```

El parámetro `address` se utiliza para asociar una dirección IP con un nombre DNS arbitrario.

3. Crear el archivo `/etc/resolv-upstream.conf` con las reglas de resolución de dominios 

```bash
nameserver	1.1.1.1
nameserver	8.8.8.8
nameserver	9.9.9.9
```

4. Indicar el nuevo *DNS* en la configuración del *DHCP* `/etc/dhcp/dhcpd.conf` 

```bash
option  domain-name-servers  192.168.56.254;
```

3. Reiniciar servicios

```shell
# service dnsmasq restart
# service isc-dhcp-server restart
```

**En la máquina Debian 10**

1. Una vez verifico el correcto funcionamiento del *DNS* local modificar el archivo `/etc/resolv.conf`

```bash
# Envía la consultas de DNS a dnsmasq local
nameserver  127.0.0.1
```

**En la máquina CentOS 7**

1. Reiniciar la interface de red para obtener los nuevos parámetros de red

```shell
# ifdown eth0
# ifup eth0
```

2. Verificar los nuevos parámetros de red.
**Anexa la salida de todos estos comandos en tu reporte**.

  - Configuración de red

```
$ ifconfig -a

$ route -n

$ cat /etc/resolv.conf
```

  - Conectividad local

```
$ ping -c 4 192.168.56.254

$ ping -c 4 gateway.local

$ ping -c 4 dns.local
```

  - Resolución de DNS

```
$ dig example.com. @192.168.56.254

$ dig example.com. @dns.local

$ dig example.com.
```

  - Conectividad externa

```
$ ping -c 4 1.1.1.1

$ ping -c 4 example.com.
```

### Cuestionario
----------------

1. Explica que significa la salida de los siguientes comandos:

```shell
# iptables-save
# iptables -n -L
```

2. Adjunta dos capturas de tráfico realizadas en la máquina Debian:

  - Tráfico de DHCP en la interfaz host-only `eth0`

```
# tcpdump -veni eth0 -o captura-dhcp.pcap 'port (67 or 68)'
```

  - Tráfico DNS en todas las interfaces de red.

```
# tcpdump -veni any -o captura-dns.pcap 'port 53'
```

3. Explica por que estas capturas se deben hacer en la máquina Debian que funge como servidor DHCP, NAT y DNS local y no en alguno de los clientes.

4. Muestra claramente como la máquina CentOS 7 llega a Internet gracias al NAT

5. ¿Cuál es la utilidad del *DHCP* en esta topología de red? ¿Qué utilidad tendría en topologías mas grandes?

6. Investiga qué es un **relay de *DHCP*** y para qué sirve

7. Muestra claramente como es que el *DHCP* asigna las direcciones IP automaticamente

8. Explica el contenido del archivo `/var/lib/dhcp/dhcp.leases`

9. ¿Cuál es la utilidad del *DNS* local para esta topología de red?

10. Muestra claramente las interfaces en las que se está dando servicios de *DNS* 

11. Muestra claramente que este funcionando correctamente el *DNS* local indicando en que momento se utiliza el cache

12. Analiza la nota [*DHCP snooping: más seguridad para tu red*](https://www.ionos.mx/digitalguide/servidores/seguridad/dhcp-snooping/) y escribe un comentario al respecto.

### Notas adicionales
---------------------

-   Redacten un reporte por equipo, en el que consignes los
    pasos que consideres necesarios para explicar cómo realizaron la
    práctica. Incluyan capturas de pantalla que justifiquen su trabajo.

-   Incluyan en su reporte tanto las respuestas del Cuestionario, como un
    apartado de conclusiones referentes al trabajo realizado.

-   Pueden agregar posibles errores, complicaciones, opiniones, críticas
    de la práctica o del laboratorio, o cualquier comentario relativo a
    la misma.

-   Entreguen su reporte de acuerdo a la forma de entrega de tareas y
    prácticas definida al inicio del curso,
    <https://redes-ciencias-unam.gitlab.io/2021-2/tareas-redes/workflow/>.
