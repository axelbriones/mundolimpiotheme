<?php

global $_MODULE;
$_MODULE = array();

// Default strings from module main class
$_MODULE['<{mlthemebuilder}prestashop>mlthemebuilder_displayname'] = 'Mundo Limpio Theme Builder';
$_MODULE['<{mlthemebuilder}prestashop>mlthemebuilder_description'] = 'Módulo para personalizar completamente el tema de tu tienda Mundo Limpio.';
$_MODULE['<{mlthemebuilder}prestashop>mlthemebuilder_uninstall_confirm'] = '¿Estás seguro de que quieres desinstalar este módulo? Todos los datos de configuración se perderán.';

// Admin Controller & Tabs
$_MODULE['<{mlthemebuilder}prestashop>admintab_theme_builder'] = 'Theme Builder'; // For the main tab name
$_MODULE['<{mlthemebuilder}prestashop>admintab_configure_title'] = 'Configuración de Mundo Limpio Theme Builder';

// General Admin UI
$_MODULE['<{mlthemebuilder}prestashop>admin_save_success'] = 'Configuración guardada correctamente.';
$_MODULE['<{mlthemebuilder}prestashop>admin_save_error'] = 'Error al guardar la configuración.';
$_MODULE['<{mlthemebuilder}prestashop>admin_delete_confirm'] = '¿Estás seguro de que quieres eliminar este elemento?';
$_MODULE['<{mlthemebuilder}prestashop>admin_item_deleted'] = 'Elemento eliminado correctamente.';
$_MODULE['<{mlthemebuilder}prestashop>admin_item_error_delete'] = 'Error al eliminar el elemento.';
$_MODULE['<{mlthemebuilder}prestashop>admin_order_updated'] = 'Orden actualizado correctamente.';
$_MODULE['<{mlthemebuilder}prestashop>admin_order_error'] = 'Error al actualizar el orden.';
$_MODULE['<{mlthemebuilder}prestashop>admin_status_updated'] = 'Estado actualizado correctamente.';
$_MODULE['<{mlthemebuilder}prestashop>admin_status_error'] = 'Error al actualizar el estado.';
$_MODULE['<{mlthemebuilder}prestashop>admin_loading'] = 'Cargando...';
$_MODULE['<{mlthemebuilder}prestashop>admin_error_form_load'] = 'Error al cargar el formulario de configuración.';
$_MODULE['<{mlthemebuilder}prestashop>admin_img_upload_success'] = 'Imagen subida correctamente.';
$_MODULE['<{mlthemebuilder}prestashop>admin_img_upload_error'] = 'Error al subir la imagen.';
$_MODULE['<{mlthemebuilder}prestashop>admin_select_image'] = 'Por favor, selecciona un archivo de imagen.';
$_MODULE['<{mlthemebuilder}prestashop>admin_item_added'] = 'Elemento añadido correctamente.';
$_MODULE['<{mlthemebuilder}prestashop>admin_item_removed'] = 'Elemento eliminado correctamente.';


// configure.tpl Tabs
$_MODULE['<{mlthemebuilder}prestashop>admin_tab_sections'] = 'Gestión de Secciones';
$_MODULE['<{mlthemebuilder}prestashop>admin_tab_styles'] = 'Estilos Globales';
$_MODULE['<{mlthemebuilder}prestashop>admin_tab_services_manage'] = 'Gestionar Servicios';
$_MODULE['<{mlthemebuilder}prestashop>admin_tab_brands_manage'] = 'Gestionar Marcas';
$_MODULE['<{mlthemebuilder}prestashop>admin_tab_advanced'] = 'Ajustes Avanzados';
$_MODULE['<{mlthemebuilder}prestashop>admin_tab_importexport'] = 'Importar/Exportar';

