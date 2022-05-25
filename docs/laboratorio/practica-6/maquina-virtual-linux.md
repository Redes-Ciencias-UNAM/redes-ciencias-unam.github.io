### Configuración de la máquina virtual Debian

#### Conexión inicial por SSH

Conectarse por SSH a la dirección IP de la máquina virtual

```bash
usuario@laptop ~ % ssh redes@20.213.120.169
```

Aparecerá un mensaje para confirmar el _fingerprint_ de la llave SSH del equipo remoto

- Contestar `yes` para continuar

```text
The authenticity of host '20.213.120.169 (20.213.120.169)' can't be established.
ED25519 key fingerprint is SHA256:9fwkWrkhTqIcnI47upgKoc1ojbUyZkmMyKqm/Et7xwM.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '20.213.120.169' (ED25519) to the list of known hosts.
```

Se pedirá la contraseña del usuario `redes`, es la misma que se dio de alta en el portal de Azure

!!! danger
    - La contraseña **DEBE** ser fuerte porque es con la que se va a autenticar el usuario adminsitrador de esta máquina virtual
    - Si la contraseña no es lo suficientemente compleja, el equipo está en un **riesgo de seguridad ALTO** y se recomienda establecer una nueva contraseña a la brevedad

```text
redes@20.213.120.169's password: 
Linux Debian-Redes 5.10.0-14-cloud-amd64 #1 SMP Debian 5.10.113-1 (2022-04-29) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
```

Después de iniciar sesión aparecerá un mensaje de advertencia sobre la configuración de lenguaje del equipo

- Esto se resolverá en los pasos siguientes

```text
_____________________________________________________________________
WARNING! Your environment specifies an invalid locale.
 The unknown environment variables are:
   LC_CTYPE=UTF-8 LC_ALL=
 This can affect your user experience significantly, including the
 ability to manage packages. You may install the locales by running:

 sudo dpkg-reconfigure locales

 and select the missing language. Alternatively, you can install the
 locales-all package:

 sudo apt-get install locales-all

To disable this message for all users, run:
   sudo touch /var/lib/cloud/instance/locale-check.skip
_____________________________________________________________________
```

Finalmente aparecerá el _prompt_ de la línea de comandos

```bash
redes@Debian-Redes:~$
```

--------------------------------------------------------------------------------

#### Configuración de `sudo`

Revisar la lista de opciones que aplican para que el usuario `redes` pueda elevar privilegios utilizando `sudo`

- La última opción **DEBE** contener la directiva `NOPASSWD`

```bash
redes@Debian-Redes:~$ sudo -k
redes@Debian-Redes:~$ sudo -l
Matching Defaults entries for redes on Debian-Redes:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin

User redes may run the following commands on Debian-Redes:
    (ALL : ALL) ALL
    (ALL) NOPASSWD: ALL
```

Verificar que el usuario pueda elevar privilegios **sin utilizar contraseña**

```bash
redes@Debian-Redes:~$ sudo -i
root@Debian-Redes:~#
```

!!! warning
    Esta configuración no es recomendada para **ambientes de producción** y se utiliza únicamente con fines demostrativos y para agilizar la implementación de las configuraciones de la práctica

<details open>
  <summary>Establecer el siguiente contenido en el archivo <code>/etc/sudoers.d/waagent</code> en caso de que exista:</summary>

```bash
root@Debian-Redes:~# cat /etc/sudoers.d/waagent
redes ALL = (ALL) NOPASSWD:ALL
```

</details>

--------------------------------------------------------------------------------

#### Configuración de llave SSH

Crea una llave SSH para autenticarse en la máquina virtual

```
usuario@laptop ~ % ssh-keygen -t rsa -b 4096 -N "" -C "Equipo-AAAA-BBBB-CCCC-DDDD" -f ~/.ssh/equipo_redes_rsa
```

Listar el par de llaves SSH

- <span style="color: red;">La llave `equipo_redes_rsa` es la llave **PRIVADA** y únicamente debe compartirse con los integrantes del equipo</span>
- <span style="color: green;">La llave `equipo_redes_rsa.pub` es la llave **pública**, deben subir una copia de esta en el directorio `files` de su reporte</span>

```bash
usuario@laptop ~ % ls -la ~/.ssh/equipo_redes_rsa*
-rw------- 1 tonejito staff 3389 May 24 18:19 /Users/tonejito/.ssh/equipo_redes_rsa
-rw-r--r-- 1 tonejito staff  752 May 24 18:19 /Users/tonejito/.ssh/equipo_redes_rsa.pub
```

Mostrar el contenido de la llave **pública**

```bash
usuario@laptop ~ % cat ~/.ssh/equipo_redes_rsa.pub
ssh-rsa AAECAwQFBgcICQoLDA0O...8/T19vf4+fr7/P3+/w== Equipo-AAAA-BBBB-CCCC-DDDD

usuario@laptop ~ % wc -l ~/.ssh/equipo_redes_rsa.pub
1
```

