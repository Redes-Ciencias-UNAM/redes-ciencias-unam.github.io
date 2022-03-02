---
# https://www.mkdocs.org/user-guide/writing-your-docs/#meta-data
title: Creación de una topología de red en Packet Tracer
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Creación de una topología de red en Packet Tracer

## Abrir Packet Tracer

Lanzar **Packet Tracer** y seleccionar **NO** en el cuadro de diálogo que aparece.

|      |
|:----:|
| ![](img/packet-tracer-016-launch.png) |

Iniciar sesión con la cuenta de **Cisco Network Academy** o de **Skills for All**

|      |
|:----:|
| ![](img/packet-tracer-017-login.png) |

<!--
|      |
|:----:|
| ![](img/packet-tracer-017-login-password.png) |

|      |
|:----:|
| ![](img/packet-tracer-017-login-username.png) |
-->

Seleccionar el menú **Help** > **About**

|      |
|:----:|
| ![](img/packet-tracer-019-about.png) |

Esta es la interfaz principal de Packet Tracer

## Crear topología de red

|      |
|:----:|
| ![](img/packet-tracer-018-interface.png) |

Agregar algunos equipos de red para hacer una topología de muestra

- Switch-PT
- Server
- Laptop

Seleccionar el botón del **rayo** para conectar los equipos

|      |
|:----:|
| ![](img/packet-tracer-020-network.png) |

### Configurar direcciones IP

!!! note
    Para este ejercicio el switch no tendrá dirección IP asignada

Configurar la dirección IP de la laptop

|      |
|:----:|
| ![](img/packet-tracer-021-laptop-IP.png) |

Configurar la dirección IP del servidor

|      |
|:----:|
| ![](img/packet-tracer-022-server-IP.png) |


### Verificar conectividad

Abrir la interfaz de escritorio de la laptop

|      |
|:----:|
| ![](img/packet-tracer-023-laptop-desktop.png) |

Listar la configuración de red con el comando `ipconfig`

|      |
|:----:|
| ![](img/packet-tracer-024-laptop-ipconfig.png) |

Verificar la conectividad hacia el servidor con el comando `ping`

|      |
|:----:|
| ![](img/packet-tracer-025-laptop-ping.png) |

Abrir la interfaz de escritorio del servidor

|      |
|:----:|
| ![](img/packet-tracer-026-server-desktop.png) |

Listar la configuración de red con el comando `ipconfig`

|      |
|:----:|
| ![](img/packet-tracer-027-server-ipconfig.png) |

Verificar la conectividad hacia el servidor con el comando `ping`

|      |
|:----:|
| ![](img/packet-tracer-028-server-ping.png) |

Listar la configuración de red de los dos equipos

!!! note
    Para este ejercicio el switch no tendrá dirección IP asignada

|      |
|:----:|
| ![](img/packet-tracer-029-both-config.png) |

Listar las ventanas de comandos con el resultado de `ping`

|      |
|:----:|
| ![](img/packet-tracer-030-both-ping.png) |

## Guardar el archivo de trabajo

|      |
|:----:|
| ![](img/packet-tracer-031-save.png) |


|      |
|:----:|
| ![](img/packet-tracer-032-save-location.png) |
