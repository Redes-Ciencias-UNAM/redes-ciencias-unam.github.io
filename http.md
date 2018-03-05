# HyperText Transfer Protocol

## Puertos que utiliza en la _capa de transporte_

```sh
http			 80/tcp		www
https			443/tcp
```

## URL - Uniform Resource Locator

Es un identificador **global** que ayuda a ubicar un recurso en una red.
Los elementos especificados __entre corchetes__ (`[` y `]`) son opcionales.

```
protocolo:[//[usuario[:contraseña]@]servidor[:puerto]][/ruta][?argumentos][#fragmento]
```

Una URL se compone de los siguientes elementos:

```
  abcde://usuario:contraseña@example.com:12345/ruta/hacia/recurso?arg=valor#identificador
  └─┬─┘   └────────┬───────┘ └────┬────┘ └─┬─┘└────────┬────────┘ └───┬───┘ └─────┬─────┘
protocolo   autenticación     servidor  puerto       ruta           args      fragmento
```
| Elemento		| Descripción	|
|:---------------------:|:-------------:|
| Protocolo		| Identifica el protocolo a utilizar para la transmisión y recepción de datos	|
| Autenticación (`*`)	| Especifica las credenciales que deben ser enviadas para tener acceso al recurso	|
| Servidor		| Nombre de host, nombre DNS o dirección IP del servidor que hospeda el recurso	|
| Puerto (`*`)		| Puerto de conexión donde el servicio está en escucha	|
| Ruta			| Ruta donde se ubica el recurso	|
| Argumentos (`*`)	| Argumentos necesarios para obtener y desplegar el recurso solicitado	|
| Fragmento (`*`)	| Identificador utilizado para hacer referencia a una parte específica del documento solicitado	|

## Petición HTTP (_request_)

Son los datos que el **cliente** envía al servidor para solicitar el recurso

## Respuesta HTTP (_response_)

Son los datos que el **servidor** envía al cliente para entregar el recurso solicitado

## Cabecera y cuerpo

## Métodos HTTP

| Método	| Descripción	|
|:-------------:|:--------------|
| `OPTIONS`	| Muestra los _métodos_ disponibles en el servidor	|
| `HEAD`	| Pide que el servidor únicamente regrese las _cabeceras_ asociadas a la respuesta de la petición	|
| `GET`		| Pide un recurso y el servidor lo envía	|
| `POST`	| Manda información al servidor utilizando _formularios_ para establecer los _parámetros_ y _valores_ que se enviarán	|

| Método	| Petición		| Respuesta		|
|:-------------:|:---------------------:|:---------------------:|
| `OPTIONS`	| Cabeceras		| Cabeceras		|
| `HEAD`	| Cabeceras		| Cabeceras		|
| `GET`		| Cabeceras		| Cabeceras y Cuerpo	|
| `POST`	| Cabeceras y Cuerpo	| Cabeceras y Cuerpo	|

<!--
| Método	| Cabeceras de <br> _Petición_ | Cuerpo de <br> _Petición_ | Cabeceras de <br> _Respuesta_ | Cuerpo de <br> _Respuesta_ |
|:-------------:|:----------------------------:|:-------------------------:|:-----------------------------:|:--------------------------:|
| `OPTIONS`	|            ✓                 |         ✘                 |            ✓                  |         ✘                  |
| `HEAD`	|            ✓                 |         ✘                 |            ✓                  |         ✘                  |
| `GET`		|            ✓                 |         ✘                 |            ✓                  |         ✓                  |
| `POST`	|            ✓                 |         ✓                 |            ✓                  |         ✓                  |
-->


```
$ curl -v# 'http://www.example.com/'
* Hostname was NOT found in DNS cache
*   Trying 93.184.216.34...
* Connected to www.example.com (93.184.216.34) port 80 (#0)
> GET / HTTP/1.1
> User-Agent: curl/7.38.0
> Host: www.example.com
> Accept: */*
> 
< HTTP/1.1 200 OK
< Cache-Control: max-age=604800
< Content-Type: text/html
< Date: Thu, 01 Mar 2018 12:13:14 GMT
< Etag: "1541025663+ident"
< Expires: Thu, 07 Mar 2018 15:16:17 GMT
< Last-Modified: Fri, 09 Aug 2013 23:54:35 GMT
* Server ECS (ftw/FBE4) is not blacklisted
< Server: ECS (ftw/FBE4)
< Vary: Accept-Encoding
< X-Cache: HIT
< Content-Length: 1270
< 
<!DOCTYPE html>
<html>
  <head>
    <title>Example Domain</title>
    <meta charset="utf-8" />
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style type="text/css">
        /*	...	*/
    </style>    
  </head>
  <body>
    <div>
      <h1>Example Domain</h1>
      <p>
        This domain is established to be used for illustrative examples in documents. 
        You may use this domain in examples without prior coordination or asking for permission.
      </p>
      <p><a href="http://www.iana.org/domains/example">More information...</a></p>
    </div>
  </body>
</html>
* Connection #0 to host www.example.com left intact
```

## Códigos de estado

Cada vez que el cliente envía una petición al servidor, este incluye un _código de estado_ y un mensaje informativo en la **primer línea** de las _cabeceras de la respuesta_

| Código | Mensaje			| Descripción	|
|:------:|:----------------------------:|:-------------:|
| 	| <td colspan="2">**_Mensajes informativos_**</td>	|
| _1xx_	| (_varios mensajes_)		| Menciona al cliente que la información fue recibida correctamente	|
| 	| <td colspan="2">_**Códigos de éxito**_</td>	|
| 200	| `OK`				| El servidor recibió la petición correctamente y entrega una respuesta	|
| 	| <td colspan="2">_**Códigos de redirección**_</td>	|
| 301	| `Moved permanently`		| El servidor menciona que el recurso tiene una nueva URL definitiva	|
| 302	| `Found`			| El servidor indica que el recurso se encuentra por el momento en otra URL	|
| 	| <td colspan="2">_**Error del cliente**_</td>	|
| 400	| `Bad Request`			| El cliente ha enviado al servidor una petición inválida o mal formada	|
| 401	| `Authorization Required`	| El recurso requiere autenticación HTTP para ser mostrado	|
| 403	| `Forbidden`			| El recurso no puede ser mostrado por falta de privilegios de acceso	|
| 404	| `Not Found`			| El recurso no puede ser mostrado porque no fue encontrado	|
| 408	| `Request Timeout`		| El servidor no recibió la petición en el tiempo máximo de espera	|
| 	| <td colspan="2">_**Error del servidor**_</td>	|
| 500	| `Internal Server Error`	| Ocurrió un error interno del servidor y el recurso no puede ser mostrado	|
| 503	| `Service Unavailable`		| El servicio no está disponible	|

