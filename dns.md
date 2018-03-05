# Domain Name System

## Puertos que utiliza en la _capa de transporte_

```sh
$ getent services | grep domain
domain			53/udp
domain			53/tcp
```

## Registros

### Registro A

Se utiliza para asociar algún nombre de dominio con una dirección IPv4

| Nombre		| TTL	| Clase	| Tipo	| Valor |
|:---------------------:|:-----:|:-----:|:-----:|:-----:|
| `www.example.com.`	| 3600	| IN	| A	| `192.0.2.1`	|

### Registro AAAA

Se utiliza para asociar algún nombre de dominio con una dirección IPv6

| Nombre		| TTL	| Clase	| Tipo	| Valor |
|:---------------------:|:-----:|:-----:|:-----:|:-----:|
| `www.example.com.`	| 3600	| IN	| AAAA	| `2001:db8::1`	|

### Registro CNAME

Asocia un nombre de dominio con otro

| Nombre		| TTL	| Clase	| Tipo	| Valor |
|:---------------------:|:-----:|:-----:|:-----:|:-----:|
| `server.example.com.`	| 3600	| IN	| CNAME	| `web.example.net.`	|

### Registro PTR

Asocia una dirección IP con un nombre de dominio

#### Registro PTR para IPv4

Utiliza la zona inversa `in-addr.arpa.` y asigna los octetos en orden inverso con notación decimal

Se puede buscar la dirección IP en formato "normal" utilizando el parámetro `-x` de `dig`

```
$ dig +all -x 192.0.2.100
```

Se puede buscar la dirección IP convertida a nombre de dominio de la zona inversa `in-addr.arpa.`

```
$ dig +all 100.2.0.192.in-addr.arpa.
```

| Nombre		| TTL	| Clase	| Tipo	| Valor |
|:---------------------:|:-----:|:-----:|:-----:|:-----:|
| `100.2.0.192.in-addr.arpa.`	| 3600	| IN	| PTR	| `alpha.example.org.`	|

#### Registro PTR para IPv6

Utiliza la zona inversa `ip6.arpa.` y asigna los __nibbles__ en orden inverso con notación hexadecimal

Se puede buscar la dirección IP en formato "normal" utilizando el parámetro `-x` de `dig`

```
$ dig +all -x 2001:db8::1
```

Se puede buscar la dirección IP convertida a nombre de dominio de la zona inversa `ip6.arpa.`

```
$ dig +all 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa.
```

| Nombre		| TTL	| Clase	| Tipo	| Valor |
|:---------------------:|:-----:|:-----:|:-----:|:-----:|
| `1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa.`	| 3600	| IN	| PTR	| `omega.example.net.`	|

### Registro NS

+ También conocidos como __glue records__, son el elemento que liga a las zonas DNS entre sí
+ Lista a los servidores **autoritativos** para esa zona
+ Sirve para realizar __delegación__ de subzonas a otros servidores
+ El servidor "anterior" utiliza este registro guarda la referencia al siguiente
+ Es el concepto implícito mediante el cual funcionan las consultas DNS

| Nombre		| TTL	| Clase	| Tipo	| Valor |
|:---------------------:|:-----:|:-----:|:-----:|:-----:|
| `example.com.`	| 3600	| IN	| NS	| `ns1.example.com.`	|
| `example.com.`	| 3600	| IN	| NS	| `ns2.example.net.`	|
| `example.com.`	| 3600	| IN	| NS	| `ns3.example.org.`	|

## Archivo `/etc/resolv.conf`

+ <https://linux.die.net/man/5/resolv.conf>
+ <https://wiki.debian.org/resolv.conf>
+ <https://www.freebsd.org/cgi/man.cgi?query=resolv.conf>
+ <http://clfs.org/view/clfs-sysroot/arm/network/resolv.html>

```sh
# cat /etc/resolv.conf
nameserver 208.67.222.222
nameserver 208.67.220.220
```

## Archivo `/etc/hosts`

+ <https://linux.die.net/man/5/hosts>
+ <ftp://ftp.iitb.ac.in/LDP/en/solrhe/chap9sec95.html>
+ <https://support.rackspace.com/how-to/modify-your-hosts-file/>
+ <https://www.siteground.com/kb/how_to_use_the_hosts_file/>
+ <https://docs.acquia.com/article/using-etchosts-file-custom-domains-during-development>

```sh
# cat /etc/hosts
127.0.0.1	localhost
127.0.1.1	linux.local linux

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

## Búsquedas

### Búsqueda recursiva

+ El cliente le pregunta el registro al servidor
+ El servidor realiza la búsqueda iterativa preguntando a otros servidores
+ Regresa __el mejor resultado obtenido__
+ Respuesta no autoritativa

```
$ dig +all www.unam.mx.

