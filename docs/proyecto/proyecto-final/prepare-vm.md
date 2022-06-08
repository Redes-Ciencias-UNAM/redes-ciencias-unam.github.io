---
title: Preparación de la máquina virtual para k3s
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Preparación de la máquina virtual para `k3s`

--------------------------------------------------------------------------------

!!! danger
    - Las configuraciones aqui listadas son únicamente para un ambiente de pruebas
    - Ninguna de estas configuraciones se debe realizar en ambientes de producción

!!! warning
    - Estas configuraciones se realizan para que el cluster de k3s pueda ejecutarse en el equipo `B1S` que tiene únicamente **1 vCPU** y **512 MB de RAM**
    - No utilizar el tipo de instancia `B1S` para clusters de Kubernetes en ambientes de producción

<!--
https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/create-free-services
https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-b-series-burstable
https://azure.microsoft.com/en-us/blog/introducing-b-series-our-new-burstable-vm-size/
-->

## Revisar el uso de memoria RAM en el equipo

Revisar el uso de memoria RAM, debería ser significantemente menos que cuando se inició esta práctica

```
root@example:~# free -m
               total        used        free      shared  buff/cache   available
Mem:             913         498         206           1         209         281
Swap:              0           0           0
```

--------------------------------------------------------------------------------

## Desinstalar Apache HTTPD

Remover el demonio de HTTP instalado en la práctica anterior

```
root@example:~# apt remove apache2
	...
```

--------------------------------------------------------------------------------

## Reemplazar el demonio de `syslog`

Se debe reemplazar el demonio de syslog para hacer que la máquina virtual consuma menos memoria RAM

En este caso se va a reemplazar `rsyslog` con `busybox-syslogd`

```
root@example:~# apt remove rsyslog
	...

root@example:~# apt install busybox-syslogd
	...
```

--------------------------------------------------------------------------------

## Deshabilitar el servicio de actualizaciones automáticas

Otra manera de bajar el uso de memoria RAM es deshabilitar el servicio `unattended-upgrades`

```
root@example:~# systemctl disable unattended-upgrades
```

--------------------------------------------------------------------------------

## Deshabilitar tareas programadas

El equipo ejecuta algunas tareas de manera periódica.
Estas tareas hacen que se incremente el uso de memoria RAM por lo que se pueden deshabilitar para el contexto de esta práctica

```
root@example:~# mkdir -vp /etc/cron.daily.disabled
root@example:~# mv -v /etc/cron.daily /etc/cron.daily.disabled
	...
```

--------------------------------------------------------------------------------

## Reducir el uso de memoria de `JournalD`

El demonio `systemd-journald` guarda las bitácoras de estado de los servicios del sistema, se pueden deshabilitar algunas funciones para reducir el uso de memoria RAM.

Establecer los siguientes valores en el archivo de configuración `/etc/systemd/journald.conf` 

```
root@example:~# egrep -v '^\s*(#|$)' /etc/systemd/journald.conf
[Journal]
Storage=none
ForwardToSyslog=no
ForwardToKMsg=no
ForwardToConsole=no
ForwardToWall=no
ReadKMsg=no
Audit=no
```

--------------------------------------------------------------------------------

## Establecer un área de intercambio SWAP

[Desde la versión 1.22 de Kubernetes][kubernetes-blog-swap-alpha] es posible utilizar [memoria swap en los nodos del cluster][kubernetes-nodes-swap-alpha], esta característica está en fase `alpha` de desarrollo por lo que puede cambiar en cualquier versión futura

Esto ayuda mucho a nodos con poca memoria RAM, como la máquina virtual de tipo `B1S` en Azure

[kubernetes-blog-swap-alpha]: https://kubernetes.io/blog/2021/08/09/run-nodes-with-swap-alpha/
[kubernetes-nodes-swap-alpha]: https://kubernetes.io/docs/concepts/architecture/nodes/#swap-memory

### Habilitar política de SWAP en `sysctl`

Establecer la política `vm.swappiness` en el archivo de configuración `/etc/sysctl.d/local.conf`

```
root@example:~# cat >> /etc/sysctl.d/local.conf << EOF
###################################################################
# https://www.kernel.org/doc/html/latest/admin-guide/sysctl/vm.html#swappiness
vm.swappiness = 1
EOF
```

Recargar la configuración de `sysctl` para probar que los cambios surtieron efecto

```
root@example:~# sysctl -p
vm.swappiness = 1

root@example:~# cat /proc/sys/vm/swappiness 
1
```

### Crear partición SWAP en el disco adicional

Listar los dispositivos de bloque y verificar que `/dev/sdb1` se encuentre montado en el directorio `/mnt`

!!! warning
    En caso de que la máquina virtual no tenga el disco `/dev/sdb`, se tendrá que crear un _swap-file_ en la ruta `/.swap` con dueño `root:root` y permisos `0600`

