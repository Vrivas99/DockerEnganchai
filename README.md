# Proyecto con Docker y Docker Compose

Este proyecto utiliza `Docker` y `docker-compose` para gestionar los servicios necesarios.

## Requisitos

Asegúrate de tener instalados los siguientes componentes:

1. **Docker**: Puedes descargarlo e instalarlo desde [Docker Desktop](https://www.docker.com/products/docker-desktop).
2. **Docker Compose**: cuando instalas Docker este ya viene por defecto.

## Archivos necesarios

- Dockerfile
- docker-compose.yml
- .env

## Build e inicializar Docker-compose
```bash
docker compose up --build
```

este comando iniciará el **docker-compose.yml** el cual hará un build de los **Dockerfiles** que estan en la raíz de cada carpeta

```plaintext
client/
|  └── Dockerfile
|  └── .env
server/
|  └── express/
|      └── Dockerfile
|      └── .env
|
|  └── flask/
|      └── Dockerfile
|
└── docker-compose.yml
```

### Levantar contenedores ya buildeados:
**-d (opcional) = significa levantarlo detached (segundo plano)**
```bash
docker compose up -d
```

### Levantar contenedor especifico: **client, express, flask**
```bash
docker compose up -d [nombre_contenedor]
```
### Para detener los servicios, utiliza:
```bash
docker compose down
```
### Ver contenedores activos:
```bash
docker ps
```
### Ver contenedores (activos e inactivos):
```bash
docker ps -a
```
### Ver imágenes disponibles:
```bash
docker images
```
### Acceder a un contenedor en ejecución (en caso de querer ejecutar comando de linux)
```bash
docker exec -it [nombre_contenedor] /bin/bash
```
### Eliminar contenedor (debe estar apagado):
```bash
docker rm [nombre_contenedor]
```
### Eliminar imagen
```bash
docker rmi [nombre_imagen o id]
```




