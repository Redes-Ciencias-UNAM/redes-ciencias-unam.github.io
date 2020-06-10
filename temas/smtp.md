# Simple Mail Transfer Protocol

## Puertos que utiliza en la _capa de transporte_

```
smtp			 25/tcp		mail
urd			465/tcp		ssmtp smtps
submission		587/tcp
```

## ¿Cómo funciona?

||
|:------:|
|![](img/SMTP-001-Mail_delivery.png)|

--------------------------------------------------------------------------------

### Componentes

| Elemento				| Protocolo				| Descripción									| Software					|
|:-------------------------------------:|:-------------------------------------:|:------------------------------------------------------------------------------|:----------------------------------------------|
| **MUA**: Mail _User_ Agent		| SMTP					| Se encarga de **escribir**   el mensaje de correo electrónico			| Thunderbird, Mail.app, K9-mail, _webmail_, …	|
| **MSA**: Mail _Submission_ Agent	| SMTP					| Se encarga de **recibir**   el mensaje de correo electrónico			| Postfix, Sendmail, exim, qmail, …		|
| **MTA**: Mail _Transfer_ Agent	| SMTP(S)				| Se encarga de **transmitir** el mensaje de correo electrónico			| Postfix, Sendmail, exim, qmail, …		|
| **MDA**: Mail _Delivery_ Agent	| IMAP(S),POP3(S),SMTPS,Summission	| Se encarga de **entregar**   el mensaje de correo electrónico en el buzón	| Postfix, Sendmail, exim, qmail, …		|

--------------------------------------------------------------------------------

### Registros DNS

#### Registro MX - `M`ail e`X`changer

Se utiliza para especificar el o los servidores denominados **M**ail e**X**changers que son los encargados de **recibir** el correo para el dominio en cuestión.

| Nombre		| TTL	| Clase	| Tipo	| Prioridad	| Host	|
|:---------------------:|:-----:|:-----:|:-----:|:-------------:|:-----:|
| `example.com.`	| 3600	| IN	| MX	| 10            | `mail.example.com`	|
| `example.com.`	| 3600	| IN	| MX	| 20            | `192.0.2.1`	|
| `example.com.`	| 3600	| IN	| MX	| 20            | `2001:db8::1`	|

En este registro DNS el campo __valor__ es compuesto por 2 elementos:

* **Prioridad**: Indica el órden en el que se intenta entregar el correo a los servidores MX del dominio
* **Host**: Equipo designado como servidor MX para este dominio, se puede especificar un nombre DNS o dirección IPv4/IPv6

Es válido tener más de un registro MX para tener servidores MX de respaldo que reciban el correo entrante para el dominio DNS.

#### Registro SPF - `S`ender `P`olicy `F`ramework

Indica que direcciones o segmentos de IPv4 o IPv6 están autorizados para **enviar** correo como cierto dominio DNS.

Sólo puede existir **1** registro SPF por dominio DNS y este puede ser implementado como tipo `TXT` o `SPF`

| Nombre		| TTL	| Clase	| Tipo		| Valor	|
|:---------------------:|:-----:|:-----:|:-------------:|:-----:|
| `example.com.`	| 3600	| IN	| TXT o SPF	| `v=spf1 mx a ip4:192.0.2.0/24 ip6:2001:db8::/32 include:_spf.google.com include:amazonses.com ~all`	|

En este registro DNS el campo __valor__ es compuesto por varios elementos:

* **Identificador SPF**:
* **Equipos permitidos**:
  + `mx`: Marca al equipo MX del dominio como permitido para enviar correo
  + `a`:  Marca al equipo del registro A del domino (`example.com`) para enviar correo
  + `ip4:`: Indica que el equipo o el segmento IPv4 está permitido a enviar correo
  + `ip6:`: Indica que el equipo o el segmento IPv6 está permitido a enviar correo
  + `include:` Indica que se debe incluir la configuración de SPF de otro dominio (útil cuando se utilizan servicios de correo de terceros)
* **Acción predeterminada**:
  + `~all`: (Tílde = _Soft-fail_) Indica que el correo proveniente de otros equipos __puede__ ser catalogado como SPAM
  + `-all`: (Guión = _Hard-fail_) Indica que el correo proveniente de otros equipos __DEBE__  ser catalogado como SPAM

