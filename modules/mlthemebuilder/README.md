# MlThemeBuilder - Módulo Personalizador de Tema para Mundo Limpio (PrestaShop)

**Autor:** Byron Briones
**Sitio Web:** [bbrion.es](https://bbrion.es)
**Versión:** 1.0.0
**Compatible con PrestaShop:** 1.7.6+

## Descripción

**MlThemeBuilder** es un módulo para PrestaShop diseñado específicamente para la tienda "Mundo Limpio". Permite una personalización avanzada y modular de la apariencia del frontend, ofreciendo control sobre diversas secciones de la página de inicio y otros elementos del tema. El objetivo es proporcionar una herramienta flexible para que los administradores de la tienda puedan adaptar el diseño a sus necesidades sin requerir modificaciones directas de código en el tema.

El módulo se centra en la facilidad de uso a través de un panel de administración intuitivo, permitiendo la gestión de contenido multiidioma, estilos globales y configuraciones específicas para cada sección.

## Características Principales (Versión Inicial)

*   **Gestión de Secciones Dinámicas:**
    *   Secciones predefinidas para la página de inicio: Hero, Servicios, Productos, Banner CTA, Marcas, Ecología, Contacto, HTML Personalizado.
    *   Sistema de arrastrar y soltar para reordenar las secciones.
    *   Activación/desactivación individual de secciones.
    *   Configuración detallada para cada tipo de sección (títulos, textos, imágenes, colores, layouts, etc.).
*   **Personalización de Estilos Globales:**
    *   Paleta de colores principal (primario, secundario, texto, enlaces, fondos).
    *   Configuración de tipografía (fuentes principales y secundarias, tamaño base, escala de encabezados, enlace a Google Fonts).
    *   Ajustes de layout (ancho máximo del contenedor, padding de secciones, radio de borde de botones).
*   **Gestión de Contenido Específico:**
    *   **Servicios:** Creación y gestión de elementos de servicio (icono, título, descripción) para ser mostrados en la sección de servicios.
    *   **Marcas:** Administración de logos de marcas o socios (imagen, nombre, URL) para el slider de marcas.
*   **Ajustes Avanzados:**
    *   Inclusión de CSS personalizado.
    *   Inclusión de JavaScript personalizado (en cabecera o pie de página).
    *   Opciones para habilitar/deshabilitar animaciones CSS del módulo y carga diferida (lazy loading) de imágenes.
    *   Soporte opcional para modo oscuro (mediante variables CSS y estilos).
    *   Control de caché para las secciones renderizadas.
*   **Importar/Exportar Configuración:**
    *   Funcionalidad para exportar toda la configuración del módulo (estructura de secciones, contenido, estilos, etc.) a un archivo JSON.
    *   Posibilidad de importar una configuración previamente exportada, con opciones de sobrescribir todo o fusionar/añadir.
*   **Multiidioma y Multitienda (Básico):**
    *   Campos de texto configurables por idioma.
    *   Estructura de datos preparada para multitienda (aunque la lógica detallada de multitienda puede requerir mayor desarrollo según necesidades).
*   **Panel de Administración Integrado:**
    *   Controlador de administración dedicado con una interfaz clara dividida en pestañas para fácil acceso a todas las configuraciones.
    *   Uso de AJAX para operaciones fluidas (reordenar, cambiar estado, guardar configuraciones de sección, etc.).

## Estructura del Módulo

El módulo sigue la estructura estándar de PrestaShop:

```
modules/mlthemebuilder/
├── mlthemebuilder.php              # Archivo principal del módulo
├── config.xml                      # Configuración del módulo
├── README.md                       # Este archivo
├── logo.png                        # Logo del módulo (pendiente)
├── classes/                        # Clases ObjectModel (MlThemeSection, MlThemeService, etc.)
├── controllers/admin/              # Controlador de administración (AdminMlThemeBuilderController)
├── views/                          # Plantillas, CSS, JS, imágenes
│   ├── css/                        # Archivos CSS (front.css, admin.css, animations.css)
│   ├── js/                         # Archivos JavaScript (front.js, admin.js)
│   ├── img/                        # Imágenes del módulo (iconos, fondos de sección, logos de marcas)
│   └── templates/                  # Plantillas Smarty (.tpl)
│       ├── admin/                  # Plantillas para el panel de administración
│       └── hook/                   # Plantillas para los hooks del frontend
├── translations/                   # Archivos de traducción (es.php, en.php)
├── upgrade/                        # Scripts de actualización del módulo
├── ajax/                           # Manejador de peticiones AJAX (si es necesario fuera del controlador)
└── sql/                            # Archivos SQL para instalación y desinstalación
```

## Instalación

1.  Comprimir la carpeta `mlthemebuilder` en un archivo ZIP.
2.  Ir a Módulos > Catálogo de Módulos en el Back Office de PrestaShop.
3.  Hacer clic en "Subir un módulo" y seleccionar el archivo ZIP.
4.  Una vez subido, buscar "Mundo Limpio Theme Builder" en la lista de módulos e instalarlo.
5.  Tras la instalación, aparecerá una nueva pestaña "Theme Builder" (o similar, según configuración del Tab) en el menú del Back Office (probablemente bajo "Mejorar" o "Diseño"), donde se podrá configurar el módulo.

## Próximos Pasos (Desarrollo)

*   Completar la implementación de todas las funcionalidades AJAX en `AdminMlThemeBuilderController.php`.
*   Refinar las plantillas de configuración de cada sección en `views/templates/admin/sections/`.
*   Asegurar que todas las opciones de configuración se guardan y cargan correctamente usando `MlThemeSetting.php` o `Configuration.php` de PrestaShop.
*   Probar exhaustivamente la funcionalidad de importación/exportación.
*   Desarrollar y probar los scripts de actualización (`upgrade/*.php`) a medida que se añadan nuevas versiones.
*   Crear el `logo.png` para el módulo.
*   Añadir más traducciones y completar las existentes.

## Contribuciones

Por el momento, este es un módulo desarrollado a medida para "Mundo Limpio". Para modificaciones o mejoras, contactar al autor.

---

Este `README.md` proporciona una visión general. Se actualizará a medida que el módulo evolucione.
