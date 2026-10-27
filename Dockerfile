FROM nginx:alpine

# Copia todo el sitio (ver .dockerignore): no hay que listar cada archivo nuevo.
COPY . /usr/share/nginx/html/
EXPOSE 80
