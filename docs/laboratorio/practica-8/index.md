---
title: Práctica 8 - Creación de recursos en Azure
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Práctica 8: Creación de recursos en Azure

--------------------------------------------------------------------------------

## Objetivo

- El alumno realizará algunas capturas de tráfico de red donde identificará los protocolos asociados a cada capa del modelo OSI

## Elementos de apoyo

- [Protocolo DNS 📼][video-protocolo-dns]
- [Configuración de OpenSSH y autenticación con llaves 📼][video-configuracion-ssh]
- [How does Microsoft Azure work? 📼][youtube-how-does-azure-work]
- [Virtual machines selector tool][azure-vm-selector]
- [Linux virtual machines in Azure 📝][azure-linux-vm-overview]
- [Quickstart: Create a Linux virtual machine in the Azure portal 📝][azure-linux-vm-quickstart]
- [Create a Linux virtual machine in Azure 📝][azure-linux-vm-create]
- [Overview of DNS zones and records 📝][azure-dns-overview]
- [How to manage DNS Zones in the Azure portal 📝][azure-dns-manage]
- [Quickstart: Create an Azure DNS zone and record using the Azure portal 📝][azure-dns-quickstart]

## Restricciones

- La fecha límite de entrega es el **viernes 18 de noviembre de 2022** a las 23:59 horas
- Esta actividad debe ser entregada **en equipo** de acuerdo al [flujo de trabajo para la entrega de tareas y prácticas][flujo-de-trabajo]
    - Utilizar la carpeta `docs/practicas/practica-8/Equipo-ABCD-EFGH-IJKL-MNOP` para entregar la práctica
        - Donde `Equipo-ABCD-EFGH-IJKL-MNOP` representa el nombre del equipo que debió anotarse previamente en la [lista del grupo][lista-redes]
    - Hacer un _merge request_ a la rama `practica-8` del [repositorio de tareas][repo-tareas] para entregar la actividad

!!! danger
    - **Las siguientes actividades dependen de los recursos que se implementan en esta práctica**
    - Se recomienda que se realice esta actividad [siguiendo la calendarización](../) con el objeto de dejar suficiente tiempo para la elaboración de las siguientes actividades

## Entregables

- Archivo `README.md`
    - Anotar el nombre de dominio que se registró y la dirección IP **pública** de la máquina virtual
    - Explicación del procedimiento que se siguió para crear los recursos en Azure
    - Explicación del procedimiento que se siguió para registrar el nombre de dominio en FreeNom y asociarlo a la zona DNS en Azure
    - Explicación de los comandos utilizados para inicializar la máquina virtual en Azure
    - Salida de las consultas DNS para los registros `SOA`, `NS`, `A` y `CNAME`
    - Salida de los siguientes comandos en la máquina virtual como el usuario `root`

```
# uname -a
# cat /proc/cmdline
# id redes
# groups redes
# sudo -l -U redes
# timedatectl
# hostnamectl
# hostname -f
# ip addr
# ip route
# cat /etc/hostname
# cat /etc/hosts
# cat /etc/resolv.conf
# ls -la ~root/.ssh ~redes/.ssh
# lsattr ~root/.ssh/authorized_keys* ~redes/.ssh/authorized_keys*
# lastlog
# last
# free -m
# ps afx
```

- Carpeta `img`
    - Capturas de pantalla donde se muestren los recursos creados en Azure (máquina virtual y zona DNS)
    - Capturas de pantalla donde se muestre el registro del nombre de dominio en FreeNom
    - Cada captura de pantalla tiene que ser referenciada en el archivo `README.md`

- Carpeta `files`
    - Copia de la llave SSH pública que el equipo utilizó para conectarse a la máquina virtual
    - Archivos de configuración
        - `/etc/ssh/sshd_config`
        - `/etc/sudoers`
        - Los archivos contenidos en el directorio `/etc/sudoers.d`
    - Archivos de bitácora
        - `/var/log/wtmp` y `/var/log/btmp`
        - `/var/log/messages` y `/var/log/kern.log`
        - `/var/log/user.log` y `/var/log/auth.log`
        - `/var/log/dpkg.log`
        - `/var/log/debug`
        - `/var/log/cloud-init.log` y `/var/log/cloud-init-output.log`
        - Los archivos contenidos en el directorio `/var/log/apt`
        - Los archivos contenidos en el directorio `/var/log/azure`
        - Los archivos contenidos en el directorio `/var/log/unattended-upgrades`
    - Archivos de datos
        - Los archivos contenidos en el directorio `/var/lib/dhcp`
        - Los archivos contenidos en el directorio `/var/lib/cloud`