#### Registro DKIM - `D`omain `K`eys `I`dentified `M`ail

El estándar DKIM implementa el firmado digital de _cada_ mensaje que envía el servidor de correo, de tal manera que el destinatario pueda verificar la firma digital utilizando la llave pública que se ubica en el registro DNS `_domainkey`.

| Nombre				| TTL	| Clase	| Tipo	| Valor	|
|:-------------------------------------:|:-----:|:-----:|:-----:|:-----:|
| `<selector>._domainkey.example.com.`	| 3600	| IN	| TXT	| `"k=rsa; t=s; p=<valor>"`	|
| `<selector>._domainkey.example.com.`	| 3600	| IN	| CNAME	| `foo.dkim.example.net.`	|

Este registro `_domainkey` puede ser:

* **TXT**: Se publica la llave directamente
* **CNAME**: Se apunta al registro de un tercero que maneja la llave por su cuenta

Es válido tener más de un registro `_domainkey` para el dominio en cuestión siempre y cuando el `<selector>` sea diferente. Comúnmente se utiliza para autenticar los correos enviados por un servicio externo.

Dentro de las cabeceras del mensaje de correo electrónico se incluye el parámetro `s` que indica el selector que se usa para la verificación del registro DKIM:

```
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=example-com.19980928.dkimsmtp.com; s=<selector>;
        bh=<valor>;
        b=<valor>
```

#### Registro DMARC - `D`omain-based `M`essage `A`uthentication, `R`eporting and `C`onformance

Este estándar liga los conceptos de SPF y DKIM de tal manera que permite al administrador de un dominio DNS establecer criterios de validación de los mensajes de correo electrónico que provienen de su dominio y listar las acciones que se realizan para los mensajes que no puedan ser verificados correctamente (marcar como SPAM, rechazar, etc.)

El formato del registro DNS es el siguiente:

| Nombre				| TTL	| Clase	| Tipo	| Valor	|
|:-------------------------------------:|:-----:|:-----:|:-----:|:-----:|
| `_dmarc.example.com.`	| 3600	| IN	| TXT	| `"v=DMARC1;p=none;sp=quarantine;pct=100;rua=mailto:dmarc@example.com;"`	|

En este registro DNS el campo __valor__ es compuesto por varios elementos:

* `v`: Versión de DMARC
* `p`: Política de dominio
  - **none**: No establece una acción, utilizado para monitorear el estado de DMARC antes de aplicar una política restrictiva
  - **quarantine**: Envía los mensajes a cuarentena o los cataloga como SPAM
  - **reject**: El servidor de destino rechaza la recepción de los mensajes apócrifos y nunca son entregados al usuario
* `sp`: Política de subdominio, aplica lo mismo que en la _política de dominio_
* `pct`: Porcentaje de mensajes no validados después de los que se aplica la política
* `rua`: URI para envío de reportes de violaciones de DMARC

--------------------------------------------------------------------------------

### Prueba de SMTP __sin autenticación__

Esta prueba consiste en hacer una conexión **directa** al servidor MTA de destino:

||
|:------:|
|![](img/SMTP-002-Direct_delivery.png)|

Se necesita conocer el servidor que **recibe** el correo, este dato se guarda en el registro MX de DNS para ese dominio.

```
$ dig +all MX example.net.

	...

;; ANSWER SECTION:
example.net.		3600	IN	MX	10 mx.example.net

	...

```

Una vez teniendo el dato del servidor MX, se ejecuta el comando `swaks` para enviar un correo de prueba __sin utilizar autenticación SMTP__

