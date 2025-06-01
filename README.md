# Proyecto con Docker y Docker Compose

Este proyecto utiliza `Docker` y `docker-compose` para gestionar los servicios necesarios.

## Requisitos Linux

1. **Docker**: Puedes descargarlo e instalarlo desde [Docker Desktop](https://www.docker.com/products/docker-desktop).

## Requisitos Windows

Asegúrate de tener instalados los siguientes componentes:

1. **Virtualización**: Tener virtualización activada desde BIOS
2. **Docker**: Puedes descargarlo e instalarlo desde [Docker Desktop](https://www.docker.com/products/docker-desktop).
3. **WSL 2**: Necesario ejecutar Docker, en caso de no tenerlo y que Docker Desktop no te lo proporcione instala con:
[Documentación Microsoft](https://learn.microsoft.com/es-es/windows/wsl/install).
```bash
wsl --install
```
4. **Docker Compose**: cuando instalas Docker este ya viene por defecto.

---
# Para Ejecutar

## Crear archivo **docker-compose.yml** en directorio de preferencia
```yaml
services:
  oracle-db:
    image: vicenterivas/enganchai:oracle-db-latest
    container_name: oracle-db
    environment:
      ORACLE_PASSWORD: "3ng4nchAI4adm1nUs3r"
    ports:
      - "1521:1521"   # Listener de Oracle
    volumes:
      - oracle-data:/opt/oracle/oradata
    healthcheck:
      test: ["CMD", "bash", "-c", "echo 'SELECT 1 FROM dual;' | sqlplus -s sys/${ORACLE_PASSWORD}@//localhost:1521/XEPDB1 as sysdba | grep -q \"1\""]
      interval: 30s
      timeout: 10s
      retries: 5

  flask:
    image: vicenterivas/enganchai:flask-latest
    container_name: flask
    ports:
      - "5001:5001"
    depends_on:
      oracle-db:
        condition: service_healthy

  express:
    image: vicenterivas/enganchai:express-latest
    container_name: express
    ports:
      - "5000:5000"
    depends_on:
      - flask
      - oracle-db

  client:
    image: vicenterivas/enganchai:client-latest
    container_name: client
    ports:
      - "3000:3000"
    environment:
      NEXT_PUBLIC_EXPRESS_MIDDLEWARE: "http://express:5000"
    depends_on:
      - express
      - flask

volumes:
  oracle-data:
    driver: local

  
```

## Descargar Imagenes
```bash
docker compose pull
```

## Levantar proyecto
```bash
docker compose up
```


---
# Para desarrollo

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