--------------------------------------------------------------------------------

## Procedimiento

1. [Crear una cuenta de correo en Comunidad UNAM](correo-comunidad-unam)

2. [Unirse al _programa para estudiantes de Azure_](cuenta-azure-student) utilizando la dirección de correo `@comunidad.unam.mx`.

3. [Crear una máquina virtual GNU/Linux en Azure](maquina-virtual-azure)

4. [Registrar un nombre de domino y crear una zona DNS](nombre-de-dominio)

5. [Configurar de la máquina virtual Debian GNU/Linux](maquina-virtual-linux)

--------------------------------------------------------------------------------

[flujo-de-trabajo]: https://redes-ciencias-unam.gitlab.io/2023-1/tareas-redes/workflow/
[repo-tareas]: https://gitlab.com/Redes-Ciencias-UNAM/2023-1/tareas-redes/-/merge_requests

[lista-redes]: https://tinyurl.com/Lista-Redes-2023-1

[video-protocolo-dns]: https://www.youtube.com/watch?v=r4PntflJs9E
[video-configuracion-ssh]: https://youtu.be/Hnu7BHBDcoM&t=1390

[welcome-to-azure]: https://azure.microsoft.com/en-us/get-started/welcome-to-azure/
[azure-faq-free-services]: https://azure.microsoft.com/en-us/free/free-account-faq/#free-services
[azure-free]: https://azure.microsoft.com/en-us/free/
[signup-azure-free-trial]: https://signup.azure.com/signup?offer=ms-azr-0044p&appId=102&ref=azureplat-generic&correlationId=007dc175d36f4838b2d2a2ec8d7eca37
[signup-azure-pay-as-you-go]: https://signup.azure.com/signup?offer=MS-AZR-0003P
[azure-education-students]: https://azureforeducation.microsoft.com/en-us/Student
[azure-students]: https://azure.microsoft.com/en-us/free/students/
[azure-students-faq]: https://azure.microsoft.com/en-us/offers/ms-azr-0170p/
[signup-azure-students]: https://signup.azure.com/studentverification?offerType=1&correlationId=007dc175d36f4838b2d2a2ec8d7eca37
[azure-education-hub-student-program]: https://docs.microsoft.com/en-us/azure/education-hub/azure-dev-tools-teaching/azure-students-program
[azure-education-hub-student-starter-program]: https://docs.microsoft.com/en-us/azure/education-hub/azure-dev-tools-teaching/azure-students-starter-program
[azure-student-developer-resources]: https://azure.microsoft.com/en-us/developer/students/
[azure-devtools-education]: https://azureforeducation.microsoft.com/devtools
[azure-docs-cost-mgt-data]: https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/cost-management-billing/costs/understand-cost-mgt-data.md
[azure-freeservices-list]: https://portal.azure.com/#blade/Microsoft_Azure_Billing/FreeServicesBlade
[azure-vm-create-linux]: https://portal.azure.com/#create/microsoft.freeaccountvirtualmachine-linux
[azure-vm-list]: https://portal.azure.com/#create/Microsoft.VirtualMachine
[azure-serial-console-linux]: https://aka.ms/serialconsolelinux
[azure-vm-pricing]: https://azure.microsoft.com/en-us/pricing/vm-selector/
[azure-portal]: https://portal.azure.com/

[github-education-pack]: https://education.github.com/pack

[youtube-playlist-azure-virtual-machines]: https://www.youtube.com/playlist?list=PLLasX02E8BPCsnETz0XAMfpLR1LIBqpgs
[youtube-playlist-linux-on-azure]: https://www.youtube.com/playlist?list=PLLasX02E8BPAdlJA3WkKG-1_qQNy4Y9YV
[youtube-how-does-azure-work]: https://youtu.be/KXkBZCe699A
[azure-dns-overview]: https://docs.microsoft.com/en-us/azure/dns/dns-zones-records
[azure-dns-manage]: https://docs.microsoft.com/en-us/azure/dns/dns-operations-dnszones-portal
[azure-dns-quickstart]: https://docs.microsoft.com/en-us/azure/dns/dns-getstarted-portal
[azure-linux-vm-overview]: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/overview
[azure-linux-vm-quickstart]: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal
[azure-linux-vm-create]: https://docs.microsoft.com/en-us/learn/modules/create-linux-virtual-machine-in-azure/
[azure-vm-selector]: https://aka.ms/vm-selector

<!--
![](data:image/png;base64,)
<img alt="" src="data:image/png;base64,AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4vMDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5fYGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6PkJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v8PHy8/T19vf4+fr7/P3+/w==" />
-->