; <<>> DiG 9.9.5-9+deb8u15-Debian <<>> +all www.unam.mx.
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12777
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.unam.mx.			IN	A

;; ANSWER SECTION:
www.unam.mx.		3077	IN	A	132.247.70.37

;; Query time: 44 msec
;; SERVER: 208.67.222.222#53(208.67.222.222)
;; WHEN: Tue Feb 13 16:53:11 CST 2018
;; MSG SIZE  rcvd: 56
```

### Búsqueda iterativa

+ El cliente pregunta por cada parte del registro a los servidores autoritativos para esa zona
+ Requiere varias consultas a múltiples servidores
+ El cliente pregunta por la raíz del espacio de nombres de DNS
  * Esta zona raíz tiene el dominio `root-servers.net`
  * Normalmente no es necesario preguntar por la zona raíz, ya que viene precargada en los clientes de DNS

```
$ dig +all NS .

; <<>> DiG 9.9.5-9+deb8u15-Debian <<>> +all NS .
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 16846
;; flags: qr rd ra; QUERY: 1, ANSWER: 13, AUTHORITY: 0, ADDITIONAL: 27

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;.				IN	NS

;; ANSWER SECTION:
.			109132	IN	NS	a.root-servers.net.
.			109132	IN	NS	b.root-servers.net.
.			109132	IN	NS	c.root-servers.net.
.			109132	IN	NS	d.root-servers.net.
.			109132	IN	NS	e.root-servers.net.
.			109132	IN	NS	f.root-servers.net.
.			109132	IN	NS	g.root-servers.net.
.			109132	IN	NS	h.root-servers.net.
.			109132	IN	NS	i.root-servers.net.
.			109132	IN	NS	j.root-servers.net.
.			109132	IN	NS	k.root-servers.net.
.			109132	IN	NS	l.root-servers.net.
.			109132	IN	NS	m.root-servers.net.

;; ADDITIONAL SECTION:
a.root-servers.net.     368328  IN      A       198.41.0.4
a.root-servers.net.     242234  IN      AAAA    2001:503:ba3e::2:30
b.root-servers.net.     172541  IN      A       199.9.14.201
b.root-servers.net.     172541  IN      AAAA    2001:500:200::b
c.root-servers.net.     172541  IN      A       192.33.4.12
c.root-servers.net.     172541  IN      AAAA    2001:500:2::c
d.root-servers.net.     172541  IN      A       199.7.91.13
d.root-servers.net.     172541  IN      AAAA    2001:500:2d::d
e.root-servers.net.     172541  IN      A       192.203.230.10
e.root-servers.net.     172541  IN      AAAA    2001:500:a8::e
f.root-servers.net.     172541  IN      A       192.5.5.241
f.root-servers.net.     172541  IN      AAAA    2001:500:2f::f
g.root-servers.net.     172541  IN      A       192.112.36.4
g.root-servers.net.     172541  IN      AAAA    2001:500:12::d0d
h.root-servers.net.     172541  IN      A       198.97.190.53
h.root-servers.net.     172541  IN      AAAA    2001:500:1::53
i.root-servers.net.     172541  IN      A       192.36.148.17
i.root-servers.net.     172541  IN      AAAA    2001:7fe::53
j.root-servers.net.     172541  IN      A       192.58.128.30
j.root-servers.net.     172541  IN      AAAA    2001:503:c27::2:30
k.root-servers.net.     172541  IN      A       193.0.14.129
k.root-servers.net.     172541  IN      AAAA    2001:7fd::1
l.root-servers.net.     172541  IN      A       199.7.83.42
l.root-servers.net.     172541  IN      AAAA    2001:500:9f::42
m.root-servers.net.     172541  IN      A       202.12.27.33
m.root-servers.net.     172541  IN      AAAA    2001:dc3::35

;; Query time: 2 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Tue Feb 13 16:38:02 CST 2018
;; MSG SIZE  rcvd: 811
```

+ El cliente pregunta por la __primer__ parte del nombre DNS a alguno de los servidores raíz

```
$ dig +all NS mx. a.root-servers.net.

; <<>> DiG 9.9.5-9+deb8u15-Debian <<>> +all NS mx. a.root-servers.net.
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 13130
;; flags: qr rd ra; QUERY: 1, ANSWER: 6, AUTHORITY: 0, ADDITIONAL: 9

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;mx.				IN	NS

