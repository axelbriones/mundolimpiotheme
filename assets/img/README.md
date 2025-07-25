# 🖼️ Imágenes Requeridas - Mundo Limpio Theme

## 📋 **Imágenes Obligatorias**

Para que el tema funcione correctamente, necesitas estas imágenes en la carpeta `assets/img/`:

### **1. hero-bg.jpg** ⭐ **PRINCIPAL**
- **Tamaño**: 1920x1080px (Full HD)
- **Formato**: JPG
- **Peso**: Máximo 500KB
- **Descripción**: Imagen de fondo del hero section
- **Tema**: Productos de limpieza eco-friendly, naturaleza, hogar limpio
- **Colores**: Tonos verdes, naturales, limpios

### **2. about-image.jpg**
- **Tamaño**: 800x600px
- **Formato**: JPG
- **Peso**: Máximo 300KB
- **Descripción**: Imagen para la sección "Sobre Nosotros"
- **Tema**: Equipo de trabajo, productos, instalaciones

### **3. og-default.jpg**
- **Tamaño**: 1200x630px
- **Formato**: JPG
- **Peso**: Máximo 200KB
- **Descripción**: Imagen por defecto para redes sociales (Open Graph)
- **Tema**: Logo + productos representativos

### **4. favicon.ico**
- **Tamaño**: 32x32px
- **Formato**: ICO
- **Peso**: Máximo 10KB
- **Descripción**: Icono del sitio web

## 🎨 **Imágenes Opcionales (Para mejorar el diseño)**

### **5. products/** (Carpeta)
- **Descripción**: Imágenes de productos
- **Tamaños**: 600x600px (productos), 300x300px (thumbnails)
- **Formato**: JPG o PNG
- **Nombres sugeridos**:
  - `product-eco-1.jpg`
  - `product-hogar-1.jpg`
  - `product-industrial-1.jpg`

### **6. categories/** (Carpeta)
- **Descripción**: Imágenes para categorías
- **Tamaño**: 400x300px
- **Formato**: JPG
- **Nombres sugeridos**:
  - `categoria-hogar.jpg`
  - `categoria-industrial.jpg`
  - `categoria-eco.jpg`

### **7. team/** (Carpeta)
- **Descripción**: Fotos del equipo
- **Tamaño**: 300x300px
- **Formato**: JPG

## 📐 **Especificaciones Técnicas**

### **Calidad de Imagen**
- **JPG**: 85% de calidad
- **PNG**: Optimizado con herramientas como TinyPNG
- **WebP**: Formato moderno recomendado (el tema lo genera automáticamente)

### **Optimización**
```bash
# Instalar herramientas de optimización (opcional)
npm install -g imagemin-cli
npm install -g squoosh-cli

# Optimizar imágenes
imagemin assets/img/*.jpg --out-dir=assets/img/optimized/
```

### **Responsive Images**
El tema generará automáticamente estas versiones:
- **Mobile**: 640px de ancho
- **Tablet**: 1024px de ancho
- **Desktop**: 1920px de ancho

## 🔧 **Configuración en CSS**

Las imágenes se referencian en el CSS de esta manera:

```css
/* Hero background */
.hero-image {
  background-image: url('{$theme_assets}img/hero-bg.jpg');
}

/* About image */
.about-image img {
  src: '{$theme_assets}img/about-image.jpg'
}
```

## 📱 **Imágenes Responsive**

### **Hero Section**
```html
<!-- Desktop -->
<source media="(min-width: 1024px)" srcset="hero-bg.jpg">
<!-- Tablet -->
<source media="(min-width: 768px)" srcset="hero-bg-tablet.jpg">
<!-- Mobile -->
<img src="hero-bg-mobile.jpg" alt="Hero">
```

## 🎯 **Recomendaciones de Contenido**

### **Para hero-bg.jpg:**
- ✅ Productos de limpieza eco-friendly
- ✅ Ambiente de hogar limpio y fresco
- ✅ Elementos naturales (plantas, agua limpia)
- ✅ Colores verdes y blancos predominantes
- ❌ Evitar colores muy oscuros
- ❌ Evitar demasiado texto en la imagen

### **Para about-image.jpg:**
- ✅ Equipo de trabajo sonriente
- ✅ Productos en uso
- ✅ Instalaciones de la empresa
- ✅ Certificaciones eco-friendly

## 🚀 **Implementación Rápida**

Si no tienes las imágenes listas, puedes usar estas opciones:

### **1. Imágenes de placeholder:**
Descarga imágenes temporales de:
- [Unsplash](https://unsplash.com/s/photos/eco-cleaning)
- [Pexels](https://www.pexels.com/search/green%20cleaning/)
- [Freepik](https://www.freepik.com/search?query=eco%20cleaning)

### **2. Generación automática:**
```bash
# Crear placeholders con colores del tema
convert -size 1920x1080 xc:'#16a34a' hero-bg.jpg
convert -size 800x600 xc:'#22c55e' about-image.jpg
convert -size 1200x630 xc:'#15803d' og-default.jpg
```

## ✅ **Checklist de Verificación**

- [ ] hero-bg.jpg (1920x1080px) ⭐
- [ ] about-image.jpg (800x600px)
- [ ] og-default.jpg (1200x630px)  
- [ ] favicon.ico (32x32px)
- [ ] Todas las imágenes optimizadas (<500KB cada una)
- [ ] Permisos correctos (644)
- [ ] Nombres de archivo sin espacios ni caracteres especiales

## 🔍 **Verificar Instalación**

```bash
# Verificar que las imágenes existen
ls -la assets/img/hero-bg.jpg
ls -la assets/img/about-image.jpg
ls -la assets/img/og-default.jpg
ls -la assets/img/favicon.ico

# Verificar tamaños
file assets/img/*.jpg
```

---

**💡 Tip**: Si no tienes las imágenes aún, el tema funcionará igual pero mostrará un fondo degradado verde en lugar de la imagen de fondo.