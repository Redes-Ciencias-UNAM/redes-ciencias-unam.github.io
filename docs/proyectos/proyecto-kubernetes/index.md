---
title: Proyecto 2 - Implementación de sitios web en Kubernetes
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Proyecto 2: Implementación de sitios web en **Kubernetes**

--------------------------------------------------------------------------------

## Objetivos

- Crear imagenes de contenedores con Docker
- Instalar un cluster de Kubernetes
- Instalar un _ingress controller_ en el cluster de Kubernetes
- Despliegue de sitios web en Kubernetes
- Configuración del certificado SSL en el _ingress controller_

## Elementos de apoyo

- [Kube by Example - Container Fundamentals - Introduction to Containers 📝][kbe-containers-intro]
    - _Introduction_, _Overview_, _Images_, _Registries_, _Hosts_ y _Orchestration_
<!--

- [Kube by Example - Container Fundamentals - Container images 📝][kbe-containers-images]
    - _Introduction_, _Layers & Repositories_, _URLs_ e _Internals_
-->
<!--
- [Kube by Example - Container Fundamentals - Standards 📝][kbe-containers-standards]
    - _Introduction_, _OCI Specifications_, _Image Specification_ y _Runtime Specification_
-->
- [Kube by Example - Kubernetes Fundamentals 📝][kbe-kubernetes]
    - `kubectl`, _Pods_, _ReplicaSets_, _Deployments_, _Labels_ y _Services_
    - _Environment Variables_, _ConfigMaps_, _Secrets_ y _Volumes_
<!--
    - _Logs_, _Images_, _Resources_, _Requests_ y _Limits_
    - _Rolling Updates_, _Liveness Probes_ y _Readiness Probes_
    - _Taints_, _Affinity_, _Jobs_, _StatefulSets_ y _DaemonSets_
-->

- [Lista de reproducción de **Docker** 📹][youtube-playlist-docker]
- [Lista de reproducción de **Kubernetes** 📹][youtube-playlist-kubernetes]

[youtube-playlist-docker]: https://www.youtube.com/playlist?list=PLN1TFzSBXi3S9ixHf9PM38heDbZLQW8vf
[youtube-playlist-kubernetes]: https://www.youtube.com/playlist?list=PLN1TFzSBXi3R4D4dulWjG-DS4gfSmuGUY

[kbe-containers-intro]: https://kubebyexample.com/en/learning-paths/container-fundamentals/introduction-containers/introduction
[kbe-containers-images]: https://kubebyexample.com/en/learning-paths/container-fundamentals/container-images/introduction
[kbe-containers-standards]: https://kubebyexample.com/en/learning-paths/container-fundamentals/standards/introduction
[kbe-kubernetes]: https://kubebyexample.com/en/learning-paths/kubernetes-fundamentals/
[kubernetes-ingress-nginx]: https://kubernetes.github.io/ingress-nginx/
[kubernetes-ingress-nginx-deploy]: https://kubernetes.github.io/ingress-nginx/deploy/
[kubernetes-ingress-nginx-baremetal]: https://kubernetes.github.io/ingress-nginx/deploy/baremetal/
[kubernetes-ingress-nginx-ingress]: https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/
[kubernetes-ingress-nginx-tls]: https://kubernetes.github.io/ingress-nginx/user-guide/tls/

[kubernetes-ingress]: https://kubernetes.io/docs/concepts/services-networking/ingress/

[docker-desktop]: https://www.docker.com/products/docker-desktop/
[docker-desktop-docs]: https://docs.docker.com/desktop/

[]: https://kubernetes.io/docs/tasks/tools/
[]: https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/


[kodekloud-lfcs]: https://kodekloud.com/courses/linux-foundation-certified-system-administrator-lfcs/
[kodekloud-docker]: https://kodekloud.com/courses/docker-for-the-absolute-beginner/

[edx-intro-kubernetes]: https://www.edx.org/course/introduction-to-kubernetes

## Restricciones

!!! danger
    - La evaluación de este proyecto final corresponderá al **cuarto examen parcial** del curso

!!! warning
    - **Esta actividad depende de los recursos implementados en la [práctica 8](../../laboratorio/practica-8) y [práctica 9](../../laboratorio/practica-9)**
    - Se recomienda que se realicen las actividades previas [siguiendo la calendarización](../../laboratorio) con el objeto de dejar suficiente tiempo para la elaboración de este proyecto

