---
title: Instalación de Debian 11 bullseye
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Instalación de Debian 11 _bullseye_

!!! note
    - Si ya instalaste tu máquina virtual, continúa en [la siguiente página](../debian-configure)
    - No olvides verificar la configuración de VirtualBox

--------------------------------------------------------------------------------

<!--
<details>
<summary>Da clic aquí para expandir</summary>
-->

## Descarga de imagen ISO

|      |
|:----:|
| ![](img/debian-11/download/debian-001-homepage.png) |

|      |
|:----:|
| ![](img/debian-11/download/debian-002-download.png) |

|      |
|:----:|
| ![](img/debian-11/download/debian-003-iso.png) |

|      |
|:----:|
| ![](img/debian-11/download/debian-004-downloaded.png) |

--------------------------------------------------------------------------------

## Creación de máquina virtual

### Crear nueva máquina virtual

|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-001-virtualbox-new-vm.png) |

|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-002-virtualbox-vm-name.png) |

|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-003-virtualbox-vm-ram.png) |

|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-004-virtualbox-vm-disk.png) |

|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-005-virtualbox-vm-disk-type.png) |

|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-006-virtualbox-vm-disk-allocation.png) |

|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-007-virtualbox-vm-disk-size.png) |

|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-008-virtualbox-vm-settings.png) |

<!--
|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-008-virtualbox-vm-settings-2.png) |
-->

### Agregar imagen ISO de instalación

|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-010-virtualbox-vm-settings-storage.png) |

<!--
|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-011-virtualbox-vm-settings-storage-iso.png) |
-->

|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-012-virtualbox-vm-settings-select-iso.png) |

|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-013-virtualbox-vm-settings-iso-selected.png) |

### Iniciar máquina virtual

|      |
|:----:|
| ![](img/debian-11/virtualbox/debian-014-virtualbox-vm-start.png) |

--------------------------------------------------------------------------------

## Instalación del sistema operativo

|      |
|:----:|
| ![](img/debian-11/install/debian-001-install-boot-menu.png) |

### Seleccionar idioma y ubicación

|      |
|:----:|
| ![](img/debian-11/install/debian-002-install-language.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-003-install-location-1.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-004-install-location-2.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-005-install-location-3.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-006-install-locales.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-007-install-keyboard.png) |

### Configurar nombre de host

|      |
|:----:|
| ![](img/debian-11/install/debian-009-install-hostname.png) |

<!--
|      |
|:----:|
| ![](img/debian-11/install/debian-008-install-hostname-OLD.png) |
-->

### Configurar usuarios y contraseñas

|      |
|:----:|
| ![](img/debian-11/install/debian-010-install-root-password.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-011-install-user-1.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-012-install-user-2.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-013-install-user-password.png) |

### Configuración horaria

|      |
|:----:|
| ![](img/debian-11/install/debian-014-install-timezone.png) |

### Particionar disco

|      |
|:----:|
| ![](img/debian-11/install/debian-015-install-partition-method.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-016-install-partition-select-disk.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-017-install-partition-scheme.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-018-install-partition-confirm.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-019-install-partition-write.png) |

### Instalar sistema base

|      |
|:----:|
| ![](img/debian-11/install/debian-020-install-base-system.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-021-install-scan-media.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-022-install-select-mirror.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-023-install-type-mirror.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-024-install-mirror-proxy.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-025-install-configure-apt.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-026-install-select-software.png) |

### Participar en la encuesta de uso de paquetes (opcional)

|      |
|:----:|
| ![](img/debian-11/install/debian-027-install-popcon.png) |

### Seleccionar entorno de escritorio

|      |
|:----:|
| ![](img/debian-11/install/debian-028-install-desktop-environment.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-029-install-select-software-2.png) |

### Instalar gestor de arranque

|      |
|:----:|
| ![](img/debian-11/install/debian-030-install-grub.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-031-install-grub-device.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-032-install-grub-running.png) |

### Finalizar instalación

|      |
|:----:|
| ![](img/debian-11/install/debian-033-install-finishing.png) |

|      |
|:----:|
| ![](img/debian-11/install/debian-034-install-complete.png) |

<!-- </details> -->

--------------------------------------------------------------------------------

!!! info
    - Cuando hayas terminado de instalar la máquina Debian, [continúa con la configuración](../debian-configure)
