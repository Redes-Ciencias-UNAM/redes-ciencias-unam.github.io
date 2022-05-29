---
title: Configuración de SSL/TLS en Apache HTTPD
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Configuración de SSL/TLS en Apache HTTPD

## Habilita el módulo y VirtualHost de SSL

```
root@example:~# a2enmod ssl

root@example:~# a2ensite default-ssl
```

Verifica que la configuración sea correcta y reinicia el servicio de Apache HTTPD

```
root@example:~# apachectl -t
Syntax OK

root@example:~# systemctl restart apache2
```

Revisa los archivos de VirtualHosts habilitados en Apache HTTPD

```
root@example:~# ls -la /etc/apache2/sites-enabled
total 8
drwxr-xr-x 2 root root 4096 May 29 02:02 .
drwxr-xr-x 8 root root 4096 May 29 02:02 ..
lrwxrwxrwx 1 root root   35 May 29 02:02 000-default.conf -> ../sites-available/000-default.conf
lrwxrwxrwx 1 root root   35 May 29 02:02 default-ssl.conf -> ../sites-available/default-ssl.conf
```

Revisa que Apache escuche en los puertos `80` y `443`

```
root@example:~# netstat -ntulp | grep apache2
tcp6	0	0	:::80	:::*	LISTEN	16384/apache2
tcp6	0	0	:::443	:::*	LISTEN	16384/apache2

root@example:~# apachectl -S
VirtualHost configuration:
*:80                   example.com (/etc/apache2/sites-enabled/000-default.conf:1)
*:443                  example.com (/etc/apache2/sites-enabled/default-ssl.conf:2)
	...
```

## Configura los VirtualHosts predeterminados

Edita los archivos de VirtualHost y reemplaza la definición para que queden de la siguiente manera

VirtualHost de HTTP: `/etc/apache2/sites-enabled/000-default.conf`

- `<VirtualHost *:80>` ⇨ `<VirtualHost _default_:80>`

VirtualHost de HTTPS: `/etc/apache2/sites-enabled/default-ssl.conf`

- `<VirtualHost *:443>` ⇨ `<VirtualHost _default_:443>`

Recarga el servicio de Apache HTTPD

```
root@example:~# systemctl reload apache2
```

Revisa cual es la ruta de la raíz del sitio web en los VirtualHost predeterminados

```
root@example:~# grep 'DocumentRoot' /etc/apache2/sites-enabled/*.conf
/etc/apache2/sites-enabled/000-default.conf:	DocumentRoot /var/www/html
/etc/apache2/sites-enabled/default-ssl.conf:		DocumentRoot /var/www/html
```

--------------------------------------------------------------------------------

## Tramita el certificado SSL con Let's Encrypt

Instala `certbot` en el equipo

```
root@example:~# apt -qy install certbot python3-certbot-apache
	...
```

Genera un certificado _wildcard_ SSL con `certbot` que cumpla con las siguientes características

  - Subject CN = `example.com`
  - Subject Alt name: `example.com`
  - Subject Alt name: `*.example.com`

Ejecuta `certbot` en el equipo para generar el certificado SSL con Let's Encrypt

  - Adjunta la salida del comando `certbot` en tu reporte de la práctica

```
root@example:~# certbot --authenticator manual --installer apache --domain 'example.com' --domain '*.example.com'
```

### Valida el servidor y dominio DNS con **ACME**

Let's Encrypt pide que valides el dominio de dos maneras:

- Con un archivo dentro de la ruta `/.well-known/acme-challenge` bajo el `DocumentRoot`
    - Esta ruta es `/var/www/html/.well-known/acme-challenge` en los VirtualHost predeterminados
    - Puedes validar la existencia del archivo de validación con `curl` desde tu computadora

```
usuario@laptop ~ % curl -v http://example.com/.well-known/acme-challenge/NOMBRE_DEL_ARCHIVO_PARA_VALIDACIÓN
	...
```

- Con un registro DNS de tipo `TXT` llamado `_acme-challenge.example.com.`

    - Puedes validar el valor asociado al registro DNS con `dig` desde tu computadora

```
usuario@laptop ~ % dig TXT _acme-challenge.example.com.
	...
```
!!! warning
    Necesitas validar correctamente los dos pasos anteriores antes de continuar con el trámite del certificado SSL

### Redirige el tráfico HTTP a HTTPS

El programa `certbot` pregunta si quieres redirigir el tráfico de HTTP hacia HTTPS

  - Acepta esta opción para que se haga la configuración para todos los VirtualHosts de HTTP presentes en Apache HTTPD

Verifica que tengas el certificado y la llave privada en `/etc/letsencrypt`

```
root@example:~# apt -qqy install tree
	...

root@example:~# tree /etc/letsencrypt/archive
/etc/letsencrypt/archive
└── example.com
    ├── cert1.pem
    ├── chain1.pem
    ├── fullchain1.pem
    └── privkey1.pem

1 directory, 4 files

root@example:~# tree /etc/letsencrypt/live
/etc/letsencrypt/live
├── README
└── example.com
    ├── cert.pem -> ../../archive/example.com/cert1.pem
    ├── chain.pem -> ../../archive/example.com/chain1.pem
    ├── fullchain.pem -> ../../archive/example.com/fullchain1.pem
    ├── privkey.pem -> ../../archive/example.com/privkey1.pem
    └── README

1 directory, 6 files
```

Verifica que se estén utilizando los certificados de Let's Encrypt en tu VirtualHost de HTTPS

```
root@example:~# egrep -i '^\s*SSLCertificate(Key)?File' /etc/apache2/sites-enabled/*.conf
/etc/apache2/sites-enabled/default-ssl.conf:SSLCertificateFile    /etc/letsencrypt/live/example.com/fullchain.pem
/etc/apache2/sites-enabled/default-ssl.conf:SSLCertificateKeyFile /etc/letsencrypt/live/example.com/privkey.pem
```

!!! note
    Te invitamos a leer el _fabuloso_ man:

    - `certbot --help`
    - `certbot --help all`
    - <https://certbot.eff.org/docs/using.html#manual>

--------------------------------------------------------------------------------

## Verificar configuración

Reinicia el equipo para verificar que los cambios sean persistentes

```
root@example:~# reboot
```

!!! danger
    - Verifica que **TODAS** las configuraciones que hiciste estén presentes respués de reiniciar la máquina antes de continuar con la siguiente sección

!!! note
    - Continúa en [la siguiente página](../virtual-hosts) si ya configuraste el módulo SSL en Apache HTTPD y ya tienes el certificado SSL de Let's Encrypt configurado en tu VirtualHost de HTTPS

--------------------------------------------------------------------------------
