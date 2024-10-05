# Usa una imagen base de Node.js
FROM node:18 AS builder

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos package.json y package-lock.json al contenedor
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia todo el código de la aplicación al contenedor
COPY . .

# Compila la aplicación para producción
RUN npm run build

# Usa nginx para servir los archivos estáticos
FROM nginx:alpine

# Copia los archivos compilados a la carpeta correcta de nginx
COPY --from=builder /app/.next /usr/share/nginx/html

# Expone el puerto 80 para acceder a la aplicación desde el navegador
EXPOSE 80

# Arranca nginx cuando el contenedor se ejecute
CMD ["nginx", "-g", "daemon off;"]

