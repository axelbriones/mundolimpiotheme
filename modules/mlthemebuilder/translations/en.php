<?php

global $_MODULE;
$_MODULE = array();

// Default strings from module main class
$_MODULE['<{mlthemebuilder}prestashop>mlthemebuilder_displayname'] = 'Mundo Limpio Theme Builder';
$_MODULE['<{mlthemebuilder}prestashop>mlthemebuilder_description'] = 'Module to fully customize the theme of your Mundo Limpio store.';
$_MODULE['<{mlthemebuilder}prestashop>mlthemebuilder_uninstall_confirm'] = 'Are you sure you want to uninstall this module? All configuration data will be lost.';

// Admin Controller & Tabs
$_MODULE['<{mlthemebuilder}prestashop>admintab_theme_builder'] = 'Theme Builder';
$_MODULE['<{mlthemebuilder}prestashop>admintab_configure_title'] = 'Mundo Limpio Theme Builder Configuration';

// General Admin UI
$_MODULE['<{mlthemebuilder}prestashop>admin_save_success'] = 'Settings saved successfully.';
$_MODULE['<{mlthemebuilder}prestashop>admin_save_error'] = 'Error saving settings.';
$_MODULE['<{mlthemebuilder}prestashop>admin_delete_confirm'] = 'Are you sure you want to delete this item?';
$_MODULE['<{mlthemebuilder}prestashop>admin_item_deleted'] = 'Item deleted successfully.';
$_MODULE['<{mlthemebuilder}prestashop>admin_item_error_delete'] = 'Error deleting item.';
$_MODULE['<{mlthemebuilder}prestashop>admin_order_updated'] = 'Order updated successfully.';
$_MODULE['<{mlthemebuilder}prestashop>admin_order_error'] = 'Error updating order.';
$_MODULE['<{mlthemebuilder}prestashop>admin_status_updated'] = 'Status updated successfully.';
$_MODULE['<{mlthemebuilder}prestashop>admin_status_error'] = 'Error updating status.';
$_MODULE['<{mlthemebuilder}prestashop>admin_loading'] = 'Loading...';
$_MODULE['<{mlthemebuilder}prestashop>admin_error_form_load'] = 'Error loading configuration form.';
$_MODULE['<{mlthemebuilder}prestashop>admin_img_upload_success'] = 'Image uploaded successfully.';
$_MODULE['<{mlthemebuilder}prestashop>admin_img_upload_error'] = 'Error uploading image.';
$_MODULE['<{mlthemebuilder}prestashop>admin_select_image'] = 'Please select an image file.';
$_MODULE['<{mlthemebuilder}prestashop>admin_item_added'] = 'Item added successfully.';
$_MODULE['<{mlthemebuilder}prestashop>admin_item_removed'] = 'Item removed successfully.';

// configure.tpl Tabs
$_MODULE['<{mlthemebuilder}prestashop>admin_tab_sections'] = 'Sections Management';
$_MODULE['<{mlthemebuilder}prestashop>admin_tab_styles'] = 'Global Styles';
$_MODULE['<{mlthemebuilder}prestashop>admin_tab_services_manage'] = 'Manage Services';
$_MODULE['<{mlthemebuilder}prestashop>admin_tab_brands_manage'] = 'Manage Brands';
$_MODULE['<{mlthemebuilder}prestashop>admin_tab_advanced'] = 'Advanced Settings';
$_MODULE['<{mlthemebuilder}prestashop>admin_tab_importexport'] = 'Import/Export';

// sections_manager.tpl
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_title'] = 'Homepage Sections Management';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_infobox'] = 'Drag and drop sections to change their order on the homepage. Click "Configure" to edit a section\'s content and settings. Use the switch to activate or deactivate a section.';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_active_sections'] = 'Active Sections';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_drag_reorder'] = 'Drag to reorder';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_enable'] = 'Enable';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_disable'] = 'Disable';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_configure'] = 'Configure';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_delete'] = 'Delete Section';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_internal_name'] = 'Internal Name:';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_position'] = 'Position:';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_no_sections'] = 'No sections created yet. Add a new section to get started.';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_add_new'] = 'Add New Section';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_internal_name_label'] = 'Section Internal Name';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_internal_name_placeholder'] = 'e.g., main_slider, featured_products_home';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_internal_name_help'] = 'Used for identification in the backend. Not visible to customers.';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_type_label'] = 'Section Type';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_default_title_label'] = 'Default Title';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_default_title_help'] = 'Optional. This title will be visible to customers if set.';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_add_button'] = 'Add Section';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_modal_title'] = 'Configure Section';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_modal_close'] = 'Close';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_modal_save'] = 'Save Configuration';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_confirm_delete'] = 'Are you sure you want to delete this section?';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_deleted_msg'] = 'Section deleted successfully.';
$_MODULE['<{mlthemebuilder}prestashop>admin_sections_error_delete_msg'] = 'Error deleting section.';