```
root@example:~# lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda       8:0    0   30G  0 disk 
|-sda1    8:1    0 29.9G  0 part /
|-sda14   8:14   0    3M  0 part 
\-sda15   8:15   0  124M  0 part /boot/efi
sdb       8:16   0    4G  0 disk 
\-sdb1    8:17   0    4G  0 part /mnt
```

Desmontar el directorio `/mnt` para dejar de usar la partición `/dev/sdb1`

```
root@example:~# umount /mnt
```

Editar el archivo `/etc/fstab` para deshabilitar el punto de montaje de la partición `/dev/sdb1`

- Comentar la siguiente línea al final del archivo `/etc/fstab`

```
# /dev/disk/cloud/azure_resource-part1	/mnt	auto	defaults,nofail,comment=cloudconfig	0	2
```

Crear un espacio de SWAP en la partición `/dev/sdb1`

!!! danger
    Verificar que la partición en la que se crea el espacio de SWAP no esté montada y no esté siendo utilizada por el sistema operativo

```
root@example:~# mkswap /dev/sdb1 
mkswap: /dev/sdb1: warning: wiping old swap signature.
Setting up swapspace version 1, size = 4 GiB (4294967296 bytes)
no label, UUID=dd8a91f6-ca32-30e0-983c-8f309d653045
```

Para más información sobre SWAP y _swap-files_

- <https://www.linux.com/training-tutorials/increase-your-available-swap-space-swap-file/>
- <https://www.linuxjournal.com/article/10678>
- <https://www.linuxjournal.com/video/emergency-swapfile-when-your-memory-fills>
- <https://wiki.debian.org/Swap>

<!--
https://wiki.archlinux.org/title/Swap#Swap_file
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_storage_devices/getting-started-with-swap_managing-storage-devices#creating-a-swap-file_getting-started-with-swap
https://docs.oracle.com/en/learn/file_system_linux_8/#task-9-increase-swap-space
https://docs.oracle.com/en/operating-systems/oracle-linux/6/admin/swap-create-use.html
https://docs.rackspace.com/support/how-to/create-a-linux-swap-file/
https://docs.rackspace.com/support/how-to/create-remove-swap-file-in-ubuntu/
https://itsfoss.com/create-swap-file-linux/
https://www.tecmint.com/create-a-linux-swap-file/
https://tecadmin.net/linux-create-swap/
https://linuxize.com/post/create-a-linux-swap-file/
https://linoxide.com/how-to-create-linux-swap-file/
https://www.vultr.com/docs/setup-swap-file-on-linux/
-->


### Crear configuración de montaje de SWAP

Verificar que la línea donde se monta el directorio `/mnt` está conentada y establecer el punto de montaje para la partición SWAP en el archivo `/etc/fstab`

!!! warning
    En caso de utilizar un _swap-file_ reemplazar `/dev/sdb1` con `/.swap` en el primer campo de `/etc/fstab`

```
root@example:~# cat /etc/fstab
# /etc/fstab: static file system information
UUID=ad6b1df1-54de-4e70-800b-fccd17238cbc / ext4 rw,discard,errors=remount-ro,x-systemd.growfs 0 1
UUID=E098-B03A /boot/efi vfat defaults 0 0
#/dev/disk/cloud/azure_resource-part1	/mnt	auto	defaults,nofail,comment=cloudconfig	0	2

# swap
/dev/sdb1	none	swap	defaults	0	0
```

### Habilitar SWAP

Habilitar de manera manual la partición SWAP para verifica que la configuración es correcta

```
root@example:~# swapon -va
swapon: /dev/sdb1: found signature [pagesize=4096, signature=swap]
swapon: /dev/sdb1: pagesize=4096, swapsize=4292870144, devsize=4292870144
swapon /dev/sdb1
```

Revisar el uso de memoria RAM, debería ser significantemente menos que cuando se inició esta práctica

```
root@example:~# free -m
               total        used        free      shared  buff/cache   available
Mem:             913          83         543           1         287         697
Swap:           4093           0        4093
```

--------------------------------------------------------------------------------

## Verifica la configuración

Reinicia el equipo para verificar que los cambios sean persistentes

```
root@example:~# reboot
```

!!! danger
    - Verifica que **TODAS** las configuraciones que hiciste estén presentes respués de reiniciar la máquina antes de continuar con [la siguiente sección][siguiente]

!!! note
    - Continúa en [la siguiente página][siguiente] si el uso de memoria RAM es menor o igual al mostrado anteriormente

--------------------------------------------------------------------------------

|                 ⇦           |        ⇧      |                  ⇨            |
|:----------------------------|:-------------:|------------------------------:|
| [Página anterior][anterior] | [Arriba](../) | [Página siguiente][siguiente] |

[anterior]: ../docker
[siguiente]: ../k3s-install
