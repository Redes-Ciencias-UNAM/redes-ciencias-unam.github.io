---
title: Práctica 4 - Configuración de routers
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Práctica 4: Configuración de _routers_

--------------------------------------------------------------------------------

## Objetivo

El alumno creará un escenario de red y configurará rutas estáticas para simular la interacción entre varias redes.

## Elementos de apoyo

- [Video de la creación de una red en Packet Tracer 📼][video-packet-tracer]
- [Configuración de ruteo estático 📝][ruteo-estatico]
- [Prácticas de Packet Tracer 📖][practicas-cisco]
    - **Lab 4-5**: _Performing Initial Router Startup_ (_p19_)
    - **Lab 4-6**: _Performing Initial Router Configuration_ (_p22_)
    - **Lab 4-7**: _Enhancing the Security of Initial Router Configuration_ (_p24_)

## Restricciones

- La fecha límite de entrega es el **lunes 16 de mayo de 2022** a las 23:59 horas
- Esta actividad debe ser entregada **en equipo** de acuerdo al [flujo de trabajo para la entrega de tareas y prácticas][flujo-de-trabajo]
    - Utilizar la carpeta `docs/practicas/practica-4/Equipo-ABCD-EFGH-IJKL-MNOP` para entregar la práctica
        - Donde `Equipo-ABCD-EFGH-IJKL-MNOP` representa el nombre del equipo que debió anotarse previamente en la [lista del grupo][lista-redes]
    - Hacer un _merge request_ a la rama `practica-4` del [repositorio de tareas][repo-tareas] para entregar la actividad

## Procedimiento

- Crea un escenario donde se conecten varias redes de distintas dependencias de la UNAM
- Conecta 3 o más routers para simular varias dependencias universitarias
- Utiliza una topología para conectar las distintas redes y justifica por qué la implementaste
- **Establece rutas estáticas entre los ruteadores de cada red**
- Utiliza interfaces **GigabitEthernet** para las redes **WAN** (<span style="color: red; font-weight: bold;">rojo</span>)
- Utiliza interfaces **FastEthernet** para las redes **LAN** (<span style="color: black; font-weight: bold;">negro</span>)

- Configura una contraseña para entrar al modo privilegiado `exec`
- Configura la administración por SSH en cada switch
- Deshabilita telnet y la consola web

- Utiliza los segmentos de red [**TEST-NET**][ipv4-reserved-addresses] para las redes **WAN**: `192.0.2.0/24`, `198.51.100.0/24` o `203.0.113.0/24`
    - Utiliza conexiones punto a punto con máscara de red `/30` o `/31` entre los ruteadores

- Configura direcciones IP estáticas para la red **LAN**

- Configura **rutas estáticas** para interconectar las redes **WAN**

- Conecta un switch y una laptop en la red **LAN**, utiliza el direccionamiento `192.168.X.0/24`

- Configura los switches de la red **LAN**
    - Interfaces de red
    - Dirección IP de administración (estática)
    - Establece el gateway con la dirección IP del ruteador para ese segmento de red
<!--
    - Utiliza la vLAN predeterminada (vLAN 1) para conectar a todos los equipos de las redes **LAN** y **WAN**
-->

<!-- -->
<a id="diagrama" name="diagrama"></a>

| Diagrama de red en Packet Tracer |
|:-----------------------------:|
| ![](img/diagrama_red.png)
| Redes: <span style="color: red; font-weight: bold;">WAN: rojo</span> , <span style="color: black; font-weight: bold;">LAN: negro</span>
| Conecta <u>3 o más redes</u> para simular varias dependencias universitarias
| Las <span style="color: red; font-weight: bold;">líneas rojas</span> dependen de la topología que elija el equipo para interconectar los routers
<!-- -->

!!! note
    No se contempla el uso de vLAN `802.1q` ni vLAN anidadas `802.1ad` (_Q-in-Q_) por lo que no se deben de configurar puertos troncales (trunk)

## Entregables

- Archivo `README.md`
    - Tabla donde se listen los equipos, nombre de host, dirección IP de administración y la conexión con otros switches y ruteadores
    - Listar las imágenes con su respectiva descripción
    - Crear ligas hacia los archivos en la carpeta `files` cuando sean mencionados
    - Salida de las pruebas de conectividad entre los equipos **en texto**
    - Explicación de la topología de red utilizada.
        - La simulación de la red **LAN** es una versión simplificada de la red interna de una dependencia universitaria para fines ilustrativos

- Carpeta `img`
    - Imagen de la topología de red implementada
    - Demás imágenes que se consideren necesarias para el reporte

- Carpeta `files`
    - Archivo de la actividad en formato `PKT` (Packet Tracer)
    - Configuración de cada switch y ruteador
        - Hacer que la configuración sea persistente con el comando
            - `copy  running-config  startup-config`
        - Guardar la salida del comando `show startup-config` a un archivo de texto (ej. `Router-1.txt` o `Switch-LAN-1.txt`)
        - Repetir para cada equipo de red

## Extra

- Habilita el servicio de DHCP en el ruteador para la red **LAN**
- Configura el servicio de NAT en el ruteador para la red **LAN**

- Elabora un video donde expliquen qué edificio se eligió, la topología de red utilizada y las pruebas de conectividad.

    - Subir el video a YouTube
    - Agregar la referencia de este video al archivo `README.md`

```text
- [Video de la topología de red utilizada 📼](https://youtu.be/0123456789ABCDEF)
```

--------------------------------------------------------------------------------

[flujo-de-trabajo]: https://redes-ciencias-unam.gitlab.io/2022-2/tareas-redes/workflow/
[repo-tareas]: https://gitlab.com/Redes-Ciencias-UNAM/2022-2/tareas-redes/-/merge_requests

[lista-redes]: https://tinyurl.com/Lista-Redes-2022-2

[video-packet-tracer]: https://www.youtube.com/watch?v=zixHIQvI79k&list=PLN1TFzSBXi3QWbHwBEV3p4LxV5KceXu8d&index=19
[packet-tracer-install]: ./install

[practicas-cisco]: https://tinyurl.com/Redes-FC-UNAM-Practicas-Cisco
[instaladores-packet-tracer]: https://tinyurl.com/Redes-FC-UNAM-Cisco-PT

[ruteo-estatico]: ../../temas/routing-static

[ipv4-reserved-addresses]: https://en.wikipedia.org/wiki/Reserved_IP_addresses
