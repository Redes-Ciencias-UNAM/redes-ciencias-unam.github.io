# Tarea SSL

## Instrucciones

Esta tarea debe ser entregada de manera **personal**

### 0. Localizar Crear la carpeta `tareas`

Localizar el dominio DNS _utilizado en las tareas anteriores_

  + Ver el archivo `tareas/dominio.txt`
  + Utilizar la [lista del grupo][ListaRedes-2018-2]

Localizar el archivo `tareas/ip.txt`

### 1. Verificar que el sitio web elegido soporte la conexión por HTTPS

Intentar establecer una conexión al puerto 443 utilizando `netcat`

```
$ nc -vz www.unam.mx 443
Warning: inverse host lookup failed for 132.247.70.37: Unknown host
www.unam.mx [132.247.70.37] 443 (https) open
```

Utilizar `curl` para revisar que el sitio soporta HTTPS:

```
$ curl -vk#0X HEAD 'https://www.unam.mx/' 2>&1 | tee https.log
* Hostname was NOT found in DNS cache
*   Trying 132.247.70.37...
* Connected to www.unam.mx (132.247.70.37) port 443 (#0)
* successfully set certificate verify locations:
*   CAfile: none
  CApath: /etc/ssl/certs
* SSLv3, TLS handshake, Client hello (1):
* SSLv3, TLS handshake, Server hello (2):
* SSLv3, TLS handshake, CERT (11):
* SSLv3, TLS handshake, Server key exchange (12):
* SSLv3, TLS handshake, Server finished (14):
* SSLv3, TLS handshake, Client key exchange (16):
* SSLv3, TLS change cipher, Client hello (1):
* SSLv3, TLS handshake, Finished (20):
* SSLv3, TLS change cipher, Client hello (1):
* SSLv3, TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-AES256-GCM-SHA384
* Server certificate:
* 	 subject: businessCategory=Government Entity; serialNumber=Government Entities; 1.3.6.1.4.1.311.60.2.1.3=MX; C=MX; ST=Ciudad de Mexico; L=Coyoacan; street=Avenida Universidad 3000; OU=DGTIC; O=Universidad Nacional Autonoma de Mexico; CN=www.unam.mx
* 	 start date: 2017-05-18 17:22:02 GMT
* 	 expire date: 2018-09-12 23:11:02 GMT
* 	 subjectAltName: www.unam.mx matched
* 	 issuer: C=BE; O=GlobalSign nv-sa; CN=GlobalSign Extended Validation CA - SHA256 - G3
* 	 SSL certificate verify ok.
> HEAD / HTTP/1.0
> User-Agent: curl/7.38.0
> Host: www.unam.mx
> Accept: */*
> 
< HTTP/1.1 200 OK
< Date: Tue, 13 Mar 2018 07:16:34 GMT
* Server Apache is not blacklisted
< Server: Apache
< X-Drupal-Cache: HIT
< Etag: "1520917028-0"
< Content-Language: es
< X-UA-Compatible: IE=edge,chrome=1
< Link: <https://www.unam.mx/inicio>; rel="canonical",<https://www.unam.mx/inicio>; rel="shortlink"
< Cache-Control: public, max-age=3600
< Last-Modified: Tue, 13 Mar 2018 04:57:08 GMT
< Expires: Sun, 19 Nov 1978 05:00:00 GMT
< Vary: Cookie,Accept-Encoding
< Connection: close
< Content-Type: text/html; charset=utf-8
< 
* SSLv3, TLS alert, Client hello (1):
* Closing connection 0
* SSLv3, TLS alert, Client hello (1):
```

### 2. Utilizar `s_client` para extraer el certificado del servidor

Con un comando parecido a este guardar toda la salida de `openssl s_client` en el archivo `showcerts.log`