// sections_manager.tpl
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_title'] = 'Gestión de Secciones de la Página de Inicio';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_infobox'] = 'Arrastra y suelta las secciones para cambiar su orden en la página de inicio. Haz clic en "Configurar" para editar el contenido y los ajustes de una sección. Usa el interruptor para activar o desactivar una sección.';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_active_sections'] = 'Secciones Activas';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_drag_reorder'] = 'Arrastrar para reordenar';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_enable'] = 'Activar';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_disable'] = 'Desactivar';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_configure'] = 'Configurar';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_delete'] = 'Eliminar Sección';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_internal_name'] = 'Nombre Interno:';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_position'] = 'Posición:';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_no_sections'] = 'Aún no se han creado secciones. Añade una nueva sección para empezar.';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_add_new'] = 'Añadir Nueva Sección';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_internal_name_label'] = 'Nombre Interno de la Sección';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_internal_name_placeholder'] = 'ej., slider_principal, productos_destacados_inicio';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_internal_name_help'] = 'Usado para identificación en el backend. No visible para los clientes.';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_type_label'] = 'Tipo de Sección';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_default_title_label'] = 'Título por Defecto';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_default_title_help'] = 'Opcional. Este título será visible para los clientes si se establece.';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_add_button'] = 'Añadir Sección';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_modal_title'] = 'Configurar Sección';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_modal_close'] = 'Cerrar';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_modal_save'] = 'Guardar Configuración';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_confirm_delete'] = '¿Estás seguro de que quieres eliminar esta sección?';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_deleted_msg'] = 'Sección eliminada correctamente.';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_error_delete_msg'] = 'Error al eliminar la sección.';

// Section Types (for dropdown and display)
$_MODULE['<{mlthemebuilder}prestashop>section_type_hero'] = 'Banner Hero';
$_MODULE['<{mlthemebuilder}prestashop>section_type_services'] = 'Lista de Servicios';
$_MODULE['<{mlthemebuilder}prestashop>section_type_products'] = 'Productos (Categoría o Destacados)';
$_MODULE['<{mlthemebuilder}prestashop>section_type_banner'] = 'Banner CTA';
$_MODULE['<{mlthemebuilder}prestashop>section_type_brands'] = 'Slider de Marcas';
$_MODULE['<{mlthemebuilder}prestashop>section_type_ecology'] = 'Sección Ecología/Valores';
$_MODULE['<{mlthemebuilder}prestashop>section_type_contact'] = 'Información de Contacto';
$_MODULE['<{mlthemebuilder}prestashop>section_type_custom_html'] = 'HTML Personalizado';


// global_styles.tpl
$_MODULE['<{mlthemebuilder}prestashop>admin_styles_palette_legend'] = 'Paleta de Colores';
$_MODULE['<{mlthemebuilder}prestashop>admin_styles_primary_color_label'] = 'Color Primario';
$_MODULE['<{mlthemebuilder}prestashop>admin_styles_primary_color_help'] = 'Color principal usado para botones, enlaces y elementos importantes.';
// ... (add all other labels and help texts from global_styles.tpl)

// services_manager.tpl
$_MODULE['<{mlthemebuilder}prestashop>admin_services_title_page'] = 'Gestionar Servicios';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_infobox'] = 'Aquí puedes añadir, editar, reordenar y eliminar servicios que se pueden mostrar en la sección "Servicios" en tu página de inicio u otras páginas.';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_current_services'] = 'Servicios Actuales';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_no_services'] = 'Aún no se han añadido servicios.';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_add_new_title'] = 'Añadir Nuevo Servicio';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_edit_title_prefix'] = 'Editar Servicio: ';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_title_label'] = 'Título';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_description_label'] = 'Descripción';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_icon_label'] = 'Icono';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_icon_placeholder'] = 'ej., fa-star o nombre_icono.png';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_icon_help'] = 'Introduce una clase de FontAwesome (ej., "fas fa-star") o el nombre de archivo de un icono subido a modules/mlthemebuilder/views/img/icons/';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_icon_manage'] = 'Gestionar Iconos Subidos';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_active_label'] = 'Activo';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_add_button'] = 'Añadir Servicio';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_save_button'] = 'Guardar Servicio';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_cancel_edit_button'] = 'Cancelar Edición';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_confirm_delete'] = '¿Estás seguro de que quieres eliminar este servicio?';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_icon_modal_title'] = 'Gestor de Iconos';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_icon_upload_new'] = 'Subir Nuevo Icono';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_icon_upload_button'] = 'Subir Icono';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_icon_uploaded_list'] = 'Iconos Subidos';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_icon_click_to_use'] = 'Clic para usar';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_no_icons_uploaded'] = 'No hay iconos subidos o no se pueden listar.';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_error_loading_icons'] = 'Error al cargar los iconos.';
$_MODULE['<{mlthemebuilder}prestashop>admin_services_error_loading_icons_ajax'] = 'Error AJAX al cargar los iconos.';