!!! note
    El contenido de la llave es una cadena **muy larga** que viene en **una sola línea**

Crea un bloque de configuración en el archivo local `~/.ssh/config` para facilitar el acceso por SSH

```text
Host 20.213.120.169 example.com *.example.com
  User redes
  IdentityFile ~/.ssh/equipo_redes_rsa
```

!!! note
    - Reemplaza `example.com` por el nombre de dominio que registraste anteriormente
    - Reemplaza `20.213.120.169` con la dirección IP pública de la máquina virtual

Prueba la configuración del cliente de SSH y verifica que puedas elevar privilegios

```bash
usuario@laptop ~ % ssh example.com
	...
redes@Debian-Redes:~$ sudo -i

root@Debian-Redes:~#
```

--------------------------------------------------------------------------------

#### Configuración de nombre de _host_

Define el nombre del equipo utilizando el comando [`hostnamectl(1)`][man-hostnamectl]

- Utiliza el nombre de dominio que registraste anteriormente

```bash
root@Debian-Redes:~# hostnamectl set-hostname example.com
root@Debian-Redes:~# hostname -f
example.com
```

Anota la dirección IP y el nombre del equipo **al final del archivo** `/etc/hosts`

```text
127.0.0.1	localhost
::1			localhost ip6-localhost ip6-loopback
ff02::1		ip6-allnodes
ff02::2		ip6-allrouters

20.213.120.169  example.com
```

Cierra la sesión de SSH

```bash
root@Debian-Redes:~# exit

redes@Debian-Redes:~$ exit
Connection to example.com closed.

usuario@laptop ~ %
```

Vuelve a conectar la sesión de SSH y verifica que el nombre del equipo se muestre adecuadamente

```bash
usuario@laptop ~ % ssh example.com

redes@example:~$ hostname -f
example.com

redes@example:~$ hostnamectl status
   Static hostname: example.com
         Icon name: computer-vm
           Chassis: vm
        Machine ID: a787060b9c7d44f685b2cf22ab422971
           Boot ID: 50ff3915d1414a3f877a664089cafc9e
    Virtualization: microsoft
  Operating System: Debian GNU/Linux 11 (bullseye)
            Kernel: Linux 5.10.0-14-cloud-amd64
      Architecture: x86-64
```

--------------------------------------------------------------------------------

#### Configuración de zona horaria

Revisa la fecha y hora actuales para determinar la zona horaria.
En este caso se muestra que la máquina virtual tiene la zona horaria `UTC`

```
root@example:~# date
Wed May 25 00:55:46 UTC 2022
```

Establece la zona horaria del equipo utilizando el comando [`timedatectl(1)`][man-timedatectl]

```
root@example:~# timedatectl set-timezone America/Mexico_City
```

Verifica que los cambios se hayan aplicado

```
root@example:~# date
Tue May 24 19:56:06 CDT 2022
root@example:~# timedatectl 
               Local time: Tue 2022-05-24 19:56:10 CDT
           Universal time: Wed 2022-05-25 00:56:10 UTC
                 RTC time: Wed 2022-05-25 00:56:10
                Time zone: America/Mexico_City (CDT, -0500)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

--------------------------------------------------------------------------------

#### Configuración de idioma

Configura de manera apropiada los mensajes de localización en la máquina virtual

```
root@example:~# dpkg-reconfigure -p low locales
```

Selecciona los siguientes en el cuadro de diálogo `Configuring locales`

- `[*] en_US.UTF-8`
- `[*] es_MX.UTF-8`

Seleccionar los siguientes de la lista en el cuadro de diálogo `Locales to be generated`

- `[*] en_US.UTF-8`
- `[*] es_MX.UTF-8`

!!! note
    - Puedes utilizar las flechas de teclado y/o la tecla `<Tab>` para navegar entre las opciones
    - La barra espaciadora enciende `[*]` o apaga `[ ]` las opciones
    - No usar `Ctrl + C` ni `Ctrl + Z` porque se interrumpe el proceso de configuración y puede causar problemas

Seleccionar `en_US.UTF-8` en la lista en el cuadro de diálogo `Default locale for the system environment`

--------------------------------------------------------------------------------

#### Reinicia la máquina virtual

Reinicia la máquina virtual para verificar que los cambios sean persistentes

```bash
redes@example:~$ sudo reboot & exit ;
Connection to example.com closed.
```

--------------------------------------------------------------------------------

#### Autenticación SSH en la máquina virtual
<a id="ssh-key" name="ssh-key"></a>

Agregar la [llave SSH de los profesores](files/profesores_redes_rsa.pub) en el archivo `~/.ssh/authorized_keys2`, la cual ayudará a calificar la práctica

!!! note
    Puedes pedir asistencia de los profesores cuando vayas a realizar este paso para evitar problemas de acceso

!!! warning
    La configuración del archivo [`~/.ssh/authorized_keys2`][man-sshd_config-AuthorizedKeysFile] **únicamente** aplica para distribuciones [Debian y derivados][man-sshd_config-DebianBanner]

Copia la llave a la máquina virtual

```bash
usuario@laptop ~ % scp profesores_redes_rsa.pub redes@example.com:/tmp/profesores_redes_rsa.pub

