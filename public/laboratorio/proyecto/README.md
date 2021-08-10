![UNAM-FC](../UNAM-FC.png)

# Redes de Computadoras
# Proyecto final

Este trabajo corresponde al último proyecto que deben entregar para realizar la evaluación del curso de Redes de Computadoras.

Cada equipo tendrá que configurar uno de los servicios de red que se describen a continuación.

**Tabla de contenido**

<details open>
  <summary>Expandir / Colapsar</summary>

[[_TOC_]]

</details>

## Fecha de entrega

- [Miércoles 18 de agosto de 2021 a las 23:59 hrs][countdown].

[countdown]: https://www.timeanddate.com/countdown/wfh?iso=20210818T235959&p0=155&msg=Entrega+proyecto+final+-+Redes+2021-2&ud=1&font=hand&csz=1

--------------------------------------------------------------------------------

## Implementación de un _stack_ web

- De la tabla que se muestra a continuación, elegir un elemento de cada columna

- Habilitar el soporte de "userdir" donde cada usuario tenga en su directorio home una carpeta llamada "public_html" o "public_tomcat" que sirva para que el usuario suba sus archivos y que estén disponibles en `/~usuario` en el servidor

    - Ej. `/home/andres/public_html` ⇨ `https://example.com/~andres`

- Montar una aplicación web simple que se conecte al motor de caché y a la base de datos (la que hayan elegido en la columna de Aplicación Web).

- El sitio debe tener un certificado SSL emitido por Let's Encrypt, el equipo puede tramitar una zona DNS en FreeNom o pedir que se le delegue una zona para completar la validación del certificado

- El sitio debe hacer redirección de todas las peticiones HTTP hacía su versión en HTTPS

    - Se pueden usar redirecciones estándar 301 y 302 de HTTP

|                                       |
|:-------------------------------------:|
| ![Proyecto web](img/proyecto-web.png) |

--------------------------------------------------------------------------------

## Servidor de monitoreo

- Instalar un servidor de monitoreo mediante el software Nagios o Icinga

- Se debe configurar el servidor para llevar a cabo el monitoreo de estado de los siguientes servicios de red:

    - DNS
    - HTTP y HTTPS
    - IMAP
    - SMTP
    - MemCache
    - Redis
    - MySQL
    - PostgreSQL
    - Validez del certificado SSL
    - Expiración del dominio

- A  través de este equipo se deben generar alertas en caso de falla y avisos de recuperación de los servicios
    - Telegram
    - Twitter

- Los elementos que se deberán implementar en este servicio se muestran en el diagrama:

|                                                   |
|:-------------------------------------------------:|
| ![Proyecto monitoreo](img/proyecto-monitoreo.png) |

--------------------------------------------------------------------------------

## Extra

- Implementar HSTS en las cabeceras del sitio
    - Establecer un timeout bajo de entre 60 y 300 segundos

--------------------------------------------------------------------------------

### Entregables

--------------------------------------------------------------------------------

### Notas adicionales