```
$ swaks --to bob@example.net --server mx.example.net:25
=== Trying mx.example.net:25...
=== Connected to mx.example.net.
<-  220 mx.example.net ESMTP 012-3456789abcdef.0f - gsmtp
 -> EHLO hostname.example.local
<-  250-mx.example.net at your service, [198.51.100.0]
<-  250-SIZE 157286400
<-  250-8BITMIME
<-  250-STARTTLS
<-  250-ENHANCEDSTATUSCODES
<-  250-PIPELINING
<-  250-CHUNKING
<-  250 SMTPUTF8
 -> MAIL FROM: <alice@example.org>
<-  250 2.1.0 OK 012-3456789abcdef.0f - gsmtp
 -> RCPT TO: <bob@example.net>
<-  250 2.1.5 OK 012-3456789abcdef.0f - gsmtp
 -> DATA
<-  354  Go ahead 012-3456789abcdef.0f - gsmtp
 -> Date: Tue, 20 Mar 2020 18:19:20 -0600
 -> To: bob@example.net
 -> From: alice@example.org
 -> Subject: test Tue, 20 Mar 2020 18:19:20 -0600
 -> X-Mailer: swaks v20130209.0 jetmore.org/john/code/swaks/
 -> 
 -> This is a test mailing
 -> 
 -> .
<-  250 2.0.0 OK 1521592265 012-3456789abcdef.0f - gsmtp
 -> QUIT
<-  221 2.0.0 closing connection 012-3456789abcdef.0f - gsmtp
=== Connection closed with remote host.
```

El destinatario `bob@example.net` recibe un correo [parecido a este](files/mail.eml "Mensaje de correo electrónico enviado utilizando conexión directa al servidor SMTP de destino")

||
|:------:|
|![](img/SMTP-003-Envelope_message.png)|


```
Delivered-To: bob@example.net
Received: by 10.192.145.44 with SMTP id aaaaaaaaaaaaaaa;
        Tue, 20 Mar 2020 17:18:19 -0700 (PDT)

	...

Return-Path: <alice@example.org>
Received: from hostname.example.local ([198.51.100.0])
        by mx.example.net with ESMTP id 012-3456789abcdef.0f.2020.03.20.17.18.19
        for <bob@example.net>;
        Tue, 20 Mar 2020 17:18:19 -0700 (PDT)

	...

Message-Id: <5ab1a7c9.1c69fb81.99996.3682-SMTPIN_ADDED_MISSING@mx.example.net>
Date: Tue, 20 Mar 2020 18:19:20 -0600
To: bob@example.net
From: alice@example.org
Subject: test Tue, 20 Mar 2020 18:19:20 -0600
X-Mailer: swaks v20130209.0 jetmore.org/john/code/swaks/

This is a test mailing
```

--------------------------------------------------------------------------------

### Prueba de SMTP __con autenticación__

Esta prueba consiste en hacer una conexión al servidor MTA de **origen** especificando _nombre de usuario_ y _contraseña_, el servidor realiza la autenticación y recibe el mensaje, mismo que entrega al servidor de destino:

<img alt="Elementos de una conexión autenticada al servidor SMTP de origen (MTA)" src="img/smtp.png" />

Para enviar un mensaje de correo electrónico utilizando el servidor SMTP de la organización, se ejecuta `swaks` de la siguiente manera:

```
$ swaks --from alice@example.org --to bob@example.net --server smtp.example.org:587 -tls --auth PLAIN --auth-user alice@example.org --header-X-Test "TEST email"
```

| Argumento		| Descripción							|
|:-------------------------------------:|:---------------------------------------------:|
| `--from`		| Dirección del remitente					|
| `--to`		| Dirección del destinatario					|
| `--server`		| Servidor SMTP (MTA) del remitente y puerto de conexión	|
| `-tls`		| Establece que la conexión se realizará utilizando `STARTTLS`	|
| `--auth PLAIN`	| Establece el tipo de autenticación como `PLAIN`		|
| `--auth-user`		| Establece el usuario						|

Al ejecutar el programa `swaks` se produce una salida similar a la siguiente:

