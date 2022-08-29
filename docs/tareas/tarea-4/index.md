---
# https://www.mkdocs.org/user-guide/writing-your-docs/#meta-data
title: Tarea 4 - Laboratorio virtual de redes
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Tarea 4: Laboratorio virtual de redes

--------------------------------------------------------------------------------

## Objetivo

- El alumno instalará un laboratorio virtual para el análisis de redes y la implementación de servicios de red en sistemas operativos GNU/Linux.

## Elementos de apoyo

- [Capturas de pantalla de la instalación de Debian 11 🖥️][debian-install]
- [Capturas de pantalla de la configuración de Debian 11 🖥️][debian-configure]
- [Capturas de pantalla de la instalación de CentOS Stream 8 🖥️][centos-install]
- [Capturas de pantalla de la configuración de CentOS Stream 8 🖥️][centos-configure]

- [Video de instalación de Debian 11 📼][video-debian-install]
- [Video de instalación de utilerías de VirtualBox en Debian 11 📼][video-debian-guest-additions]

- [Video de instalación de CentOS Stream 8 📼][video-centos-install]
- [Video de instalación de utilerías de VirtualBox en CentOS Stream 8 📼][video-centos-guest-additions]

## Restricciones

- Esta tarea debe ser entregada de manera **individual**

- La fecha límite de entrega es el **miércoles 07 de septiembre de 2022** a las 23:59 horas
- Esta actividad debe ser entregada de manera **individual** de acuerdo al [flujo de trabajo para la entrega de tareas y prácticas][flujo-de-trabajo]
    - Crear un _merge request_ en el [repositorio de tareas][repo-tareas] para entregar la actividad



## Entregables

- Pantallas donde se muestre la información del sistema de las máquinas virtuales [Debian][debian-about] y [CentOS][centos-about]
    - Listar las imágenes con su respectiva descripción en el archivo `README.md`

```text
| ![](img/imagen.png)      |
|:------------------------:|
| Descripción de la imagen |
```

- Agregar un bloque de _texto preformateado_ donde se liste la información del sistema para Debian y CentOS
    - Agregar esta información como texto en el archivo `README.md`, no agregar capturas de pantalla
    - Repetir para cada una de las máquinas virtuales (Debian y CentOS)

```text
# uname -a
	...
# cat /etc/os-release
	...
# cat /etc/debian_version /etc/redhat-release
	...
# lsmod
	...
# ps afx
	...
# hostname -I
	...
# ip addr
	...
# ip route show
	...
# cat /etc/resolv.conf
	...
# netstat -ntulp
	...
# ping -c 4 1.1.1.1
	...
# dig example.com.
	...
```

- Listar los privilegios que tiene el usuario normal
    - La llamada a `sudo -i` no debería pedir contraseña
    - Agregar esta información como texto en el archivo `README.md`, no agregar capturas de pantalla
    - Repetir para cada una de las máquinas virtuales (Debian y CentOS)

```text
$ getent passwd ${USER}
	...
$ id
	...
$ groups
	...
$ sudo -l
	...
$ sudo -i
	...
```

- Agregar un bloque de _texto preformateado_ donde se liste la ubicación de las herramientas que se instalaron en [Debian][debian-tools] y [CentOS][centos-tools]
    - Agregar esta información como texto en el archivo `README.md`, no agregar capturas de pantalla
    - Repetir para cada una de las máquinas virtuales (Debian y CentOS)

```bash
$ which wireshark tcpdump nmap ...

	...

$ whereis wireshark tcpdump nmap ...

	...
```

## Procedimiento

### Instalar máquinas virtuales

- Instalar [VirtualBox][virtualbox] en el equipo físico

- Instalar una máquina virtual donde se administren los paquetes con `apt`
    - [Debian 11][debian] _"bullseye"_
    - [Ubuntu 20.04 LTS][ubuntu] _"focal"_
    - Hay una serie de pantallas sobre la [instalación de Debian 11][debian-install]

- Instalar otra máquina virtual donde se administren los paquetes con `yum` o `dnf`
    - [CentOS Stream 8][centos]
    - [Rocky Linux 8][rocky]
    - [Alma Linux 8][alma]
    - Hay una serie de pantallas sobre la [instalación de CentOS 8][centos-install]

- Se recomienda que las máquinas virtuales tengan los siguientes recursos:
    - 1 vCPU
    - 2 GB de RAM
    - 10 GB de disco

### Configuración de red

Cada una de las máquinas virtuales deben tener dos interfaces de red

- Interfaz 1: NAT
- Interfaz 2: Host-only (sólo anfitrión)

### Configuración de usuarios

- Habilitar `sudo` sin contraseña
- Instalar SSH para acceso remoto

### Configuración de software

- Instalar utlerías del sistema
- Instalar herramientas de desarrollo
- Instalar _software_ para análisis de redes

### Configuración extra de VirtualBox

- Configurar los siguientes elementos para las máquinas virtuales
    - [Debian 11][debian-configure]
    - [CentOS Stream 8][centos-configure]
- Instalar los _Guest Additions_ de VirtualBox
- Habilitar el portapapeles compartido
- Configurar una carpeta compartida para copiar archivos entre la máquina física y las máquinas virtuales

--------------------------------------------------------------------------------

[virtualbox]: https://www.virtualbox.org/wiki/Downloads
[debian]: https://debian.org/download
[ubuntu]: https://ubuntu.com/download/desktop/thank-you?version=20.04.3&architecture=amd64
[centos]: https://centos.org/download/
[rocky]: https://rockylinux.org/download
[alma]: https://almalinux.org/isos.html

[fedora-virt-ext]: https://docs.fedoraproject.org/en-US/Fedora/13/html/Virtualization_Guide/sect-Virtualization-Troubleshooting-Enabling_Intel_VT_and_AMD_V_virtualization_hardware_extensions_in_BIOS.html

[nixcraft-virt]: https://www.cyberciti.biz/faq/linux-xen-vmware-kvm-intel-vt-amd-v-support/

[video-debian-install]: https://www.youtube.com/watch?v=OSlESCNSr5U
[video-debian-guest-additions]: https://www.youtube.com/watch?v=AQXuv80cct4
[video-centos-install]: https://www.youtube.com/watch?v=H-TLEAGyFIQ
[video-centos-guest-additions]: https://www.youtube.com/watch?v=JrGOMFaRr1Y

[flujo-de-trabajo]: https://redes-ciencias-unam.gitlab.io/2022-2/tareas-redes/workflow/
[repo-tareas]: https://gitlab.com/Redes-Ciencias-UNAM/2022-2/tareas-redes/-/merge_requests

[debian-install]: ./debian-install
[centos-install]: ./centos-install

[debian-configure]: ./debian-configure
[centos-configure]: ./centos-configure

[debian-tools]: ./debian-configure/#instalar-software
[centos-tools]: ./centos-configure/#instalar-software

[debian-about]: ./debian-configure/#informacion-del-sistema
[centos-about]: ./centos-configure/#informacion-del-sistema