// Section Types
$_MODULE['<{mlthemebuilder}prestashop>section_type_hero'] = 'Hero Banner';
$_MODULE['<{mlthemebuilder}prestashop>section_type_services'] = 'Services List';
$_MODULE['<{mlthemebuilder}prestashop>section_type_products'] = 'Products (Category or Featured)';
$_MODULE['<{mlthemebuilder}prestashop>section_type_banner'] = 'CTA Banner';
$_MODULE['<{mlthemebuilder}prestashop>section_type_brands'] = 'Brands Slider';
$_MODULE['<{mlthemebuilder}prestashop>section_type_ecology'] = 'Ecology/Values Section';
$_MODULE['<{mlthemebuilder}prestashop>section_type_contact'] = 'Contact Information';
$_MODULE['<{mlthemebuilder}prestashop>section_type_custom_html'] = 'Custom HTML';

// global_styles.tpl
$_MODULE['<{mlthemebuilder}prestashop>admin_styles_palette_legend'] = 'Color Palette';
$_MODULE['<{mlthemebuilder}prestashop>admin_styles_primary_color_label'] = 'Primary Color';
$_MODULE['<{mlthemebuilder}prestashop>admin_styles_primary_color_help'] = 'Main color used for buttons, links, and important elements.';
// ... Add EN translations for all other labels and help texts from global_styles.tpl

// services_manager.tpl
$_MODULE['<{mlthemebuilder}prestashop>admin_services_title_page'] = 'Manage Services';
// ... Add EN translations for services_manager.tpl

// brands_manager.tpl
$_MODULE['<{mlthemebuilder}prestashop>admin_brands_title_page'] = 'Manage Brands/Partner Logos';
// ... Add EN translations for brands_manager.tpl

// advanced_settings.tpl
$_MODULE['<{mlthemebuilder}prestashop>admin_advanced_custom_codes_legend'] = 'Custom Codes';
// ... Add EN translations for advanced_settings.tpl

// import_export.tpl
$_MODULE['<{mlthemebuilder}prestashop>admin_importexport_export_legend'] = 'Export Configuration';
// ... Add EN translations for import_export.tpl

// Section Configuration Forms (hero.tpl, services.tpl, etc. in admin/sections/)
$_MODULE['<{mlthemebuilder}prestashop>admin_section_hero_title_label'] = 'Main Title';
// ... Add EN translations for all section config forms

// Frontend section titles (defaults)
$_MODULE['<{mlthemebuilder}prestashop>shop_hero_default_title'] = 'Welcome to Our Store';
$_MODULE['<{mlthemebuilder}prestashop>shop_services_default_title'] = 'Our Services';
$_MODULE['<{mlthemebuilder}prestashop>shop_products_default_title'] = 'Featured Products';
$_MODULE['<{mlthemebuilder}prestashop>shop_banner_default_title'] = 'Special Offer';
$_MODULE['<{mlthemebuilder}prestashop>shop_brands_default_title'] = 'Trusted Brands';
$_MODULE['<{mlthemebuilder}prestashop>shop_ecology_default_title'] = 'Our Ecological Commitment';
$_MODULE['<{mlthemebuilder}prestashop>shop_contact_default_title'] = 'Contact Us';

// Contact Form Frontend
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_name_placeholder'] = 'Your Name';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_email_placeholder'] = 'Your Email';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_message_placeholder'] = 'Your Message';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_send_button'] = 'Send Message';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_sending'] = 'Sending...';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_success'] = 'Message sent successfully!';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_error'] = 'Error sending message. Please try again.';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_fill_required'] = 'Please fill all required fields.';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_address_label'] = 'Address';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_phone_label'] = 'Phone';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_email_label'] = 'Email';
$_MODULE['<{mlthemebuilder}prestashop>shop_contactform_hours_label'] = 'Opening Hours';

// General shop texts
$_MODULE['<{mlthemebuilder}prestashop>shop_view_products_button'] = 'View Products';
$_MODULE['<{mlthemebuilder}prestashop>shop_view_category_button'] = 'View Category';
$_MODULE['<{mlthemebuilder}prestashop>shop_no_products_found'] = 'No products found for this selection.';
$_MODULE['<{mlthemebuilder}prestashop>shop_no_services_available'] = 'No services available at the moment.';
$_MODULE['<{mlthemebuilder}prestashop>shop_no_brands_available'] = 'No brands to display at the moment.';

return $_MODULE;
