---
title: Práctica 10 - Implementación de sitios web sobre HTTPS
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Práctica 10: Implementación de sitios web sobre HTTPS

--------------------------------------------------------------------------------

## Objetivos

- Asignar un nombre de dominio DNS que apunte a la máquina virtual
- Instalar el servidor web Apache HTTPD y configurarlo para que responda a peticiones de HTTP y HTTPS
- Configurar VirtualHosts para HTTP y HTTPS
- Generar un certificado SSL con Let's Encrypt utilizando el cliente `certbot`

## Elementos de apoyo

- Todos estos videos están en una [lista de reproducción dedicada a los temas de HTTP y SSL 📹][playlist-https]
- [Protocolo DNS 📼][video-protocolo-dns]
- [Configuración de OpenSSH y autenticación con llaves 📼][video-configuracion-ssh]
- [Configuración de Apache HTTPD en Debian 📼][video-configuracion-apache-debian]
- [Directivas de configuración de Apache HTTPD 📼][video-directivas-apache]
- [Configuración de VirtualHosts de Apache HTTPD 2.4 utilizando /etc/hosts 📼][video-virtualhosts-apache-etc-hosts]
- [Configuración de VirtualHosts de Apache HTTPD 2.4 con registros DNS 📼][video-virtualhosts-apache-registros-dns]
- [Certificados SSL x509 📼][video-certificados-ssl-x509]
- [Certificados SSL con OpenSSL y VirtualHost HTTPS en Apache HTTPD 📼][video-certificados-ssl-virtualhost-https-apache]
- [Trámite de un certificado SSL con Let's Encrypt utilizando certbot 📼][video-letsencrypt-certbot]

???+ details "Páginas de manual de Apache HTTPD"

    - [Apache HTTP Server - Documentation - Version 2.4][apache-docs]
    - [Configuration Sections][apache-docs-config-sections]
    - [Security Tips][apache-docs-security]
    - [Server-Wide Configuration][apache-docs-server-wide]
    - [URL Rewriting with mod_rewrite][apache-docs-url-rewrite]
    - [Apache Virtual Host documentation][apache-docs-virtualhost]
    - [Apache SSL/TLS Encryption][apache-docs-ssl]
    - [Apache HTTP Server Tutorial: .htaccess files][apache-docs-htaccess]

## Restricciones

- La fecha límite de entrega es el **jueves 01 de diciembre de 2022** a las 23:59 horas
- Esta actividad debe ser entregada **en equipo** de acuerdo al [flujo de trabajo para la entrega de tareas y prácticas][flujo-de-trabajo]
    - Utilizar la carpeta `docs/practicas/practica-10/Equipo-ABCD-EFGH-IJKL-MNOP` para entregar la práctica
        - Donde `Equipo-ABCD-EFGH-IJKL-MNOP` representa el nombre del equipo que debió anotarse previamente en la [lista del grupo][lista-redes]
    - Hacer un _merge request_ a la rama `practica-10` del [repositorio de tareas][repo-tareas] para entregar la actividad

!!! danger
    - **Esta actividad depende de los recursos implementados en la [práctica 6](../practica-6)**
    - Se recomienda que se realice esta actividad [siguiendo la calendarización](../) con el objeto de dejar suficiente tiempo para la elaboración de las siguientes actividades

--------------------------------------------------------------------------------

## Procedimiento

1. [Instala y configura Apache HTTPD en tu máquina virtual](./apache-httpd)

2. [Configura el módulo SSL y tramita el certificado SSL válido con Let's Encrypt](./ssl-lets-encrypt)

3. [Configura los VirtualHosts en tu máquina virtual](./virtual-hosts)

4. Valida la configuración, junta los archivos [entregables](#entregables) y genera tu reporte

--------------------------------------------------------------------------------

## Entregables

- Archivo `README.md`
    - Anotar el nombre de dominio que se registró y la dirección IP **pública** de la máquina virtual
    - Explicación del procedimiento que se siguió para crear los recursos en Azure
    - Explicación del procedimiento que se siguió para registrar el nombre de dominio en FreeNom y asociarlo a la zona DNS en Azure
    - Explicación de los comandos utilizados para inicializar la máquina virtual en Azure
    - Salida de las consultas DNS para los registros `SOA`, `NS`, `A` y `CNAME`
    - Salida de los siguientes comandos en la máquina virtual como el usuario `root`

- Carpeta `img`
    - Capturas de pantalla donde se muestren los recursos creados en Azure (máquina virtual y zona DNS)
    - Capturas de pantalla donde se muestre el registro del nombre de dominio en FreeNom
    - Cada captura de pantalla tiene que ser referenciada en el archivo `README.md`

- Carpeta `files`
    - **Archivos de configuración**
        - Copia de seguridad de la configuración de Apache HTTPD en el directorio `/etc/apache2`

        ```
        root@example:~# tar -cvvf apache2.tar -C /etc/apache2 ./
        ```

        - Archivo `/etc/apache2/conf-available/security.conf` con comentarios que expliquen la funcionalidad de las directivas utilizadas

    - **Archivos de bitácora**
        - Archivo `salida-mkdocs.log` obtenido al convertir los archivos Markdown a HTML con `mkdocs`

        - Copia de seguridad de las bitácoras de Apache HTTPD

        ```
        root@example:~# tar -cvvzpf apache2-logs.tar.gz /var/log/apache2
        ```

    - **Archivos de datos**
        - Archivo `virtualhosts.txt` con el listado de VirtualHosts en la configuración de Apache HTTPD

        ```
        root@example:~# apachectl -S 2>&1 | tee virtualhosts.txt
        ```

        - Copia de seguridad del directorio `/var/www`

        ```
        root@example:~# tar -cvvf www.tar -C /var/www .
        ```

        - Copia de seguridad de los datos generados por `certbot`

        ```
        root@example:~# tar -cvvf letsencrypt.tar /etc/letsencrypt /var/lib/letsencrypt /var/log/letsencrypt
        ```

<br style="display: none; visibility: hidden;" />

- Archivo de datos `registros-dns.txt` donde vengan las consultas de todos los nombres DNS que generaste

| Nombre                | Tipo    | Valor                |
|----------------------:|:-------:|---------------------:|
|        `example.com.` | `A`     |     `20.213.120.169` |
|   `docs.example.com.` | `A`     |     `20.213.120.169` |
| `kernel.example.com.` | `A`     |     `20.213.120.169` |
|  `sitio.example.com.` | `CNAME` |       `example.com.` |
| `tareas.example.com.` | `CNAME` | `sitio.example.com.` |

???+ details "Consulta DNS"
    Puedes generar este archivo ejecutando [el _script_ de _shell_ `files/consulta-dns.sh`](files/consulta-dns.sh)

    <pre><code>
    usuario@laptop ~ % chmod +x consulta-dns.sh
    usuario@laptop ~ % ./consulta-dns.sh example.com 2>&1 | tee registros-dns.txt
    	...
    </code></pre>

<br style="display: none; visibility: hidden;" />

- Archivo de datos con el diagnóstico de consultas HTTP y HTTPS a la dirección IP y nombres DNS de los VirtualHosts

???+ details "Consulta HTTP"
    Puedes generar este archivo ejecutando [el _script_ de _shell_ `files/consulta-http.sh`](files/consulta-http.sh)

    <pre><code>
    usuario@laptop ~ % chmod +x consulta-http.sh
    usuario@laptop ~ % ./consulta-http.sh example.com 2>&1 | tee diagnostico-http.txt
    	...
    </code></pre>

<br style="display: none; visibility: hidden;" />

- Archivo de datos con el diagnóstico de certificados SSL que regresa cada VirtualHost configurado

???+ details "Consulta SSL"
    Puedes generar este archivo ejecutando [el _script_ de _shell_ `files/consulta-ssl.sh`](files/consulta-ssl.sh)

    <pre><code>
    usuario@laptop ~ % chmod -c +x consulta-ssl.sh
    usuario@laptop ~ % ./consulta-ssl.sh example.com 2>&1 | tee diagnostico-ssl.txt
    	...
    </code></pre>

--------------------------------------------------------------------------------

[flujo-de-trabajo]: https://redes-ciencias-unam.gitlab.io/2023-1/tareas-redes/workflow/
[repo-tareas]: https://gitlab.com/Redes-Ciencias-UNAM/2023-1/tareas-redes/-/merge_requests

[lista-redes]: https://tinyurl.com/Lista-Redes-2023-1

[playlist-https]: https://www.youtube.com/playlist?list=PLN1TFzSBXi3QGCMqARFoO1ePBX1P38erB
[video-protocolo-dns]: https://www.youtube.com/watch?v=r4PntflJs9E
[video-configuracion-ssh]: https://youtu.be/Hnu7BHBDcoM&t=1390
[video-configuracion-apache-debian]: https://youtu.be/XbQ_dBuERdM
[video-directivas-apache]: https://youtu.be/3JkQs3KcjxQ
[video-virtualhosts-apache-etc-hosts]: https://youtu.be/ZnqSNXIr-h4
[video-virtualhosts-apache-registros-dns]: https://youtu.be/JYo5rc4mhf0
[video-certificados-ssl-x509]: https://youtu.be/rXqkJi_FTuQ
[video-certificados-ssl-virtualhost-https-apache]: https://youtu.be/66dOHHD6L5I
[video-letsencrypt-certbot]: https://youtu.be/kpiChLT5JPs

[apache-docs]: https://httpd.apache.org/docs/2.4/
[apache-docs-config-sections]: https://httpd.apache.org/docs/2.4/sections.html
[apache-docs-security]: https://httpd.apache.org/docs/2.4/misc/security_tips.html
[apache-docs-server-wide]: https://httpd.apache.org/docs/2.4/server-wide.html
[apache-docs-url-rewrite]: https://httpd.apache.org/docs/2.4/rewrite/
[apache-docs-virtualhost]: https://httpd.apache.org/docs/2.4/vhosts/
[apache-docs-ssl]: https://httpd.apache.org/docs/2.4/ssl/
[apache-docs-htaccess]: https://httpd.apache.org/docs/2.4/howto/htaccess.html

[certbot-instructions-debian-10-buster]: https://certbot.eff.org/instructions?ws=apache&os=debianbuster