// brands_manager.tpl (similar to services)
$_MODULE['<{mlthemebuilder}prestashop>admin_brands_title_page'] = 'Gestionar Marcas/Logos de Socios';
// ... (add all labels from brands_manager.tpl)

// advanced_settings.tpl
$_MODULE['<{mlthemebuilder}prestashop>admin_advanced_custom_codes_legend'] = 'Códigos Personalizados';
// ... (add all labels from advanced_settings.tpl)

// import_export.tpl
$_MODULE['<{mlthemebuilder}prestashop>admin_importexport_export_legend'] = 'Exportar Configuración';
// ... (add all labels from import_export.tpl)


// Section Configuration Forms (hero.tpl, services.tpl, etc. in admin/sections/)
// Hero Section
$_MODULE['<{mlthemebuilder}prestashop>admin_section_hero_title_label'] = 'Título Principal';
$_MODULE['<{mlthemebuilder}prestashop>admin_section_hero_title_help'] = 'Encabezado principal para la sección hero.';
// ... (add all labels and help texts for hero section config form)

// Services Section (admin/sections/services.tpl)
$_MODULE['<{mlthemebuilder}prestashop>admin_section_services_title_label'] = 'Título de la Sección';
// ... (add all labels for services section config form)

// ... Add translations for all other section config forms ...
// Products, Banner, Brands, Ecology, Contact, Custom HTML

// Frontend section titles (defaults, can be overridden by user)
$_MODULE['<{mlthemebuilder}prestashop>shop_hero_default_title'] = 'Bienvenido a Nuestra Tienda';
$_MODULE['<{mlthemebuilder}prestashop>shop_services_default_title'] = 'Nuestros Servicios';
$_MODULE['<{mlthemebuilder}prestashop>shop_products_default_title'] = 'Productos Destacados';
$_MODULE['<{mlthemebuilder}prestashop>shop_banner_default_title'] = 'Oferta Especial';
$_MODULE['<{mlthemebuilder}prestashop>shop_brands_default_title'] = 'Marcas de Confianza';
$_MODULE['<{mlthemebuilder}prestashop>shop_ecology_default_title'] = 'Nuestro Compromiso Ecológico';
$_MODULE['<{mlthemebuilder}prestashop>shop_contact_default_title'] = 'Contáctanos';

// Contact Form Frontend
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_name_placeholder'] = 'Tu Nombre';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_email_placeholder'] = 'Tu Email';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_message_placeholder'] = 'Tu Mensaje';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_send_button'] = 'Enviar Mensaje';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_sending'] = 'Enviando...';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_success'] = '¡Mensaje enviado con éxito!';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_error'] = 'Error al enviar el mensaje. Por favor, inténtalo de nuevo.';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_fill_required'] = 'Por favor, rellena todos los campos requeridos.';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_address_label'] = 'Dirección';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_phone_label'] = 'Teléfono';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_email_label'] = 'Email';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_hours_label'] = 'Horarios';


// General shop texts that might be used in templates
$_MODULE['<{mlthemebuilder}prestashop>shop_view_products_button'] = 'Ver Productos';
$_MODULE['<{mlthemebuilder}prestashop>shop_view_category_button'] = 'Ver Categoría';
$_MODULE['<{mlthemebuilder}prestashop>shop_no_products_found'] = 'No se encontraron productos para esta selección.';
$_MODULE['<{mlthemebuilder}prestashop>shop_no_services_available'] = 'No hay servicios disponibles en este momento.';
$_MODULE['<{mlthemebuilder}prestashop>shop_no_brands_available'] = 'No hay marcas para mostrar en este momento.';

return $_MODULE;
