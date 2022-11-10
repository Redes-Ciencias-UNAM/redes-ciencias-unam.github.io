---
title: Instalación y configuración de Ingress NGINX en Kubernetes
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Instalación y configuración de Ingress NGINX en Kubernetes

--------------------------------------------------------------------------------

## Instala `ingress-nginx` desde el equipo local

Descarga el archivo YAML que contiene la definición de los recursos de Kubernetes para instalar el _ingress controller_ en el cluster

```
usuario@laptop ~ % INGRESS_NGINX_VERSION=v1.2.0
usuario@laptop ~ % wget -c -nv -o ingress-nginx-${INGRESS_NGINX_VERSION}.yaml  https://github.com/kubernetes/ingress-nginx/raw/controller-${INGRESS_NGINX_VERSION}/deploy/static/provider/cloud/deploy.yaml
```

Instala el _ingress controller_ en el cluster de Kubernetes utilizando el archivo YAML que descargaste en el paso anterior

```
usuario@laptop ~ % kubectl apply -f ingress-nginx-${INGRESS_NGINX_VERSION}.yaml
namespace/ingress-nginx created
serviceaccount/ingress-nginx created
serviceaccount/ingress-nginx-admission created
role.rbac.authorization.k8s.io/ingress-nginx created
role.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrole.rbac.authorization.k8s.io/ingress-nginx created
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission created
rolebinding.rbac.authorization.k8s.io/ingress-nginx created
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
configmap/ingress-nginx-controller created
service/ingress-nginx-controller created
service/ingress-nginx-controller-admission created
deployment.apps/ingress-nginx-controller created
job.batch/ingress-nginx-admission-create created
job.batch/ingress-nginx-admission-patch created
ingressclass.networking.k8s.io/nginx created
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission created
```

El _ingress controller_ no abre de manera predeterminada los puertos `80` y `443` para recibir tráfico de HTTP y HTTPS

- Aplica un parche al recurso deployment del _ingress controller_ para hacer que utilice la red del _host_ para que escuche en los puertos `80` y `443` del equipo

<!-- https://kubernetes.github.io/ingress-nginx/deploy/baremetal/#via-the-host-network -->

```
usuario@laptop ~ % kubectl patch deployment/ingress-nginx-controller -n ingress-nginx --patch '{"spec":{"template":{"spec":{"hostNetwork":true}}}}'
deployment.apps/ingress-nginx-controller patched
```

Ejecuta el siguiente comando para esperar a que el _pod_ del _ingress controller_ esté listo para recibir conexiones

```
usuario@laptop ~ % kubectl wait --namespace ingress-nginx  --for=condition=ready pod  --selector=app.kubernetes.io/component=controller  --timeout=180s
pod/ingress-nginx-controller-6ff66b66d7-qlxgx condition met
```

--------------------------------------------------------------------------------

## Verifica que `ingress-nginx` esté activo en el equipo remoto

Verifica que los puertos `80` y `443` estén asociados al proceso `nginx`

```
root@example:~# netstat -ntulp | egrep -w '80|443'
tcp      0     0     0.0.0.0:443      0.0.0.0:*      LISTEN   4096/nginx: master
tcp      0     0     0.0.0.0:80       0.0.0.0:*      LISTEN   4096/nginx: master
tcp6     0     0     :::443           :::*           LISTEN   4096/nginx: master
tcp6     0     0     :::80            :::*           LISTEN   4096/nginx: master
```

--------------------------------------------------------------------------------

## Verifica la instalación de `ingress-nginx`

Revisa que el _deployment_ se encuentre con estado **READY** `1/1` y que el estado del _pod_ sea `Running`

```
usuario@laptop ~ % kubectl get deployments -n ingress-nginx
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
ingress-nginx-controller   1/1     1            1           1h

 % kubectl get pods -n ingress-nginx --field-selector=status.phase==Running
NAME                                        READY   STATUS    RESTARTS   AGE
ingress-nginx-controller-6ff66b66d7-qlxgx   1/1     Running   0          1h
```

Revisa que el servicio `ingress-nginx-controller` se encuentre activo

```
usuario@laptop ~ % kubectl get service ingress-nginx-controller -n ingress-nginx
NAME                       TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
ingress-nginx-controller   LoadBalancer   10.43.147.44   <pending>     80:32768/TCP,443:49152/TCP   1h
```

Revisa que te puedas conectar a los puertos `80` y `443` del servidor con `netcat`

```
usuario@laptop ~ % nc -vz tonejito.cf 80
tonejito.cf [20.213.120.169] 80 (http) open

usuario@laptop ~ % nc -vz tonejito.cf 443
tonejito.cf [20.213.120.169] 443 (https) open
```

## Verifica que `ingress-nginx` responda peticiones HTTP

Intenta acceder a la página con el nombre de dominio del equipo

- **Obtendrás un error 404 de HTTP**, esto es normal porque no se ha configurado nada aún

```
usuario@laptop ~ % curl -vk# 'http://tonejito.cf/' 
*   Trying 20.213.120.169:80...
* Connected to tonejito.cf (20.213.120.169) port 80 (#0)
> GET / HTTP/1.1
> Host: tonejito.cf
> User-Agent: curl/7.79.1
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 404 Not Found
< Date: Tue, 07 Jun 2022 05:06:07 GMT
< Content-Type: text/html
< Content-Length: 146
< Connection: keep-alive
< 
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>
* Connection #0 to host tonejito.cf left intact
```

Abre la página web del servidor utilizando un navegador web

- **También recibirás un error 404 de HTTP** porque aún no se realiza la configuración de [la siguiente sección][siguiente]

| Ingress-Nginx - Página inicial
|:------------------------------:|
| ![](img/kubernetes-ingress-nginx-404-default.png)

--------------------------------------------------------------------------------

## Verifica la configuración

Reinicia el equipo remoto para verificar que los cambios sean persistentes

```
root@example:~# reboot
```

!!! danger
    - Verifica que **TODAS** las configuraciones que hiciste estén presentes respués de reiniciar la máquina antes de continuar con [la siguiente sección][siguiente]

!!! note
    - Continúa en [la siguiente página][siguiente] si el _deployment_ y _pod_ del _ingress controller_ se encuentran listos y puedes visualizar la página web predeterminada en tu nombre de dominio

--------------------------------------------------------------------------------

|                 ⇦           |        ⇧      |                  ⇨            |
|:----------------------------|:-------------:|------------------------------:|
| [Página anterior][anterior] | [Arriba](../) | [Página siguiente][siguiente] |

[anterior]: ../k3s-install
[siguiente]: ../k8s-deployments
