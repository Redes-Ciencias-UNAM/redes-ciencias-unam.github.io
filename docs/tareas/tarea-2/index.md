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

- La fecha límite de entrega es el **lunes 07 de marzo de 2022** a las 23:59 horas
- Esta actividad debe ser entregada de manera **individual** de acuerdo al [flujo de trabajo para la entrega de tareas y prácticas][flujo-de-trabajo]
    - Crear una rama llamada `tarea-2` para entregar la práctica
    - Crear un _merge request_ en el [repositorio de tareas][repo-tareas] para entregar la actividad

## Procedimiento

- Crear una cuenta en NetAcad.com o SkillsForAll.com
    - <https://www.netacad.com/>
    - <https://skillsforall.com/>

- Termina el curso **Getting Started with Cisco Packet Tracer**
    - <https://skillsforall.com/course/getting-started-cisco-packet-tracer>

- Instala Packet Tracer en tu **máquina física**
    - Las instrucciones para esta tarea [están documentadas en una página separada][packet-tracer-install].

- Crea una topología de red simple para una red casera
    - Elabora un plano de cómo es la distribución aproximada de las habitaciones

- Explica la topología en el archivo `README.md`
    - Agrega las imágenes que sean necesarias

- Verifica la conectividad de los equipos

- Anexa el archivo PKT resultante en la carpeta `files`

## Entregables

- Archivo `README.md`

    - Explicación de la topología de red utilizada.
    
        - Simular la salida a Internet utilizando un modem conectado a `Cloud-PT`
        - Utilizar los equipos de red de tipo "Packet Tracer" (`Bridge-PT`, `Switch-PT`, `Router-PT`, `AccessPoint-PT`, etc.)
        - Utilizar PC, laptops, TV, SmartPhone, Tablet e impresoras como clientes
            - Dar de alta por lo menos 4 clientes
            - Utilizar conexiones Ethernet para conectar los clientes al switch
            - Asignar direcciones IP estáticas del segmento `192.168.X.0/24`

    - Listar las imágenes con su respectiva descripción

- Carpeta `img`

    - Ventana "acerca de" Packet Tracer ejecutándose en la **máquina física**
    
    - Imagen de la topología de red implementada
    
    - Imagen de la configuración de red para todos los equipos
    
    - Imagen de las pruebas de conectividad entre los equipos

- Carpeta `files`

    - Archivo de la actividad en formato `PKT` (Packet Tracer)

--------------------------------------------------------------------------------

[flujo-de-trabajo]: https://redes-ciencias-unam.gitlab.io/2022-2/tareas-redes/workflow/
[repo-tareas]: https://gitlab.com/Redes-Ciencias-UNAM/2022-2/tareas-redes/-/merge_requests

[video-instalacion-packet-tracer]: https://www.youtube.com/watch?v=TDqqwliOBnA&list=PLN1TFzSBXi3QWbHwBEV3p4LxV5KceXu8d&index=19
[video-packet-tracer]: https://www.youtube.com/watch?v=zixHIQvI79k&list=PLN1TFzSBXi3QWbHwBEV3p4LxV5KceXu8d&index=20

[packet-tracer-install]: ./install
