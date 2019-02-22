# git

## Subir el código al repositorio

Nota: `�` Significa que ahí va el número de tu equipo

### Clonar el repositorio

```sh
$ git clone https://gitlab.com/Redes-Ciencias-UNAM/2018-2/equipo-�
$ cd equipo-�
```
### Inicializar los datos del autor en el repositorio local

```sh
$ git config user.name  "John Doe"
$ git config user.email "user@example.com"
```

### Generar contenido en el repositorio

#### Archivos

+ Copiar archivos existentes al repositorio
+ Abrir los archivos con un editor de texto y hacer cambios

#### Directorios

+ Los directorios **vacíos** no se versionan

**ProTip**: Crear el directorio, agregar un archivo con `touch` y versionar ese archivo

```sh
$ mkdir -v directorio/
mkdir: created directory ‘directorio’
$ touch directorio/.keep
$ git add directorio/.keep
```

### Preparar archivos para enviar en el siguiente commit

```sh
$ git add Makefile
$ git add archivo.c
```

### Versionar los cambios

```sh
$ git commit
```

### Enviar los cambios versionados al repositorio remoto

```sh
$ git push -u origin master
```

### Hacer más cambios

### Verificar si alguien más envió cambios al repositorio

```sh
$ git pull
```

### Enviar cambios locales al servidor

```sh
$ git push
```

#### Recursos de ayuda

+ Documentación oficial de `git`

    * <https://git-scm.com/doc>

+ Referencia de comandos de `git`

    * <https://git-scm.com/docs>

+ Libro oficial de `git`

    * <https://git-scm.com/book>

+ Mini tutorial interactivo de git

    * <https://try.github.io/>

+ Hoja de ayuda de comandos de git

    * <https://services.github.com/on-demand/downloads/es_ES/github-git-cheat-sheet/>
    * <https://about.gitlab.com/images/press/git-cheat-sheet.pdf>

+ Guía oficial de GNU para `Makefile`

    * <https://www.gnu.org/software/make/manual/make.html>
    * <https://www.gnu.org/software/make/manual/html_node/Makefiles.html>

+ Otras guías y referencias `Makefile`

    * <http://tldp.org/HOWTO/Linux-i386-Boot-Code-HOWTO/makefiles.html>
    * <https://users.cs.duke.edu/~ola/courses/programming/Makefiles/Makefiles.html>
    * <http://mrbook.org/blog/tutorials/make/>
    * <https://www.cs.swarthmore.edu/~newhall/unixhelp/howto_makefiles.html>
    * <http://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/>
    * <https://www.codeproject.com/Articles/31488/Makefiles-in-Linux-An-Overview>
    * <https://wiki.osdev.org/Makefile>
    * <http://web.mit.edu/gnu/doc/html/make_3.html>
    * <https://www.cs.bu.edu/teaching/cpp/writing-makefiles/>
    * <http://www.sis.pitt.edu/mbsclass/tutorial/advanced/makefile/whatis.htm>
    * <http://www.math.colostate.edu/~yzhou/computer/writemakefile.html>

+ Páginas de manual (RTFM!):

| `En terminal`		| En línea |
|:----------------------|:---------|
| `man git-config`	| <https://git-scm.com/docs/git-config> |
| `man git-clone`	| <https://git-scm.com/docs/git-clone> |
| `man git-add`		| <https://git-scm.com/docs/git-add> |
| `man git-commit`	| <https://git-scm.com/docs/git-commit> |
| `man git-push`	| <https://git-scm.com/docs/git-push> |
| `man git-pull`	| <https://git-scm.com/docs/git-pull> |

