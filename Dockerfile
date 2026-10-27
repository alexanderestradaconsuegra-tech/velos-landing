FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html
COPY robots.txt /usr/share/nginx/html/robots.txt
COPY sitemap.xml /usr/share/nginx/html/sitemap.xml
COPY og.jpg /usr/share/nginx/html/og.jpg

COPY logo.png /usr/share/nginx/html/logo.png
COPY favicon.png /usr/share/nginx/html/favicon.png
COPY hero-planta.webp /usr/share/nginx/html/hero-planta.webp
COPY planta-1.webp planta-2.webp planta-3.webp planta-4.webp planta-5.webp /usr/share/nginx/html/
EXPOSE 80