;; ANSWER SECTION:
mx.			86400	IN	NS	m.mx-ns.mx.
mx.			86400	IN	NS	e.mx-ns.mx.
mx.			86400	IN	NS	x.mx-ns.mx.
mx.			86400	IN	NS	i.mx-ns.mx.
mx.			86400	IN	NS	c.mx-ns.mx.
mx.			86400	IN	NS	o.mx-ns.mx.

;; ADDITIONAL SECTION:
m.mx-ns.mx.		97448	IN	A	200.94.176.1
m.mx-ns.mx.		110581	IN	AAAA	2001:13c7:7000::1
e.mx-ns.mx.		97448	IN	A	189.201.244.1
x.mx-ns.mx.		97448	IN	A	201.131.252.1
i.mx-ns.mx.		97448	IN	A	207.248.68.1
c.mx-ns.mx.		97448	IN	A	192.100.224.1
c.mx-ns.mx.		158141	IN	AAAA	2001:1258::1
o.mx-ns.mx.		97448	IN	A	200.23.1.1

;; Query time: 55 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Tue Feb 13 16:36:25 CST 2018
;; MSG SIZE  rcvd: 285

;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 47526
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;a.root-servers.net.		IN	NS

;; AUTHORITY SECTION:
root-servers.net.	10800	IN	SOA	a.root-servers.net. nstld.verisign-grs.com. 2018013000 14400 7200 1209600 3600000

;; Query time: 74 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Tue Feb 13 16:36:25 CST 2018
;; MSG SIZE  rcvd: 105
```

+ El cliente pregunta por la __segunda__ parte del dominio a alguno de los servidores NS de la zona `mx.`

```
$ dig +all unam.mx. @i.mx-ns.mx.

; <<>> DiG 9.9.5-9+deb8u15-Debian <<>> +all unam.mx. @i.mx-ns.mx.
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 19690
;; flags: qr rd; QUERY: 1, ANSWER: 0, AUTHORITY: 2, ADDITIONAL: 5
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;unam.mx.			IN	A

;; AUTHORITY SECTION:
unam.mx.		86400	IN	NS	ns3.unam.mx.
unam.mx.		86400	IN	NS	ns4.unam.mx.

;; ADDITIONAL SECTION:
ns3.unam.mx.		86400	IN	A	132.248.108.215
ns3.unam.mx.		86400	IN	AAAA	2001:1218:100:10a:108::215
ns4.unam.mx.		86400	IN	A	132.248.204.32
ns4.unam.mx.		86400	IN	AAAA	2001:1218:403:203:204::32

;; Query time: 53 msec
;; SERVER: 207.248.68.1#53(207.248.68.1)
;; WHEN: Tue Feb 13 16:39:55 CST 2018
;; MSG SIZE  rcvd: 160
```

+ El cliente pregunta por la siguiente parte del nombre de dominio al servidor autoritativo

```
$ dig +all www.unam.mx. @ns3.unam.mx.

; <<>> DiG 9.9.5-9+deb8u15-Debian <<>> +all www.unam.mx. @ns3.unam.mx.
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 48227
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 5, ADDITIONAL: 8
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.unam.mx.			IN	A

;; ANSWER SECTION:
www.unam.mx.		7200	IN	A	132.247.70.37

;; AUTHORITY SECTION:
unam.mx.		7200	IN	NS	ns1.unam.mx.
unam.mx.		7200	IN	NS	ns4.unam.mx.
unam.mx.		7200	IN	NS	ns5.unam.mx.
unam.mx.		7200	IN	NS	ns3.unam.mx.
unam.mx.		7200	IN	NS	ns2.unam.mx.

;; ADDITIONAL SECTION:
ns1.unam.mx.		7200	IN	A	132.248.108.221
ns2.unam.mx.		7200	IN	A	132.248.204.25
ns3.unam.mx.		7200	IN	A	132.248.108.215
ns3.unam.mx.		7200	IN	AAAA	2001:1218:100:10a:108::215
ns4.unam.mx.		7200	IN	A	132.248.204.32
ns4.unam.mx.		7200	IN	AAAA	2001:1218:403:203:204::32
ns5.unam.mx.		7200	IN	A	132.248.243.37

;; Query time: 67 msec
;; SERVER: 132.248.108.215#53(132.248.108.215)
;; WHEN: Tue Feb 13 16:42:33 CST 2018
;; MSG SIZE  rcvd: 282
```

+ <https://howdns.works/>
+ <http://networktools.he.net/>
+ <https://linux.die.net/man/1/dig>
+ <https://linux.die.net/man/1/host>
