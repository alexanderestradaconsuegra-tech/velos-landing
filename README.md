# Autix — Landing page

Landing page de **Autix**: sistemas a medida para cualquier negocio (ventas, agenda, inventario, clientes, cobros, webs inteligentes y asistentes opcionales). Muestra los sistemas reales velOS, Merka POS y Autix Agenda. Es un único archivo HTML estático (`index.html`), sin build. Diseño y animaciones de scroll basados en la plantilla gratuita de 8B (MIT, ver `LICENSE-8b-template`); GSAP, ScrollTrigger y Lenis se cargan desde jsDelivr y la tipografía desde Google Fonts.

## Estructura

```
index.html      → la página completa (HTML + CSS + JS inline)
logo.png, favicon.png, og.jpg → marca
hero-planta.webp, planta-1..5.webp → foto del hero y recortes (derivados de hero-planta.webp)
rubro-*.svg → imágenes de ejemplo de cada rubro (mascotas, heladería, jurídico, clínica, distribución): reemplazar por fotos reales y cambiar el `src` en index.html
demo-sistema.mp4 + demo-sistema-poster.jpg → video de un sistema funcionando (sección #caso). Si no existen, se muestra un aviso
LICENSE-8b-template → licencia MIT del diseño base
robots.txt       → indexación para buscadores
sitemap.xml       → mapa del sitio
vercel.json       → configuración para despliegue en Vercel
netlify.toml      → configuración para despliegue en Netlify
.nojekyll         → evita el procesamiento Jekyll en GitHub Pages
```

## Dominio

Esta landing va en la **raíz** de `autix.pro` (marketing). El sistema velOS sigue operando en el subdominio `velos.autix.pro`. Patrón estándar: dominio raíz vende, subdominio opera.

## Desplegar

### EasyPanel (recomendado, VPS propio)
El repo trae un `Dockerfile` (nginx:alpine, puerto 80) que copia `index.html` y todos los assets.
1. En EasyPanel: **Proyecto → + Servicio → App**.
2. **Source → Github**: repo `alexanderestradaconsuegra-tech/velos-landing`, rama `main` (o la rama a probar), **Build → Dockerfile**.
3. **Domains**: agrega `autix.pro` y `www.autix.pro` apuntando al puerto `80`. EasyPanel emite el SSL.
4. En DNS (Hostinger) crea el registro `A` de `autix.pro` hacia la IP del VPS.
5. Para actualizar: push a la rama configurada y **Deploy** (o activa Auto Deploy con el webhook de GitHub).

El `Dockerfile` copia todo el sitio (menos lo listado en `.dockerignore`): los archivos nuevos, como el video, llegan solos al contenedor. Recomendado: comprimir el video (H.264, ~1080p, bajo 25 MB) para que cargue rápido.

### Otras opciones
Al ser un sitio 100% estático, se puede servir desde cualquiera de estas opciones sin cambios. Alternativas si no usas el VPS: **Vercel** o **Netlify** (SSL automático y gratis).

### Vercel (gratis)
1. Entra a [vercel.com/new](https://vercel.com/new) e importa este repositorio.
2. No hace falta configurar nada — Vercel detecta que es estático.
3. En **Project → Settings → Domains** agrega `autix.pro` y `www.autix.pro`.
4. Vercel te da los registros DNS exactos a crear. En Hostinger: **hPanel → Dominios → autix.pro → DNS / Nameservers**, y ahí agregas esos registros (normalmente un `A` apuntando a `76.76.21.21` para la raíz, y un `CNAME` de `www` a `cname.vercel-dns.com` — Vercel te confirma los valores actuales al conectar el dominio).

### Netlify
1. [app.netlify.com/start](https://app.netlify.com/start) → conectar este repositorio.
2. Build command: (vacío). Publish directory: `.`
3. En **Site settings → Domain management** agrega `autix.pro` y sigue las instrucciones de DNS que te da Netlify (se configuran igual en Hostinger → DNS).

### Mantener el dominio completo en Hostinger (sin Vercel/Netlify)
Si prefieres que Hostinger sirva el archivo directamente:
1. **hPanel → Sitios web → autix.pro → Administrar → Administrador de archivos** (o vía FTP/SFTP).
2. Sube `index.html`, `robots.txt` y `sitemap.xml` a la carpeta pública del dominio (normalmente `public_html/`).
3. El SSL gratuito de Hostinger (Let's Encrypt) se activa desde **hPanel → SSL**.
4. Cada vez que actualices la landing, vuelve a subir `index.html` por el administrador de archivos o FTP — este método no se conecta a este repositorio de GitHub automáticamente.

### GitHub Pages
1. En este repo: **Settings → Pages → Source: Deploy from a branch → main / (root)**.
2. Se publica en `https://alexanderestradaconsuegra-tech.github.io/velos-landing/`.
3. Para usar `autix.pro`, agrega un archivo `CNAME` con el dominio dentro del repo y en Hostinger crea un registro `CNAME` de `autix.pro` (o `www`) apuntando a `alexanderestradaconsuegra-tech.github.io`. Para la raíz del dominio (apex) generalmente hace falta un registro `A` a las IPs de GitHub Pages en vez de `CNAME` — GitHub lo explica al activar el dominio personalizado.

### VPS propio (nginx, junto al sistema Campolac)
```bash
git clone https://github.com/alexanderestradaconsuegra-tech/velos-landing /var/www/velos-landing
```
Bloque nginx de ejemplo:
```nginx
server {
    listen 80;
    server_name autix.pro www.autix.pro;
    root /var/www/velos-landing;
    index index.html;
    location / { try_files $uri $uri/ =404; }
}
```
Para actualizar tras un cambio: `cd /var/www/velos-landing && git pull && systemctl reload nginx` (o `docker restart <contenedor>` si se sirve por Docker). En Hostinger apuntarías el `A` de `autix.pro` a la IP de tu VPS (igual que ya hiciste para `velos.autix.pro`).

## Actualizar el contenido

El archivo se genera y edita habitualmente desde Claude como Artifact. Para publicar una edición nueva: reemplaza `index.html` con la versión actualizada, haz commit y push — el hosting elegido se redepliega automáticamente en cada push a `main`.
