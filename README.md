# 🌿 Mundo Limpio Theme

Un tema child elegante y optimizado para PrestaShop 1.7+ especializado en productos de limpieza sustentables y eco-friendly.

![Mundo Limpio Theme](assets/img/theme-preview.png)

## ✨ Características Principales

### 🎨 Diseño Moderno y Elegante
- Header sticky con comportamiento inteligente de scroll
- Hero section impactante con animaciones
- Footer informativo y profesional
- Diseño completamente responsive (móvil, tablet, desktop)
- Animaciones suaves y micro-interacciones

### 🚀 Optimización y Performance
- **Tailwind CSS** para desarrollo rápido y optimizado
- CSS y JavaScript minificados
- Lazy loading de imágenes
- Animaciones optimizadas para performance
- Código limpio y bien estructurado

### 🌱 Tema Sustentable
- Colores y elementos visuales enfocados en ecología
- Secciones específicas para productos eco-friendly
- Testimonios y valores de sustentabilidad
- Call-to-actions orientados a responsabilidad ambiental

### 📱 Experiencia Mobile-First
- Menú móvil animado y funcional
- Búsqueda optimizada para dispositivos táctiles
- Interacciones touch-friendly
- Performance optimizada en dispositivos móviles

## 📋 Requisitos

- **PrestaShop**: 1.7.0 o superior
- **PHP**: 7.4 o superior
- **Node.js**: 14.x o superior (para desarrollo)
- **NPM**: 6.x o superior (para desarrollo)

## 🛠️ Instalación

### 1. Descargar e Instalar el Tema

```bash
# Clonar el repositorio en la carpeta de temas
cd /ruta/a/tu/prestashop/themes/
git clone https://github.com/axelbriones/mundolimpiotheme.git

# O descargar y extraer el ZIP
```

### 2. Instalar Dependencias de Desarrollo

```bash
cd mundolimpiotheme
npm install
```

### 3. Activar el Tema

1. Ve al **Back Office** de PrestaShop
2. Navega a **Diseño > Tema y Logotipo**
3. Selecciona "Mundo Limpio Theme"
4. Haz clic en **"Usar este tema"**

## 🔧 Desarrollo

### Comandos Disponibles

```bash
# Compilar CSS una sola vez
npm run build

# Modo desarrollo con watch automático
npm run watch

# Limpiar archivos generados
npm run clean

# Optimizar para producción
npm run production
```

### Estructura de Archivos

```
mundolimpiotheme/
├── assets/
│   ├── css/
│   │   ├── src/
│   │   │   └── main.css          # CSS fuente con Tailwind
│   │   └── theme.css             # CSS compilado
│   ├── js/
│   │   └── theme.js              # JavaScript principal
│   └── img/
│       ├── hero-bg.jpg           # Imagen de fondo del hero
│       └── ...
├── config/
│   └── theme.yml                 # Configuración del tema
├── templates/
│   ├── layouts/
│   │   └── layout-both-columns.tpl
│   ├── partials/
│   │   ├── header.tpl            # Header del tema
│   │   ├── footer.tpl            # Footer del tema
│   │   └── hero.tpl              # Sección hero
│   └── index.tpl                 # Página de inicio
├── theme.yml                     # Configuración principal
├── package.json                  # Dependencias de Node.js
└── README.md                     # Este archivo
```

## 🎨 Personalización

### Colores del Tema

Los colores principales están definidos en `assets/css/src/main.css`:

```css
:root {
  --primary-green: #16a34a;
  --primary-green-light: #22c55e;
  --primary-green-dark: #15803d;
  --secondary-green: #dcfce7;
  --accent-color: #f59e0b;
  /* ... más variables */
}
```

### Modificar el Hero Section

Edita `templates/partials/hero.tpl` para cambiar:
- Texto del título y descripción
- Imagen de fondo
- Botones de call-to-action
- Características destacadas

### Agregar Nuevas Secciones

1. Crea un nuevo archivo `.tpl` en `templates/partials/`
2. Inclúyelo en `templates/index.tpl` o el layout correspondiente
3. Agrega los estilos necesarios en `assets/css/src/main.css`

## 📸 Imágenes Requeridas

Asegúrate de tener estas imágenes en `assets/img/`:

- `hero-bg.jpg` (1920x1080px) - Fondo del hero section
- `about-image.jpg` (800x600px) - Imagen de la sección "Sobre nosotros"
- `og-default.jpg` (1200x630px) - Imagen por defecto para redes sociales

## 🔌 Hooks Utilizados

El tema utiliza los siguientes hooks de PrestaShop:

- `displayTop` - Elementos del header
- `displayHome` - Productos destacados en homepage
- `displayFooterAfter` - Contenido adicional del footer
- `displayLeftColumn` - Contenido de columna izquierda
- `displayRightColumn` - Contenido de columna derecha
- `displayContentWrapperTop` - Contenido superior de páginas
- `displayContentWrapperBottom` - Contenido inferior de páginas

