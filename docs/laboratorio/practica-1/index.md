---
title: Práctica 1 - Configuración de switches administrables
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Práctica 1: Configuración de switches administrables

--------------------------------------------------------------------------------

## Objetivo

- El alumno configurará switches administrables para simular la infraestructura red de un edificio completo.

## Elementos de apoyo

- [Video de la creación de una red en Packet Tracer 📼][video-packet-tracer]

## Restricciones

- La fecha límite de entrega es el **lunes 12 de septiembre de 2022** a las 23:59 horas
- Esta actividad debe ser entregada **en equipo** de acuerdo al [flujo de trabajo para la entrega de tareas y prácticas][flujo-de-trabajo]
    - Utilizar la carpeta `docs/practicas/practica-1/Equipo-ABCD-EFGH-IJKL-MNOP` para entregar la práctica
        - Donde `Equipo-ABCD-EFGH-IJKL-MNOP` representa el nombre del equipo que debió anotarse previamente en la [lista del grupo][lista-redes]
    - Crear un _merge request_ en el [repositorio de tareas][repo-tareas] para entregar la actividad

## Procedimiento

Realizar los siguientes laboratorios incluidos en [este archivo PDF][practicas-cisco]:

- **Lab 1-1**: Implementing small network (_p1_)
    - Crea la red del edificio de la UNAM que hayas elegido

- **Lab 2-2**: Switch initial configuration (_p5_)
    - Configura los switches para que tengan las interfaces adecuadas y la dirección IP de administración
    - Cableado horizontal: FastEthernet
    - Cableado vertical: GigabitEthernet

- **Lab 2-4**: Enhance switch security (_p11_)
    - Configura una contraseña para entrar al modo privilegiado `exec`
    - Configura la administración por SSH en cada switch
    - Deshabilita telnet y la consola web

!!! note
    No se contempla el uso de vLAN `802.1q` ni vLAN anidadas `802.1ad` (_Q-in-Q_) por lo que no se deben de configurar puertos troncales (trunk)

## Entregables

- Archivo `README.md`
    - Explicación de la topología de red utilizada.
        - Utilizar los equipos de red de tipo "Packet Tracer" (Switch-PT, AccessPoint-PT)
        - Utilizar PC, laptops, tablets y smartphones como clientes
        - Utilizar impresoras y servidores
        - La simulación de la red se limita únicamente a equipos en la red local, por lo que no se utilizarán routers
    - Tabla donde se listen los equipos, nombre de host, dirección IP de administración y la conexión con otros switches
        - La configuración de direcciones IP será de manera estática y se utilizará el rango `10.0.0.0/8`
    - Listar las imágenes con su respectiva descripción

- Carpeta `img`
    - Fotografías del edificio elegido
        - Pueden ser descargadas de Internet, siempre y cuando se cite la liga original de la imágen
    - Imagen de la topología de red implementada
    - Imagen de las pruebas de conectividad entre los equipos

- Carpeta `files`
    - Archivo de la actividad en formato `PKT` (Packet Tracer)
    - Configuración de cada switch administrable
        - Hacer que la configuración sea persistente con el comando
            - `copy  running-config  startup-config`
        - Guardar la salida del comando `show startup-config` a un archivo de texto (ej. `Switch-1.txt`)
        - Repetir para cada switch administrable

## Extra

Elaboren un video donde expliquen qué edificio se eligió, la topología de red utilizada y las pruebas de conectividad.

- Subir el video a YouTube
- Agregar la referencia de este video al archivo `README.md`

```text
- [Video de la topología de red utilizada 📼](https://youtu.be/0123456789ABCDEF)
```

--------------------------------------------------------------------------------

[flujo-de-trabajo]: https://redes-ciencias-unam.gitlab.io/2023-1/tareas-redes/workflow/
[repo-tareas]: https://gitlab.com/Redes-Ciencias-UNAM/2023-1/tareas-redes/-/merge_requests

[lista-redes]: https://tinyurl.com/Lista-Redes-2023-1

[packet-tracer-install]: ./install
[video-packet-tracer]: https://www.youtube.com/watch?v=zixHIQvI79k
[video-redes-cisco]: https://www.youtube.com/watch?v=5Bl8CJ8f53A

[practicas-cisco]: https://tinyurl.com/Redes-FC-UNAM-Practicas-Cisco
[instaladores-packet-tracer]: https://tinyurl.com/Redes-FC-UNAM-Cisco-PT