usuario@laptop ~ % ssh example.com
```

Instala la llave en la cuenta del usuario `redes`

```bash
redes@example:~$ test -d ~/.ssh || mkdir -vp ~/.ssh

redes@example:~$ chmod 0700 ~/.ssh

redes@example:~$ install --owner redes --group redes --mode 0600 /tmp/profesores_redes_rsa.pub ~/.ssh/authorized_keys2
```

Instala la llave SSH en la cuenta del usuario `root`

```bash
redes@example:~$ sudo -i

root@example:~# test -d ~/.ssh || mkdir -vp ~/.ssh

root@example:~# install --owner root --group root --mode 0600 /tmp/profesores_redes_rsa.pub ~/.ssh/authorized_keys2
```

Aplica el atributo _inmutable_ a las llaves SSH instaladas

```bash
root@example:~# chattr +i ~redes/.ssh/authorized_keys2 ~root/.ssh/authorized_keys2
```

- Verifica que los permisos y atributos estén correctamente configurados en el archivo `.ssh/authorized_keys2` en las cuentas de usuario `root` y `redes`

```bash
root@example:~# ls -la ~root/.ssh ~redes/.ssh
/home/redes/.ssh:
total 12
drwx------ 2 redes redes 4096 May 24 17:18 .
drwxr-xr-x 4 redes redes 4096 May 24 16:17 ..
-rw------- 1 redes redes    0 May 24 18:19 authorized_keys
-rw------- 1 redes redes  748 May 24 19:20 authorized_keys2

/root/.ssh:
total 16
drwx------ 2 root root 4096 May 24 17:18 .
drwx------ 4 root root 4096 May 24 16:17 ..
-rw------- 1 root root  747 May 24 18:19 authorized_keys
-rw------- 1 root root  748 May 24 19:20 authorized_keys2

root@example:~# lsattr ~root/.ssh/authorized_keys* ~redes/.ssh/authorized_keys*
--------------e------- /root/.ssh/authorized_keys
----i---------e------- /root/.ssh/authorized_keys2
--------------e------- /home/redes/.ssh/authorized_keys
----i---------e------- /home/redes/.ssh/authorized_keys2
```

- Borra la llave del directorio `/tmp`

```bash
root@example:~# rm -v /tmp/profesores_redes_rsa.pub
removed '/tmp/redes_rsa.pub'
```

--------------------------------------------------------------------------------

### Configuración inicial de la máquina virtual
<a id="config" name="config"></a>

#### Actualiza los paquetes del sistema operativo

Actualiza la lista de paquetes disponibles

```bash
root@example:~# apt -q update
	...
```

Lista las actualizaciones disponibles y aplicalas en el equipo

```bash
root@example:~# apt list --upgradable
	...

root@example:~# apt -qy upgrade
	...
```

Reinicia el equipo

```bash
root@example:~# exit

redes@example:~$ sudo reboot & exit ;
Connection to example.com closed.
```

#### Instalar _software_

Instala las utilerías de red en la máquina virtual

```bash
usuario@laptop ~ % ssh example.com

redes@example:~$ sudo -i

root@example:~# apt -qy install tree tcpdump nmap netcat-openbsd ngrep dsniff wget curl whois dnsutils net-tools iproute2 iptables tsocks inetutils-ping inetutils-traceroute inetutils-tools ethtool
	...
```

--------------------------------------------------------------------------------

!!! danger
    - Verifica que **TODAS** las configuraciones que hiciste estén presentes respués de reiniciar la máquina antes de continuar

!!! note
    - Si ya configuraste tu máquina virtual, regresa a [la página principal y elabora tu reporte](../#entregables)

--------------------------------------------------------------------------------

[man-hostnamectl]: https://man7.org/linux/man-pages/man1/hostnamectl.1.html
[man-timedatectl]: https://man7.org/linux/man-pages/man1/timedatectl.1.html
[man-sshd_config-AuthorizedKeysFile]: https://manpages.debian.org/bullseye/openssh-server/sshd_config.5.en.html#AuthorizedKeysFile
[man-sshd_config-DebianBanner]: https://manpages.debian.org/bullseye/openssh-server/sshd_config.5.en.html#DebianBanner
