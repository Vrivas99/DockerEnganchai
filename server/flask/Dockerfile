FROM python:3.10-slim

# 1) Directorio de trabajo
WORKDIR /server/flask

# 2) Copiamos sólo requirements.txt (para cachear esta capa)
COPY requirements.txt .

# 3) Instalar dependencias de compilación y librerías de sistema:
#    - build-essential y python3-dev para compilar paquetes con extensiones C
#    - libgl1 y libglib2.0-0 para OpenCV
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      build-essential \
      python3-dev \
      libgl1 \
      libglib2.0-0 \
 && pip install --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt \
 # 4) Limpiar herramientas de compilación para aligerar la imagen
 && apt-get purge -y build-essential python3-dev \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

# 5) Copiamos el resto del código
COPY . .

# 6) Exponer puerto y comando de arranque
EXPOSE 5001
CMD ["python", "flaskServer.py"]