```
$ swaks --from alice@example.org --to bob@example.net --server smtp.example.org:587 -tls --auth PLAIN --auth-user alice@example.org --header-X-Test "TEST email"
Password: ********
=== Trying smtp.example.org:587...
=== Connected to smtp.gmail.com.
<-  220 smtp.example.org ESMTP 0123456789abcde.0 - gsmtp
 -> EHLO hostname.example.local
<-  250-smtp.example.org at your service, [192.0.2.1]
<-  250-SIZE 35882577
<-  250-8BITMIME
<-  250-STARTTLS
<-  250-ENHANCEDSTATUSCODES
<-  250-PIPELINING
<-  250-CHUNKING
<-  250 SMTPUTF8
 -> STARTTLS
<-  220 2.0.0 Ready to start TLS
=== TLS started with cipher TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128
=== TLS no local certificate set
=== TLS peer DN="/O=Internet Corporation for Assigned Names and Numbers/OU=Technology/CN=smtp.example.org"
 ~> EHLO hostname.example.local
<~  250-smtp.gmail.com at your service, [192.0.2.1]
<~  250-SIZE 35882577
<~  250-8BITMIME
<~  250-AUTH LOGIN PLAIN XOAUTH2 PLAIN-CLIENTTOKEN OAUTHBEARER XOAUTH
<~  250-ENHANCEDSTATUSCODES
<~  250-PIPELINING
<~  250-CHUNKING
<~  250 SMTPUTF8
 ~> AUTH PLAIN AGFsaWNlQGV4YW1wbGUub3JnAHBhc3N3b3Jk
<~  235 2.7.0 Accepted
 ~> MAIL FROM: <alice@example.org>
<~  250 2.1.0 OK 0123456789abcde.0 - gsmtp
 ~> RCPT TO: <bob@example.net>
<~  250 2.1.5 OK 0123456789abcde.0 - gsmtp
 ~> DATA
<~  354  Go ahead 0123456789abcde.0 - gsmtp
 ~> Date: Tue, 20 Mar 2020 19:20:21 -0600
 ~> To: bob@example.net
 ~> From: alice@example.org
 ~> Subject: test Tue, 20 Mar 2020 19:20:21 -0600
 ~> X-Mailer: swaks v20130209.0 jetmore.org/john/code/swaks/
 ~> X-Test: TEST email
 ~> 
 ~> This is a test mailing
 ~> 
 ~> .
<~  250 2.0.0 OK 1521588772 0123456789abcde.0 - gsmtp
 ~> QUIT
<~  221 2.0.0 closing connection 0123456789abcde.0 - gsmtp
=== Connection closed with remote host.
```

El destinatario `bob@example.net` recibe un correo [parecido a este](files/mail+auth.eml "Mensaje de correo electrónico enviado utilizando una conexión autenticada al servidor SMTP de origen")

```
Received: from DM5PR07MB3609.namprd07.prod.example.net (2603:10b6:4:60::32) by
 CY4PR07MB3606.namprd07.prod.example.net with HTTPS via
 DM5PR08CA0043.NAMPRD08.PROD.OUTLOOK.COM; Tue, 20 Mar 2020 23:32:54 +0000
Received: from SN1PR0701CA0056.namprd07.prod.example.net
 (2a01:111:e400:52fd::24) by DM5PR07MB3609.namprd07.prod.example.net
 (2603:10b6:4:68::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.588.14; Tue, 20
 Mar 2020 23:32:53 +0000
Received: from BN3NAM04FT030.eop-NAM04.prod.protection.example.net
 (2a01:111:f400:7e4e::201) by SN1PR0701CA0056.outlook.office365.com
 (2a01:111:e400:52fd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.609.10 via Frontend
 Transport; Tue, 20 Mar 2020 23:32:53 +0000

	...

Received: from mail-oi0-f51.example.org (209.85.218.51) by
 BN3NAM04FT030.mail.protection.example.net (10.152.92.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P256) id
 15.20.527.15 via Frontend Transport; Tue, 20 Mar 2020 23:32:53 +0000
Received: by mail-oi0-f51.example.org with SMTP id c12-v6so2876752oic.7
        for <bob@example.net>; Tue, 20 Mar 2020 16:32:53 -0700 (PDT)

	...

Return-Path: alice@example.org
Received: from hostname.example.local ([192.0.2.1])
        by smtp.example.org with ESMTPSA id x62sm1512255oig.0.2020.03.20.16.32.51
        for <bob@example.net>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Mar 2020 16:32:52 -0700 (PDT)
Message-ID: <5ab19a24.41e0ca0a.66253.9647@mx.example.org>
Date: Tue, 20 Mar 2020 17:18:19 -0600
To: bob@example.net
From: alice@example.org
Subject: test Tue, 20 Mar 2020 17:18:19 -0600
X-Mailer: swaks v20130209.0 jetmore.org/john/code/swaks/
X-Test: test email

	...

MIME-Version: 1.0

This is a test mailing

```