## 🌍 Multi-idioma

El tema está preparado para múltiples idiomas. Los textos están en español por defecto, pero puedes traducir:

1. Crea archivos de traducción en `translations/`
2. Usa la función `{l s='Texto a traducir' mod='mundolimpiotheme'}` en templates

## 📱 Responsive Design

### Breakpoints utilizados:

- **sm**: 640px
- **md**: 768px  
- **lg**: 1024px
- **xl**: 1280px
- **2xl**: 1536px

### Características Responsive:

- Header adaptativo con menú móvil
- Hero section optimizado para todos los dispositivos
- Grid flexible para productos y categorías
- Footer que se adapta a pantallas pequeñas

## ⚡ Optimización de Performance

### Técnicas implementadas:

- **Lazy loading** de imágenes
- **CSS crítico** inline
- **JavaScript diferido**
- **Compresión de assets**
- **Animaciones optimizadas** con `transform` y `opacity`
- **Throttling** en eventos de scroll

### Métricas objetivo:

- **First Contentful Paint**: < 1.5s
- **Largest Contentful Paint**: < 2.5s
- **Cumulative Layout Shift**: < 0.1
- **First Input Delay**: < 100ms

## 🐛 Resolución de Problemas

### El CSS no se actualiza

```bash
# Limpiar caché y recompilar
npm run clean
npm run build
```

### Errores en JavaScript

1. Verifica que `assets/js/theme.js` esté incluido
2. Comprueba la consola del navegador para errores
3. Asegúrate de que jQuery esté cargado (incluido en PrestaShop)

### Problemas con Tailwind CSS

1. Verifica que `npm run watch` esté ejecutándose
2. Comprueba que las clases estén en la configuración de Tailwind
3. Purga el CSS: `npm run production`

## 🔧 Configuración Avanzada

### Variables de entorno

Crea un archivo `.env` para configuraciones específicas:

```env
NODE_ENV=production  # development | production
THEME_DEBUG=false
CSS_MINIFY=true
JS_MINIFY=true
```

### Configuración de Tailwind

Edita `tailwind.config.js` para personalizar:

```javascript
module.exports = {
  content: [
    "./templates/**/*.tpl",
    "./assets/**/*.js"
  ],
  theme: {
    extend: {
      colors: {
        'primary': '#16a34a',
        // tus colores personalizados
      }
    }
  }
}
```

## 📊 Analíticas y SEO

### Schema.org implementado:

- Organization markup
- Product markup (en páginas de producto)
- Breadcrumb markup
- Local Business markup

### Meta tags incluidos:

- Open Graph para redes sociales
- Twitter Cards
- Meta description personalizable
- Canonical URLs

## 🛡️ Seguridad

### Medidas implementadas:

- Sanitización de inputs
- Protección CSRF
- Headers de seguridad
- Validación de formularios
- Escape de variables Smarty

## 🔄 Actualizaciones

### Para actualizar el tema:

1. **Backup** de tu instalación actual
2. Descarga la nueva versión
3. Compara archivos modificados
4. Ejecuta `npm install` si hay nuevas dependencias
5. Recompila assets: `npm run build`

### Versionado

Seguimos [Semantic Versioning](https://semver.org/):

- **MAJOR**: Cambios incompatibles
- **MINOR**: Nueva funcionalidad compatible
- **PATCH**: Correcciones de bugs

## 🤝 Contribuir

1. Fork del repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

### Guidelines de contribución:

- Código limpio y documentado
- Tests para nuevas funcionalidades
- Compatibilidad con PrestaShop 1.7+
- Responsive design obligatorio
- Performance optimizado

## 📝 Changelog

### v1.0.0 (2024-12-XX)
- ✨ Lanzamiento inicial
- 🎨 Header sticky inteligente
- 🌟 Hero section animado
- 📱 Diseño responsive completo
- ⚡ Optimización de performance
- 🌱 Tema ecológico y sustentable

## 📄 Licencia

Este tema es propiedad de **Mundo Limpio** y está licenciado bajo términos propietarios.

Para licencias comerciales, contacta: info@mundolimpio.com

## 📞 Soporte

- **Email**: soporte@mundolimpio.com
- **Teléfono**: +54 9 3764 12-3456
- **Horarios**: Lun-Vie 8:00-18:00, Sáb 8:00-13:00

## 🙏 Créditos

- **Desarrollado por**: Mundo Limpio Team
- **Diseño**: Basado en principios de diseño sustentable
- **Tecnologías**: PrestaShop, Tailwind CSS, JavaScript ES6+
- **Iconos**: Material Icons by Google
- **Fuentes**: Inter by Rasmus Andersson

---

**¡Gracias por elegir Mundo Limpio Theme! 🌿**

*Juntos por un comercio electrónico más sustentable.*