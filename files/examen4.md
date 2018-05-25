# Redes de Computadoras
# Tarea examen

## Descripción

El presente trabajo corresponde al cuarto examen de la materia de Redes de Computadoras, del semestre 2018-2

+ El trabajo se debe realizar en equipo, con un máximo de 4 integrantes.
+ La fecha límite de entrega es el día martes 5 de junio, personalmente en el aula de clases. Es necesario que se presenten todos los integrantes del equipo.
+ Esta tarea-examen no sustituye otros trabajos no entregados durante el semestre.

![Escenario para el examen 4](/img/examen4.png)

## Lineamientos

Con base en el escenario mostrado en la imagen anexa, mostrar en un diagrama de red los paquetes generados en una conexión de HTTP entre dos equipos remotos ubicados en redes Ethernet, los cuales hacen uso de IPv4. Para la realización del trabajo se debe considerar lo siguiente:

+ Se deben incluir las configuraciones de red de los clientes, servidores y todos los equipos de red, así como una lista de las direcciones MAC, IP y el equipo al que corresponden.
+ También se debe verificar que no existan direcciones MAC inválidas o repetidas en los equipos pertenecientes al escenario.
+ Incluir una descripción detallada del procedimiento seguido por el cliente para obtener los datos necesarios para realizar la conexión con el servidor, a partir de la URL recibida, así como para manejar las direcciones lógicas y físicas, incluyendo los servicios de red involucrados.
+ Se deben mostrar los paquetes generados para los siguientes protocolos y servicios: **HTTP**, **DNS**, **DHCP**, **TCP**, **ICMP**, **IP**, **ARP** y **Ethernet**.
+ Mostrar la forma en la que se calculan y comprueban las sumas de verificación (_checksums_) de los paquetes generados.

### Detalles sobre el escenario

+ Las redes que se manejarán son las siguientes. Cada equipo debe elegir diferentes redes de acuerdo a las restricciones presentadas en la imagen reemplazando el octeto representado por `A`, `B`, `C`, `X`, `Y`, `Z` según se elija.

| Red | Segmento         |
|:---:|:----------------:|
| `α` | 192.168.`X`.0/24 |
| `β` | 192.168.`Y`.0/24 |
| `γ` | 172.16.`Z`.0/24  |
| `χ` | 10.`A`.1.0/30    |
| `ψ` | 10.`B`.2.0/30    |
| `ω` | 10.`C`.3.0/30    |

+ Todas las interfaces de red deben ser del tipo _FastEthernet_ o _GigabitEthernet_. Elegir un tipo y utilizarlo en todos los equipos de red, clientes y servidores.
+ No se utilizarán interfaces de _fibra_ o conexiones _seriales_ para switches o ruteadores.
+ En la imágen vienen indicadas las interfaces que deben conectarse en los switches y ruteadores. Esta conexión debe establecerse con cable UTP _normal_ o _cruzado_ según sea el caso.
+ Verificar que la conexión entre los equipos aparezca de color verde en ambos lados, esto significa que se realizó bien el enlace a nivel físico.
+ Los clientes de la red `α` deben obtener su dirección IP por medio del servicio **DHCP** que provee el **Servidor2**.
+ Las impresoras de la red `β` y los servidores alojados en la red `γ` tendrán asignada la dirección IP de manera estática.
+ Las redes `χ`, `ψ` y `ω` tienen una máscara de red **/30**, observar esta característica al asignar las direcciones en las interfaces de red de los ruteadores.
+ El **Servidor1** implementará el servicio de **HTTP** y deberá entregar una página HTML sencilla donde vengan los nombres de los integrantes del equipo.
+ El **Servidor0** brinda el servicio de **DNS** y deberá contener registros para todos los equipos que conforman el escenario (servidores, clientes, impresoras, switches y ruteadores). El nombre de dominio queda a la elección del equipo, siempre y cuando sea parte del TLD genérico .local.

## Extra

+ Habilitar el servicio de **DHCP** en el **Router1** y **Router2**, de tal manera que se pueda eliminar el Servidor2 y que los clientes e impresoras obtengan su dirección por medio de DHCP. Documentar la configuración realizada e incluir la configuración necesaria en los equipos.
+ Instalar un servidor **TFTP** y copiar en él las configuraciones de todos los equipos de red (switches y ruteadores) incluyendo el nombre del dispositivo para diferenciarlos (**Switch1.cfg**, **Router2.cfg**, etc.).