--------------------------------------------------------------------------------

#### Autenticación SMTP

+ La contraseña se transmite de manera _codificada_ utilizando `base64`

```
AUTH PLAIN AGFsaWNlQGV4YW1wbGUub3JnAHBhc3N3b3Jk
```

```
$ echo -ne "\0${email}\0${password}" | base64
```

+ Este proceso puede ser fácilmente revertido, porque __la contraseña no se cifra__

```
$ echo -n 'AGFsaWNlQGV4YW1wbGUub3JnAHBhc3N3b3Jk' | base64 -d
^@alice@example.org^@password

$ echo -n 'AGFsaWNlQGV4YW1wbGUub3JnAHBhc3N3b3Jk' | base64 -d | hexdump -C
00000000  00 61 6c 69 63 65 40 65  78 61 6d 70 6c 65 2e 6f  |.alice@example.o|
00000010  72 67 00 70 61 73 73 77  6f 72 64                 |rg.password     |
0000001b
```

--------------------------------------------------------------------------------

## Referencias

[SMTP-expect]: https://stackoverflow.com/a/36296872 ""

+ <https://scs.senecac.on.ca/~john.selmys/subjects/ops335-091/index.html>
+ <https://scs.senecac.on.ca/~john.selmys/subjects/ops335-091/howemailworks.png>
+ <https://scs.senecac.on.ca/~raymond.chan/ops535/1403/notes/how_email_works.html>
+ <https://scs.senecac.on.ca/~raymond.chan/images/how-email-works.png>
+ <https://scs.senecac.on.ca/~raymond.chan/images/email-delivery.png>
+ <https://scs.senecac.on.ca/~raymond.chan/images/mail-components.png>
+ <http://ccm.net/contents/116-how-email-works-mta-mda-mua>
+ <https://www.visiondesign.com/how-does-email-work-a-simple-illustrated-explanation/>
+ <https://i2.wp.com/www.visiondesign.com/wp-content/uploads/2010/02/illustration-how-email-works.jpg>
+ <https://www.oasis-open.org/khelp/kmlm/user_help/html/how_email_works.html>
+ <https://www.oasis-open.org/khelp/kmlm/user_help/html/images/howemailworks.png>
+ <https://runbox.com/email-school/how-email-works/>
+ <https://www.youtube.com/watch?v=YBzLPmx3xTU>
+ <https://www.youtube.com/watch?v=x28ciavQ4mI>
+ <https://www.thegeekstuff.com/2013/05/how-email-works/>
+ <https://web.stanford.edu/class/cs101/network-4-email.html>
+ <https://technet.microsoft.com/en-us/library/2005.11.howitworkssmtp.aspx>
+ <https://www.lehigh.edu/~inimr/computer-basics-tutorial/email.htm>
+ <https://www.lifewire.com/how-smtp-works-1166421>
+ <http://www.intelligentedu.com/computer_security_for_everyone/9-how-email-systems-work.html>
+ <https://support.dnsimple.com/articles/spf-record/>
+ <https://mxtoolbox.com/SPFRecordGenerator.aspx>
+ <https://www.dmarcanalyzer.com/spf/how-to-create-an-spf-txt-record/>
+ <https://dnspropagation.net/articles/spf-record-example/>
+ <https://support.google.com/a/answer/33786?hl=en>
+ <http://www.dkim.org/>
+ <https://www.dmarcanalyzer.com/DKIM/>
+ <https://securitytrails.com/blog/what-is-dkim>
+ <https://mxtoolbox.com/dkim.aspx>
+ <https://www.sparkpost.com/resources/email-explained/dkim-domainkeys-identified-mail/>
+ <https://www.dmarcanalyzer.com/dkim/dkim-check/>
+ <https://dmarc.org/overview/>
+ <https://www.dmarcanalyzer.com/how-to-create-a-dmarc-record/>
