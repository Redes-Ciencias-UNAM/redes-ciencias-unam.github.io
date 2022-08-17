---
# https://www.mkdocs.org/user-guide/writing-your-docs/#meta-data
title: Tarea 2 - Instalación de Cisco Packet Tracer
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Tarea 2: Instalación de Cisco Packet Tracer

--------------------------------------------------------------------------------

## Objetivo

- El alumno instalará la herramienta Packet Tracer de Cisco para simular los dispositivos que forman parte de una red.

## Elementos de apoyo

- [Video de la instalación de Packet Tracer en Ubuntu 📼][video-instalacion-packet-tracer]
- [Video de la creación de una red en Packet Tracer 📼][video-packet-tracer]

## Restricciones

- Esta tarea debe ser entregada de manera **individual**

- La fecha límite de entrega es el **miércoles 24 de agosto de 2022** a las 23:59 horas

!!! warning
    - Se entregará la evidencia de esta actividad junto con la [tarea-3](../tarea-3/) en una fecha posterior

## Procedimiento

- Crear una cuenta en el sitio **Skills for All**
    - <https://skillsforall.com/>

- Termina el curso **Getting Started with Cisco Packet Tracer**
    - <https://skillsforall.com/course/getting-started-cisco-packet-tracer>

- Instala Packet Tracer en tu **máquina física**
    - Las instrucciones para esta tarea [están documentadas en una página separada][packet-tracer-install].

- Crea una topología de red simple para una red casera
    - Elabora un "plano" de cómo es la distribución aproximada de las habitaciones
    - No es necesario que pongas fotos de tu casa, únicamente que delimites los espacios

- Explica la topología en el archivo `README.md`
    - Agrega las imágenes que sean necesarias

- Verifica la conectividad de los equipos

- Anexa el archivo PKT resultante en la carpeta `files`

## Entregables

!!! warning
    - Se entregará la evidencia de esta actividad junto con la [tarea-3](../tarea-3/) en una fecha posterior

- Archivo `README.md`

    - Explicación de la topología de red utilizada.
    
        - Simular la salida a Internet utilizando un modem conectado a `Cloud-PT`
        - Utilizar los equipos de red de tipo "Packet Tracer"
            - `Bridge-PT`, `Switch-PT`, `Router-PT`, `AccessPoint-PT`, etc.
        - Utilizar PC, laptops, TV, SmartPhone, Tablet e impresoras como clientes
            - Dar de alta por lo menos 4 clientes
            - Utilizar conexiones Ethernet para conectar los clientes al switch
            - Utilizar un AP y conectar los clientes inalámbricos a el
            - Asignar direcciones IP estáticas del segmento `192.168.X.0/24`

    - Listar las imágenes con su respectiva descripción

- Carpeta `img`

    - Imagen donde se muestre que completaste el curso de **Getting Started with Cisco Packet Tracer** en **Skills for All**

    - Ventana "acerca de" Packet Tracer ejecutándose en la **máquina física**
    
    - Imagen del plano de la distribución física de la red casera

    - Imagen de la topología de red implementada en Packet Tracer
    
    - Imagen de la configuración de red para todos los equipos
    
    - Imagen de las pruebas de conectividad entre los equipos

- Carpeta `files`

    - Archivo de la actividad en formato `PKT` (Packet Tracer)

## Extra

- Incluir un equipo servidor en tu topología de red y activar el servicio de DHCP
    - Listar en el `README.md` los pasos que tuviste que seguir para realizar esta configuración
    - Incluir imagenes donde se muestre el proceso de configuración

--------------------------------------------------------------------------------

[flujo-de-trabajo]: https://redes-ciencias-unam.gitlab.io/2022-2/tareas-redes/workflow/
[repo-tareas]: https://gitlab.com/Redes-Ciencias-UNAM/2022-2/tareas-redes/-/merge_requests

[video-instalacion-packet-tracer]: https://www.youtube.com/watch?v=TQYe7Rp13xw&list=PLN1TFzSBXi3QWbHwBEV3p4LxV5KceXu8d&index=19
[video-packet-tracer]: https://www.youtube.com/watch?v=yfEIis_3MZk&list=PLN1TFzSBXi3QWbHwBEV3p4LxV5KceXu8d&index=20

[packet-tracer-install]: ./install
