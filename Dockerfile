FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html
COPY robots.txt /usr/share/nginx/html/robots.txt
COPY sitemap.xml /usr/share/nginx/html/sitemap.xml
COPY og.png /usr/share/nginx/html/og.png

COPY logo.png /usr/share/nginx/html/logo.png
COPY favicon.png /usr/share/nginx/html/favicon.png
COPY hero-planta.webp /usr/share/nginx/html/hero-planta.webp
EXPOSE 80