- La fecha límite de entrega es el **jueves 15 de diciembre de 2022** a las 23:59 horas
- Esta actividad debe ser entregada **en equipo** de acuerdo al [flujo de trabajo para la entrega de tareas y prácticas][flujo-de-trabajo]
    - Utilizar la carpeta `docs/proyectos/proyecto-kubernetes/Equipo-ABCD-EFGH-IJKL-MNOP` para entregar la práctica
    - Donde `Equipo-ABCD-EFGH-IJKL-MNOP` representa el nombre del equipo que debió anotarse previamente en la [lista del grupo][lista-redes]
    - Hacer un _merge request_ a la rama `proyecto-kubernetes` del [repositorio de tareas][repo-tareas] para entregar la actividad



--------------------------------------------------------------------------------

## Procedimiento

- [Creación de imágenes de contenedor con Docker](./docker)

- [Preparación de la máquina virtual](./prepare-vm)

- [Instalación de `k3s` en Debian 11](./k3s-install) + `krew`

- [Configuración de Ingress NGINX en Kubernetes](./k8s-ingress-nginx)

- [Implementación de sitios web en Kubernetes](./k8s-deployments)

- [Implementación de ingress en Kubernetes](./k8s-ingress-resource)

- [Configuración de SSL/TLS en Ingress NGINX](./k8s-ingress-nginx-tls)

--------------------------------------------------------------------------------

## Entregables

- Archivo `README.md`
    - Explicación del proceso de creación de las imagenes de contenedor
    - Explicación del proceso de instalación de `k3s` en Debian 11
    - Explicación del proceso de instalación del _ingress controller_ en el cluster
    - Explicación del proceso de despliegue de los sitios web en el cluster de Kubernetes
    - Explicación de la configuración de SSL/TLS en el _ingress controller_

- Carpeta `img`
    - Cada captura de pantalla tiene que ser referenciada en el archivo `README.md`
    - Capturas de pantalla donde se muestre la instalación de Docker Desktop
    - Capturas de pantalla de los sitios web hospedados utilizando HTTP y HTTPS

- Carpeta `files`
    - Cada archivo tiene que ser referenciado en el archivo `README.md`

    - **Archivos de configuración**
        - Incluir en un archivo `tar.gz` el contenido del directorio `/etc/letsencrypt`
        - Incluir en un archivo `tar.gz` el contenido del directorio `/etc/rancher`

    - **Archivos de bitácora**
        - Preparación de la máqina virtual de Azure (reducción de uso de CPU y RAM)
        - Instalación de `k3s` en Debian 11
        - Instalación de `kubectl` y `krew` en el equipo local
        - Instalación de `krew` en el equipo remoto
        - Bitácora de conexión a los puertos `80` y `443` del cluster de Kubernetes
        - Bitácora de conexión al puerto 443 utilizando `openssl s_client`
        - Bitácora de comprobación de la validez del certificado SSL emitido por Let's Encrypt
        - Bitácira de conexión a los sitios web hospedados utilizando HTTP y HTTPS

    - **Archivos de datos**

        - Archivos `Dockerfile` para los contenedores `linux-doc` y `tareas-redes`
        - Incluir en un archivo `tar.gz` el contenido del directorio `/var/www/html` de la máquina virual de Azure
        - Archivo `cert.txt` que es la representación en texto del certificado SSL emitido por Let's Encrypt

    - **Recursos de _Kubernetes_**
        - Exporta los recursos del cluster de _Kubernetes_ utilizando `kubectl`
        - Quita los campos innecesarios utilizando el siguiente comando
            - `kubectl neat < archivo.yaml > archivo.neat.yaml`
            - Anexa el archivo original (`archivo.yaml`) y el archivo sin campos extra (`archivo.neat.yaml`) a tu reporte
            - Repite para todos los recursos de Kubernetes solicitados
        - Explica cuales campos no necesarios se quitan en los recursos de tipo `deployment`, `configmap`, `secret` e `ingress`
            - Puedes utilizar el comando `diff -u archivo.yaml archivo.neat.yaml` para ver las diferencias

