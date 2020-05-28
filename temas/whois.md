# WHOIS

* a.k.a. [RFC-3912](https://tools.ietf.org/html/rfc3912)

```
$ getent services | grep whois
whois                 43/tcp nicname
```

||
|:------:|
|![](img/WHOIS-001-Database.png)|

||
|:------:|
|![](img/WHOIS-002-Register_domain.png)|

||
|:------:|
|![](img/WHOIS-003-Glue_records.png)|

--------------------------------------------------------------------------------

## Consultar la información de un nombre de dominio

```
$ whois unam.mx.

% IANA WHOIS server
% for more information on IANA, visit http://www.iana.org
% This query returned 1 object

refer:        whois.mx

domain:       MX

organisation: NIC-Mexico
organisation: ITESM - Campus Monterrey
address:      Av. Eugenio Garza Sada 427 Loc. 4, 5, 6
address:      Monterrey Nuevo Leon 64840
address:      Mexico

contact:      administrative
name:         POC ADM IANA
organisation: NIC-Mexico, ITESM - Campus Monterrey
address:      Av. Eugenio Garza Sada 427 Loc. 4, 5, 6
address:      Monterrey Nuevo Leon 64840
address:      Mexico
phone:        +52 (81) 8864 2600
fax-no:       +52 (81) 8864 2600
e-mail:       adm-iana@nic.mx

contact:      technical
name:         POC TECH IANA
organisation: NIC-Mexico, ITESM - Campus Monterrey
address:      Av. Eugenio Garza Sada 427 Loc. 4, 5, 6
address:      Monterrey Nuevo Leon 64840
address:      Mexico
phone:        +52 (81) 8864 2600
fax-no:       +52 (81) 8864 2600
e-mail:       tech-iana@nic.mx

nserver:      C.MX-NS.MX 192.100.224.1 2001:1258:0:0:0:0:0:1
nserver:      E.MX-NS.MX 189.201.244.1
nserver:      I.MX-NS.MX 207.248.68.1
nserver:      M.MX-NS.MX 200.94.176.1 2001:13c7:7000:0:0:0:0:1
nserver:      O.MX-NS.MX 200.23.1.1
nserver:      X.MX-NS.MX 201.131.252.1
ds-rdata:     61382 8 2 0FA4420673F1B728F8612C61F3C225DF1E64400044468581DD8CA7DCAFDCA663

whois:        whois.mx

status:       ACTIVE
remarks:      Registration information: http://www.registry.mx/

created:      1989-02-01
changed:      2019-06-26
source:       IANA


Domain Name:       unam.mx

Created On:        1989-03-31
Expiration Date:   2021-03-30
Last Updated On:   2020-03-27
Registrar:         Akky (Una division de NIC Mexico)
URL:               http://www.akky.mx
Whois TCP URI:     whois.akky.mx
Whois Web URL:     http://www.akky.mx/jsf/whois/whois.jsf

Registrant:
   Name:           UNAM
   City:           Mexico
   State:          Distrito Federal
   Country:        Mexico

Administrative Contact:
   Name:           FELIPE BRACHO CARPIZO
   City:           Mexico
   State:          Ciudad de Mexico
   Country:        Mexico

Technical Contact:
   Name:           ALEJANDRO CRUZ SANTOS
   City:           Mexico
   State:          Ciudad de Mexico
   Country:        Mexico

Billing Contact:
   Name:           ALEJANDRO CRUZ SANTOS
   City:           Mexico
   State:          Ciudad de Mexico
   Country:        Mexico

Name Servers:
   DNS:            ns3.unam.mx       132.248.108.215, 2001:1218:100:10a:108:0:0:215
   DNS:            ns4.unam.mx       132.248.204.32, 2001:1218:403:203:204:0:0:32

DNSSEC DS Records:


% NOTICE: The expiration date displayed in this record is the date the
% registrar's sponsorship of the domain name registration in the registry is
% currently set to expire. This date does not necessarily reflect the
% expiration date of the domain name registrant's agreement with the sponsoring
% registrar. Users may consult the sponsoring registrar's Whois database to
% view the registrar's reported date of expiration for this registration.

% The requested information ("Information") is provided only for the delegation
% of domain names and the operation of the DNS administered by NIC Mexico.

% It is absolutely prohibited to use the Information for other purposes,
% including sending not requested emails for advertising or promoting products
% and services purposes (SPAM) without the authorization of the owners of the
% Information and NIC Mexico.

% The database generated from the delegation system is protected by the
% intellectual property laws and all international treaties on the matter.

% If you need more information on the records displayed here, please contact us
% by email at ayuda@nic.mx .

% If you want notify the receipt of SPAM or unauthorized access, please send a
% email to abuse@nic.mx .

% NOTA: La fecha de expiracion mostrada en esta consulta es la fecha que el
% registrar tiene contratada para el nombre de dominio en el registry. Esta
% fecha no necesariamente refleja la fecha de expiracion del nombre de dominio
% que el registrante tiene contratada con el registrar. Puede consultar la base
% de datos de Whois del registrar para ver la fecha de expiracion reportada por
% el registrar para este nombre de dominio.

% La informacion que ha solicitado se provee exclusivamente para fines
% relacionados con la delegacion de nombres de dominio y la operacion del DNS
% administrado por NIC Mexico.

% Queda absolutamente prohibido su uso para otros propositos, incluyendo el
% envio de Correos Electronicos no solicitados con fines publicitarios o de
% promocion de productos y servicios (SPAM) sin mediar la autorizacion de los
% afectados y de NIC Mexico.

% La base de datos generada a partir del sistema de delegacion, esta protegida
% por las leyes de Propiedad Intelectual y todos los tratados internacionales
% sobre la materia.

% Si necesita mayor informacion sobre los registros aqui mostrados, favor de
% comunicarse a ayuda@nic.mx.

% Si desea notificar sobre correo no solicitado o accesos no autorizados, favor
% de enviar su mensaje a abuse@nic.mx.
```

--------------------------------------------------------------------------------

## Consultar la información de una IP o bloque de IP

### IPv4

```
$ whois 132.248.0.0/16

% IANA WHOIS server
% for more information on IANA, visit http://www.iana.org
% This query returned 1 object

refer:        whois.arin.net

inetnum:      132.0.0.0 - 132.255.255.255
organisation: Administered by ARIN
status:       LEGACY

whois:        whois.arin.net

changed:      1993-05
source:       IANA


#
# ARIN WHOIS data and services are subject to the Terms of Use
# available at: https://www.arin.net/resources/registry/whois/tou/
#
# If you see inaccuracies in the results, please report at
# https://www.arin.net/resources/registry/whois/inaccuracy_reporting/
#
# Copyright 1997-2020, American Registry for Internet Numbers, Ltd.
#


# start

NetRange:       132.0.0.0 - 132.255.255.255
CIDR:           132.0.0.0/8
NetName:        NET132
NetHandle:      NET-132-0-0-0-0
Parent:          ()
NetType:        Early Registrations, Maintained by ARIN
OriginAS:
Organization:   Various Registries (Maintained by ARIN) (VR-ARIN)
RegDate:        1993-04-30
Updated:        2010-06-30
Ref:            https://rdap.arin.net/registry/ip/132.0.0.0



OrgName:        Various Registries (Maintained by ARIN)
OrgId:          VR-ARIN
Address:        PO Box 232290
City:           Centreville
StateProv:      VA
PostalCode:     20120
Country:        US
RegDate:        1993-04-30
Updated:        2018-01-08
Comment:        Address space was assigned by the InterNIC regardless of
Comment:        geographic region.  The registrations are now being maintained
Comment:        by various registries, and the in-addr.arpa delegations are
Comment:        being maintained by ARIN.
Ref:            https://rdap.arin.net/registry/entity/VR-ARIN


OrgTechHandle: CKN23-ARIN
OrgTechName:   No, Contact Known
OrgTechPhone:  +1-800-555-1234
OrgTechEmail:  nobody@example.com
OrgTechRef:    https://rdap.arin.net/registry/entity/CKN23-ARIN

OrgAbuseHandle: CKN23-ARIN
OrgAbuseName:   No, Contact Known
OrgAbusePhone:  +1-800-555-1234
OrgAbuseEmail:  nobody@example.com
OrgAbuseRef:    https://rdap.arin.net/registry/entity/CKN23-ARIN

# end


# start

NetRange:       132.247.0.0 - 132.248.255.255
CIDR:           132.248.0.0/16, 132.247.0.0/16
NetName:        LACNIC-ERX-132-247-0-0
NetHandle:      NET-132-247-0-0-1
Parent:         NET132 (NET-132-0-0-0-0)
NetType:        Transferred to LACNIC
OriginAS:
Organization:   Latin American and Caribbean IP address Regional Registry (LACNIC)
RegDate:        2003-12-11
Updated:        2007-12-17
Comment:        This IP address range is under LACNIC responsibility
Comment:        for further allocations to users in LACNIC region.
Comment:        Please see http://www.lacnic.net/ for further details,
Comment:        or check the WHOIS server located at http://whois.lacnic.net
Ref:            https://rdap.arin.net/registry/ip/132.247.0.0

ResourceLink:  http://lacnic.net/cgi-bin/lacnic/whois
ResourceLink:  whois.lacnic.net


OrgName:        Latin American and Caribbean IP address Regional Registry
OrgId:          LACNIC
Address:        Rambla Republica de Mexico 6125
City:           Montevideo
StateProv:
PostalCode:     11400
Country:        UY
RegDate:        2002-07-26
Updated:        2018-03-15
Ref:            https://rdap.arin.net/registry/entity/LACNIC

ReferralServer:  whois://whois.lacnic.net
ResourceLink:  http://lacnic.net/cgi-bin/lacnic/whois

OrgTechHandle: LACNIC-ARIN
OrgTechName:   LACNIC Whois Info
OrgTechPhone:  +598-2604-2222
OrgTechEmail:  whois-contact@lacnic.net
OrgTechRef:    https://rdap.arin.net/registry/entity/LACNIC-ARIN

OrgAbuseHandle: LWI100-ARIN
OrgAbuseName:   LACNIC Whois Info
OrgAbusePhone:  +598-2604-2222
OrgAbuseEmail:  abuse@lacnic.net
OrgAbuseRef:    https://rdap.arin.net/registry/entity/LWI100-ARIN

# end



#
# ARIN WHOIS data and services are subject to the Terms of Use
# available at: https://www.arin.net/resources/registry/whois/tou/
#
# If you see inaccuracies in the results, please report at
# https://www.arin.net/resources/registry/whois/inaccuracy_reporting/
#
# Copyright 1997-2020, American Registry for Internet Numbers, Ltd.
#


% Joint Whois - whois.lacnic.net
%  This server accepts single ASN, IPv4 or IPv6 queries

% LACNIC resource: whois.lacnic.net


% Copyright LACNIC lacnic.net
%  The data below is provided for information purposes
%  and to assist persons in obtaining information about or
%  related to AS and IP numbers registrations
%  By submitting a whois query, you agree to use this data
%  only for lawful purposes.
%  2020-05-28 04:17:39 (-03 -03:00)

inetnum:     132.248/16
status:      assigned
aut-num:     N/A
owner:       Universidad Nacional Autonoma de Mexico
ownerid:     MX-UNAM1-LACNIC
responsible: Dr. Felipe Bracho Carpizo
address:     Av.Universidad, 3000, Copilco
address:     04510 - Coyoacan - CX
country:     MX
phone:       +52 55 56228884 []
owner-c:     CIR
tech-c:      CIR
abuse-c:     CIR
inetrev:     132.248/16
nserver:     NS3.UNAM.MX
nsstat:      20200525 AA
nslastaa:    20200525
nserver:     NS4.UNAM.MX
nsstat:      20200525 AA
nslastaa:    20200525
created:     19890331
changed:     20030206

nic-hdl:     CIR
person:      UNIVERSIDAD NACIONAL AUTONOMA DE MEXICO
e-mail:      nic@UNAM.MX
address:     AV.UNIVERSIDAD, Universidad Nacional Autonoma de Mexico C.U, 3000, COPILCO
address:     04510 - MEXICO, COYOACAN - CX
country:     MX
phone:       +52 55 56228884 []
created:     20041202
changed:     20181004

% whois.lacnic.net accepts only direct match queries.
% Types of queries are: POCs, ownerid, CIDR blocks, IP
% and AS numbers.
```

--------------------------------------------------------------------------------

### IPv6

```
$ whois 2001:1218::/32

% IANA WHOIS server
% for more information on IANA, visit http://www.iana.org
% This query returned 1 object

inet6num:     2001:1200:0:0:0:0:0:0/23
organisation: LACNIC
status:       ALLOCATED

whois:        whois.lacnic.net

changed:      2002-11-01
source:       IANA


% Joint Whois - whois.lacnic.net
%  This server accepts single ASN, IPv4 or IPv6 queries

% LACNIC resource: whois.lacnic.net


% Copyright LACNIC lacnic.net
%  The data below is provided for information purposes
%  and to assist persons in obtaining information about or
%  related to AS and IP numbers registrations
%  By submitting a whois query, you agree to use this data
%  only for lawful purposes.
%  2020-05-28 04:19:38 (-03 -03:00)

inetnum:     2001:1218::/32
status:      assigned
aut-num:     N/A
owner:       Universidad Nacional Autonoma de Mexico
ownerid:     MX-UNAM1-LACNIC
responsible: Dr. Felipe Bracho Carpizo
address:     Av.Universidad, 3000, Copilco
address:     04510 - Coyoacan - CX
country:     MX
phone:       +52 55 56228884 []
owner-c:     CIR
tech-c:      CIR
abuse-c:     CIR
inetrev:     2001:1218::/32
nserver:     NS3.UNAM.MX
nsstat:      20200525 AA
nslastaa:    20200525
nserver:     NS4.UNAM.MX
nsstat:      20200525 AA
nslastaa:    20200525
created:     20050629
changed:     20130806

nic-hdl:     CIR
person:      UNIVERSIDAD NACIONAL AUTONOMA DE MEXICO
e-mail:      nic@UNAM.MX
address:     AV.UNIVERSIDAD, Universidad Nacional Autonoma de Mexico C.U, 3000, COPILCO
address:     04510 - MEXICO, COYOACAN - CX
country:     MX
phone:       +52 55 56228884 []
created:     20041202
changed:     20181004

% whois.lacnic.net accepts only direct match queries.
% Types of queries are: POCs, ownerid, CIDR blocks, IP
% and AS numbers.
```

--------------------------------------------------------------------------------

## Consultar la información de un sistema autónomo

```
$ whois AS278

% IANA WHOIS server
% for more information on IANA, visit http://www.iana.org
% This query returned 1 object

refer:        whois.arin.net

as-block:     1-1876
organisation: Assigned by ARIN

whois:        whois.arin.net
descr:        Assigned by ARIN

source:       IANA


#
# ARIN WHOIS data and services are subject to the Terms of Use
# available at: https://www.arin.net/resources/registry/whois/tou/
#
# If you see inaccuracies in the results, please report at
# https://www.arin.net/resources/registry/whois/inaccuracy_reporting/
#
# Copyright 1997-2020, American Registry for Internet Numbers, Ltd.
#


ASNumber:       278
ASName:         LACNIC-278
ASHandle:       AS278
RegDate:        2002-07-26
Updated:        2007-12-17
Comment:        This AS is under LACNIC responsibility for further allocations to
Comment:        users in LACNIC region.
Comment:        Please see http://www.lacnic.net/ for further details, or check the
Comment:        WHOIS server located at http://whois.lacnic.net
Ref:            https://rdap.arin.net/registry/autnum/278

ResourceLink:  http://lacnic.net/cgi-bin/lacnic/whois
ResourceLink:  whois.lacnic.net


OrgName:        Latin American and Caribbean IP address Regional Registry
OrgId:          LACNIC
Address:        Rambla Republica de Mexico 6125
City:           Montevideo
StateProv:
PostalCode:     11400
Country:        UY
RegDate:        2002-07-26
Updated:        2018-03-15
Ref:            https://rdap.arin.net/registry/entity/LACNIC

ReferralServer:  whois://whois.lacnic.net
ResourceLink:  http://lacnic.net/cgi-bin/lacnic/whois

OrgAbuseHandle: LWI100-ARIN
OrgAbuseName:   LACNIC Whois Info
OrgAbusePhone:  +598-2604-2222
OrgAbuseEmail:  abuse@lacnic.net
OrgAbuseRef:    https://rdap.arin.net/registry/entity/LWI100-ARIN

OrgTechHandle: LACNIC-ARIN
OrgTechName:   LACNIC Whois Info
OrgTechPhone:  +598-2604-2222
OrgTechEmail:  whois-contact@lacnic.net
OrgTechRef:    https://rdap.arin.net/registry/entity/LACNIC-ARIN


#
# ARIN WHOIS data and services are subject to the Terms of Use
# available at: https://www.arin.net/resources/registry/whois/tou/
#
# If you see inaccuracies in the results, please report at
# https://www.arin.net/resources/registry/whois/inaccuracy_reporting/
#
# Copyright 1997-2020, American Registry for Internet Numbers, Ltd.
#


% Joint Whois - whois.lacnic.net
%  This server accepts single ASN, IPv4 or IPv6 queries

% LACNIC resource: whois.lacnic.net


% Copyright LACNIC lacnic.net
%  The data below is provided for information purposes
%  and to assist persons in obtaining information about or
%  related to AS and IP numbers registrations
%  By submitting a whois query, you agree to use this data
%  only for lawful purposes.
%  2020-05-28 04:17:49 (-03 -03:00)

aut-num:     AS278
owner:       Universidad Nacional Autonoma de Mexico
ownerid:     MX-UNAM1-LACNIC
responsible: Dr. Felipe Bracho Carpizo
address:     Av.Universidad, 3000, Copilco
address:     04510 - Coyoacan - CX
country:     MX
phone:       +52 55 56228884 []
owner-c:     CIR
routing-c:   CIR
abuse-c:     CIR
created:     19890331
changed:     20110503

nic-hdl:     CIR
person:      UNIVERSIDAD NACIONAL AUTONOMA DE MEXICO
e-mail:      nic@UNAM.MX
address:     AV.UNIVERSIDAD, Universidad Nacional Autonoma de Mexico C.U, 3000, COPILCO
address:     04510 - MEXICO, COYOACAN - CX
country:     MX
phone:       +52 55 56228884 []
created:     20041202
changed:     20181004

% whois.lacnic.net accepts only direct match queries.
% Types of queries are: POCs, ownerid, CIDR blocks, IP
% and AS numbers.
```

--------------------------------------------------------------------------------

+ <https://linux.die.net/man/1/whois>
+ <http://networktools.he.net/>

+ <http://www.nicmexico.mx/>
+ <http://nic.mx>
+ <https://www.akky.mx/>
+ <https://www.akky.mx/es/Whois>
+ <http://who.is/>
+ <https://who.is/whois/unam.mx>