```
$ openssl s_client -connect 132.247.70.37:443 -servername www.unam.mx -showcerts < /dev/null 2>&1 | tee showcerts.log
depth=2 OU = GlobalSign Root CA - R3, O = GlobalSign, CN = GlobalSign
verify return:1
depth=1 C = BE, O = GlobalSign nv-sa, CN = GlobalSign Extended Validation CA - SHA256 - G3
verify return:1
depth=0 businessCategory = Government Entity, serialNumber = Government Entities, 1.3.6.1.4.1.311.60.2.1.3 = MX, C = MX, ST = Ciudad de Mexico, L = Coyoacan, street = Avenida Universidad 3000, OU = DGTIC, O = Universidad Nacional Autonoma de Mexico, CN = www.unam.mx
verify return:1
CONNECTED(00000003)
---
Certificate chain
 0 s:/businessCategory=Government Entity/serialNumber=Government Entities/1.3.6.1.4.1.311.60.2.1.3=MX/C=MX/ST=Ciudad de Mexico/L=Coyoacan/street=Avenida Universidad 3000/OU=DGTIC/O=Universidad Nacional Autonoma de Mexico/CN=www.unam.mx
   i:/C=BE/O=GlobalSign nv-sa/CN=GlobalSign Extended Validation CA - SHA256 - G3
-----BEGIN CERTIFICATE-----

	...

-----END CERTIFICATE-----
 1 s:/C=BE/O=GlobalSign nv-sa/CN=GlobalSign Extended Validation CA - SHA256 - G3
   i:/OU=GlobalSign Root CA - R3/O=GlobalSign/CN=GlobalSign
-----BEGIN CERTIFICATE-----

	...

-----END CERTIFICATE-----
 2 s:/OU=GlobalSign Root CA - R3/O=GlobalSign/CN=GlobalSign
   i:/OU=GlobalSign Root CA - R3/O=GlobalSign/CN=GlobalSign
-----BEGIN CERTIFICATE-----

	...

-----END CERTIFICATE-----
---
Server certificate
subject=/businessCategory=Government Entity/serialNumber=Government Entities/1.3.6.1.4.1.311.60.2.1.3=MX/C=MX/ST=Ciudad de Mexico/L=Coyoacan/street=Avenida Universidad 3000/OU=DGTIC/O=Universidad Nacional Autonoma de Mexico/CN=www.unam.mx
issuer=/C=BE/O=GlobalSign nv-sa/CN=GlobalSign Extended Validation CA - SHA256 - G3
---
No client certificate CA names sent
---
SSL handshake has read 4746 bytes and written 435 bytes
---
New, TLSv1/SSLv3, Cipher is ECDHE-RSA-AES256-GCM-SHA384
Server public key is 2048 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : ECDHE-RSA-AES256-GCM-SHA384
    Session-ID: 3D99465F7B59B5D3325560EFACF6AAC0A91AC470445EF363F35F250E36BA67F6
    Session-ID-ctx: 
    Master-Key: AE96B9AFCB4E6FDB6F2EE5063CC517FDDD938986196440CFF513F26E8C5AE1BA8682F0B467B3F0468BCBD5B09D995271
    Key-Arg   : None
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 300 (seconds)
    TLS session ticket:
    Start Time: 1520930198
    Timeout   : 300 (sec)
    Verify return code: 0 (ok)
---
DONE
```

Tomar el archivo de salida `showcerts.log` y separar cada certificado en un archivo diferente (`certificate-00.pem` ... `certificate-##.pem`)

```
$ ls -l certificate-??.pem
-rw-r--r-- 1 tonejito users 2813 Mar 13 08:36 certificate-00.pem
-rw-r--r-- 1 tonejito users 1578 Mar 13 08:36 certificate-01.pem
-rw-r--r-- 1 tonejito users 1229 Mar 13 08:36 certificate-02.pem

$ file certificate-??.pem
certificate-00.pem: PEM certificate
certificate-01.pem: PEM certificate
certificate-02.pem: PEM certificate
```

### 3. Extraer la información de los certificados utilizando `x509`

Tomar cada certificado `.pem` y extraer la información de cada uno con `openssl x509`

```
$ openssl x509 -in certificate-00.pem -noout -text 2>&1 | tee certificate-00.pem.log

	...

```