```
usuario@laptop ~ % kubectl get all --all-namespaces > recursos-kubernetes.log

usuario@laptop ~ % kubectl get all --all-namespaces -o yaml > recursos-kubernetes.yaml

usuario@laptop ~ % kubectl get nodes -o yaml

usuario@laptop ~ % kubectl get configmap index-equipo-aaaa-bbbb-cccc-dddd -n default -o yaml

usuario@laptop ~ % kubectl get deployment/root-nginx -n default -o yaml

usuario@laptop ~ % kubectl get deployment/linux-doc -n default -o yaml

usuario@laptop ~ % kubectl get deployment/tareas-redes -n default -o yaml

usuario@laptop ~ % kubectl get secret/nginx-ingress-tls -n default -o yaml

usuario@laptop ~ % kubectl get ingress ingress-nginx -n default -o yaml

usuario@laptop ~ % kubectl get deployment/ingress-nginx-controller -n ingress-nginx -o yaml
```

--------------------------------------------------------------------------------

|                 ⇦           |        ⇧      |                  ⇨            |
|:----------------------------|:-------------:|------------------------------:|
| [Página anterior][anterior] | [Arriba](../) | [Página siguiente][siguiente] |

[anterior]: ../../laboratorio
[siguiente]: ./docker

[flujo-de-trabajo]: https://redes-ciencias-unam.gitlab.io/2022-2/tareas-redes/workflow/
[repo-tareas]: https://gitlab.com/Redes-Ciencias-UNAM/2022-2/tareas-redes/-/merge_requests

[lista-redes]: https://tinyurl.com/Lista-Redes-2022-2

[playlist-https]: https://www.youtube.com/playlist?list=PLN1TFzSBXi3QGCMqARFoO1ePBX1P38erB
[video-protocolo-dns]: https://www.youtube.com/watch?v=r4PntflJs9E&list=PLN1TFzSBXi3QWbHwBEV3p4LxV5KceXu8d&index=40
[video-configuracion-ssh]: https://youtu.be/Hnu7BHBDcoM&t=1390&list=PLN1TFzSBXi3QGCMqARFoO1ePBX1P38erB
[video-configuracion-apache-debian]: https://youtu.be/XbQ_dBuERdM&list=PLN1TFzSBXi3QGCMqARFoO1ePBX1P38erB&index=2
[video-directivas-apache]: https://youtu.be/3JkQs3KcjxQ&list=PLN1TFzSBXi3QGCMqARFoO1ePBX1P38erB&index=3
[video-virtualhosts-apache-etc-hosts]: https://youtu.be/ZnqSNXIr-h4&list=PLN1TFzSBXi3QGCMqARFoO1ePBX1P38erB&index=4
[video-virtualhosts-apache-registros-dns]: https://youtu.be/JYo5rc4mhf0&list=PLN1TFzSBXi3QGCMqARFoO1ePBX1P38erB&index=5
[video-certificados-ssl-x509]: https://youtu.be/rXqkJi_FTuQ&list=PLN1TFzSBXi3QGCMqARFoO1ePBX1P38erB&index=6
[video-certificados-ssl-virtualhost-https-apache]: https://youtu.be/66dOHHD6L5I&list=PLN1TFzSBXi3QGCMqARFoO1ePBX1P38erB&index=7
[video-letsencrypt-certbot]: https://youtu.be/kpiChLT5JPs&list=PLN1TFzSBXi3QGCMqARFoO1ePBX1P38erB&index=8

[apache-docs]: https://httpd.apache.org/docs/2.4/
[apache-docs-config-sections]: https://httpd.apache.org/docs/2.4/sections.html
[apache-docs-security]: https://httpd.apache.org/docs/2.4/misc/security_tips.html
[apache-docs-server-wide]: https://httpd.apache.org/docs/2.4/server-wide.html
[apache-docs-url-rewrite]: https://httpd.apache.org/docs/2.4/rewrite/
[apache-docs-virtualhost]: https://httpd.apache.org/docs/2.4/vhosts/
[apache-docs-ssl]: https://httpd.apache.org/docs/2.4/ssl/
[apache-docs-htaccess]: https://httpd.apache.org/docs/2.4/howto/htaccess.html

[certbot-instructions-debian-10-buster]: https://certbot.eff.org/instructions?ws=apache&os=debianbuster
