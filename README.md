# velOS — Landing page

Landing page de **velOS by Autix**. Es un único archivo HTML estático (`index.html`), sin build ni dependencias — las fuentes se cargan desde Google Fonts vía CDN y todos los íconos son SVG inline.

## Estructura

```
index.html      → la página completa (HTML + CSS + JS inline)
robots.txt       → indexación para buscadores
sitemap.xml       → mapa del sitio
vercel.json       → configuración para despliegue en Vercel
netlify.toml      → configuración para despliegue en Netlify
.nojekyll         → evita el procesamiento Jekyll en GitHub Pages
```

Antes de publicar, reemplaza `TU-DOMINIO-AQUI` en `robots.txt` y `sitemap.xml` por el dominio final.

## Desplegar

Al ser un sitio 100% estático, se puede servir desde cualquiera de estas opciones sin cambios:

### Vercel (recomendado, gratis)
1. Entra a [vercel.com/new](https://vercel.com/new) e importa este repositorio.
2. No hace falta configurar nada — Vercel detecta que es estático.
3. Conecta el dominio en **Project → Settings → Domains**.

### Netlify
1. [app.netlify.com/start](https://app.netlify.com/start) → conectar este repositorio.
2. Build command: (vacío). Publish directory: `.`
3. Conectar dominio en **Site settings → Domain management**.

### GitHub Pages
1. En este repo: **Settings → Pages → Source: Deploy from a branch → main / (root)**.
2. Se publica en `https://alexanderestradaconsuegra-tech.github.io/velos-landing/`.
3. Para dominio propio, agrega un archivo `CNAME` con el dominio y configúralo en tu proveedor DNS (registro `CNAME` apuntando a `alexanderestradaconsuegra-tech.github.io`).

### VPS propio (nginx, junto al sistema Campolac)
```bash
git clone https://github.com/alexanderestradaconsuegra-tech/velos-landing /var/www/velos-landing
```
Bloque nginx de ejemplo:
```nginx
server {
    listen 80;
    server_name TU-DOMINIO-AQUI;
    root /var/www/velos-landing;
    index index.html;
    location / { try_files $uri $uri/ =404; }
}
```
Para actualizar tras un cambio: `cd /var/www/velos-landing && git pull && systemctl reload nginx` (o `docker restart <contenedor>` si se sirve por Docker).

## Actualizar el contenido

El archivo se genera y edita habitualmente desde Claude como Artifact. Para publicar una edición nueva: reemplaza `index.html` con la versión actualizada, haz commit y push — el hosting elegido se redepliega automáticamente en cada push a `main`.