```
$ ls -l certificate-??.pem certificate-??.pem.log
-rw-r--r-- 1 tonejito users 2813 Mar 13 08:36 certificate-00.pem
-rw-r--r-- 1 tonejito users 1578 Mar 13 08:36 certificate-01.pem
-rw-r--r-- 1 tonejito users 1229 Mar 13 08:36 certificate-02.pem
-rw-r--r-- 1 tonejito users 4718 Mar 13 09:13 certificate-00.pem.log
-rw-r--r-- 1 tonejito users 3583 Mar 13 09:13 certificate-01.pem.log
-rw-r--r-- 1 tonejito users 3026 Mar 13 09:13 certificate-02.pem.log

$ file certificate-??.pem certificate-??.pem.log
certificate-00.pem:     PEM certificate
certificate-01.pem:     PEM certificate
certificate-02.pem:     PEM certificate
certificate-00.pem.log: ASCII text, with CR, LF line terminators
certificate-01.pem.log: ASCII text
certificate-02.pem.log: ASCII text
```

### 4. Validar manualmente el certificado del servidor

Identificar cual certificado pertenece al servidor:

```
$ openssl x509 -in certificate-00.pem -noout -issuer -subject
issuer= /C=BE/O=GlobalSign nv-sa/CN=GlobalSign Extended Validation CA - SHA256 - G3
subject= /businessCategory=Government Entity/serialNumber=Government Entities/jurisdictionC=MX/C=MX/ST=Ciudad de Mexico/L=Coyoacan/street=Avenida Universidad 3000/OU=DGTIC/O=Universidad Nacional Autonoma de Mexico/CN=www.unam.mx

$ openssl x509 -in certificate-01.pem -noout -issuer -subject
issuer= /OU=GlobalSign Root CA - R3/O=GlobalSign/CN=GlobalSign
subject= /C=BE/O=GlobalSign nv-sa/CN=GlobalSign Extended Validation CA - SHA256 - G3

$ openssl x509 -in certificate-02.pem -noout -issuer -subject
issuer= /OU=GlobalSign Root CA - R3/O=GlobalSign/CN=GlobalSign
subject= /OU=GlobalSign Root CA - R3/O=GlobalSign/CN=GlobalSign
```

Hacer una liga simbólica que apunte a el:

```
$ ln -vs certificate-00.pem www_unam_mx.pem
‘www_unam_mx.pem’ -> ‘certificate-00.pem’
```

Juntar los certificados **que no son del servidor** en un archivo llamado `chain.pem`

```
$ cat certificate-01.pem certificate-02.pem ... > chain.pem
```

Utilizar `openssl verify` para verificar la validez y autenticidad del certificado del servidor

```
$ openssl verify -verbose -x509_strict -CApath /etc/ssl/certs/ -trusted chain.pem www_unam_mx.pem 
www_unam_mx.pem: OK
```

#### Error al verificar

Si aparece un error parecido al siguiente y la opción `-trusted` no sirve:

```
$ openssl verify -verbose -x509_strict -CApath /etc/ssl/certs/ -trusted chain.crt www_example_org.crt
www_example_org.crt: DN="/O=Internet Corporation for Assigned Names and Numbers/OU=Technology/CN=www.example.org"
error 2 at 1 depth lookup:unable to get issuer certificate
```

Intentar con la opción `-untrusted`:

```
$ openssl verify -verbose -x509_strict -CApath /etc/ssl/certs/ -untrusted chain.crt www_example_org.crt
www_example_org.crt: OK
```

Leer la página de _man_ de verify(1) (`man 1 verify`) y justificar por que se cambió la opción de línea de comandos.

+ <https://manpages.debian.org/jessie/openssl/verify.1ssl.en.html>
+ <http://manpages.ubuntu.com/manpages/xenial/en/man1/verify.1ssl.html>
+ <https://linux.die.net/man/1/verify>
+ <http://man.he.net/?topic=verify&section=1>

### Notas

Mencionar cómo es que se realiza la validación de los certificados y qué función realizan la ruta `/etc/ssl/certs` y el archivo `chain.pem`

[ListaRedes-2018-2]: http://tinyurl.com/ListaRedes-2018-2 "Lista Redes Semestre 2018-2"
