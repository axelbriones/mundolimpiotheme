# Tema PrestaShop: Mundo Limpio Iguazú

Este es el repositorio para el tema personalizado "Mundo Limpio" para PrestaShop 1.7+.

## Características

*   **Tema Hijo**: Basado en el tema `classic` de PrestaShop, lo que facilita las actualizaciones y el mantenimiento.
*   **Tailwind CSS**: Utiliza [Tailwind CSS](https://tailwindcss.com/) para un desarrollo de frontend rápido, moderno y basado en utilidades.
*   **Material Icons**: Integrado con la librería de Material Icons que viene por defecto en PrestaShop.

## Requisitos

*   [Node.js](https://nodejs.org/) (versión 14.x o superior)
*   NPM (generalmente se instala con Node.js)

## Instalación y Desarrollo

Para trabajar con este tema en tu entorno de desarrollo local, sigue estos pasos.

### 1. Clonar o descargar el repositorio

Asegúrate de que los archivos del tema estén dentro de la carpeta `/themes/mundolimpiotheme` de tu instalación de PrestaShop.

### 2. Instalar dependencias

Abre tu terminal, navega hasta la raíz de la carpeta de este tema (`/themes/mundolimpiotheme`) y ejecuta el siguiente comando. Esto leerá el archivo `package.json` e instalará las herramientas de desarrollo necesarias (Tailwind, PostCSS, etc.) en una nueva carpeta llamada `node_modules`.

```bash
npm install
```

**Nota:** Solo necesitas ejecutar este comando la primera vez que configures el proyecto.

### 3. Compilar el CSS

Este tema utiliza Tailwind CSS, por lo que el archivo CSS principal (`assets/css/theme.css`) debe ser compilado a partir de los archivos fuente.

**Para compilar una sola vez:**

Ejecuta este comando para procesar `assets/css/src/main.css` y generar el archivo final `assets/css/theme.css` que PrestaShop utiliza.

```bash
npm run build
```

**Para compilar automáticamente mientras desarrollas:**

Usa este comando para que el proceso se mantenga activo. Cada vez que guardes un cambio en un archivo `.tpl` o en `assets/css/src/main.css`, el CSS se reconstruirá automáticamente. Es la opción recomendada durante el desarrollo.

```bash
npm run watch
```

## Flujo de trabajo

1.  Asegúrate de tener el comando `npm run watch` ejecutándose en tu terminal.
2.  Modifica los archivos `.tpl` añadiendo las clases de utilidad de Tailwind CSS según sea necesario.
3.  Si necesitas añadir CSS personalizado que no se puede lograr con las utilidades de Tailwind, añádelo en `assets/css/src/main.css`.
4.  El compilador generará automáticamente el `theme.css` final.
5.  Refresca tu tienda en el navegador para ver los cambios.

## Para Producción

**NUNCA** subas la carpeta `node_modules` a tu servidor de producción.

El proceso es:
1.  Ejecuta `npm run build` en tu máquina local para generar la versión final y optimizada de `assets/css/theme.css`.
2.  Sube los archivos de tu tema (incluyendo el `theme.css` compilado) a tu servidor de producción. El servidor no necesita Node.js, npm, ni nada del entorno de desarrollo.