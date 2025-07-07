<?php
/**
 * MlThemeBuilder Module for PrestaShop - Mundo Limpio
 * @author Byron Briones - bbrion.es
 * @version 1.0.0
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

// Autoload classes from the 'classes' directory
spl_autoload_register(function ($class_name) {
    $file = _PS_MODULE_DIR_ . 'mlthemebuilder/classes/' . $class_name . '.php';
    if (file_exists($file)) {
        require_once $file;
    }
});


class MlThemeBuilder extends Module
{
    public $tabs = array(
        array(
            'name' => 'Theme Builder', // The name displayed in the BO
            'class_name' => 'AdminMlThemeBuilder', // The name of your AdminController
            'parent_class_name' => 'IMPROVE', // Parent tab
            'visible' => true,
            'icon' => 'icon-paint-brush',
        ),
    );

    public function __construct()
    {
        $this->name = 'mlthemebuilder';
        $this->tab = 'front_office_features'; // Default tab for module list
        $this->version = '1.0.0';
        $this->author = 'Byron Briones';
        $this->author_uri = 'https://bbrion.es';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = array('min' => '1.7.6', 'max' => _PS_VERSION_); // Adjusted for modern PrestaShop
        $this->bootstrap = true; // Use Bootstrap for configuration page

        parent::__construct();

        $this->displayName = $this->l('Mundo Limpio Theme Builder');
        $this->description = $this->l('Módulo para personalizar completamente el tema de tu tienda Mundo Limpio.');
        $this->confirmUninstall = $this->l('¿Estás seguro de que quieres desinstalar este módulo? Todos los datos de configuración se perderán.');

        // Define module_key, set to a unique value or leave empty if not submitting to Addons
        $this->module_key = 'a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4'; // Example key
    }

    public function install()
    {
        if (parent::install() &&
            $this->registerHook('displayHeader') &&
            $this->registerHook('displayFooter') &&
            $this->registerHook('displayHome') && // Main hook for homepage sections
            $this->registerHook('actionAdminControllerSetMedia') && // To add JS/CSS to admin
            $this->installModuleTabs() &&
            $this->createTables() &&
            $this->installDefaultData()) {

            // Set default configuration values
            Configuration::updateValue('MLTHEME_PRIMARY_COLOR', '#667eea');
            Configuration::updateValue('MLTHEME_ENABLE_ANIMATIONS', 1);

            return true;
        }
        return false;
    }

    public function uninstall()
    {
        if (parent::uninstall() &&
            $this->uninstallModuleTabs() &&
            $this->deleteTables()) {

            // Delete configuration values
            Configuration::deleteByName('MLTHEME_PRIMARY_COLOR');
            Configuration::deleteByName('MLTHEME_ENABLE_ANIMATIONS');
            // Delete other config values as needed

            return true;
        }
        return false;
    }

    private function createTables()
    {
        $sql = array();
        $db_prefix = _DB_PREFIX_;
        $mysql_engine = _MYSQL_ENGINE_;

        // Table for sections
        $sql[] = "CREATE TABLE IF NOT EXISTS `{$db_prefix}mltheme_sections` (
            `id_mltheme_section` int(11) NOT NULL AUTO_INCREMENT,
            `name` varchar(255) NOT NULL COMMENT 'Internal name for identification',
            `type` varchar(50) NOT NULL COMMENT 'Type of section (hero, products, etc.)',
            `position` int(11) NOT NULL DEFAULT 0,
            `active` tinyint(1) NOT NULL DEFAULT 1,
            `config` text COMMENT 'JSON configuration for the section',
            `date_add` datetime NOT NULL,
            `date_upd` datetime NOT NULL,
            PRIMARY KEY (`id_mltheme_section`)
        ) ENGINE={$mysql_engine} DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;";

        // Language table for sections
        $sql[] = "CREATE TABLE IF NOT EXISTS `{$db_prefix}mltheme_sections_lang` (
            `id_mltheme_section` int(11) NOT NULL,
            `id_lang` int(11) NOT NULL,
            `id_shop` int(11) NOT NULL DEFAULT 1,
            `title` varchar(255) DEFAULT NULL,
            `content` text DEFAULT NULL,
            `button_text` varchar(100) DEFAULT NULL,
            `button_link` varchar(255) DEFAULT NULL,
            PRIMARY KEY (`id_mltheme_section`, `id_lang`, `id_shop`)
        ) ENGINE={$mysql_engine} DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;";

        // Table for services
        $sql[] = "CREATE TABLE IF NOT EXISTS `{$db_prefix}mltheme_services` (
            `id_mltheme_service` int(11) NOT NULL AUTO_INCREMENT,
            `icon` varchar(255) DEFAULT NULL,
            `position` int(11) NOT NULL DEFAULT 0,
            `active` tinyint(1) NOT NULL DEFAULT 1,
            `date_add` datetime NOT NULL,
            `date_upd` datetime NOT NULL,
            PRIMARY KEY (`id_mltheme_service`)
        ) ENGINE={$mysql_engine} DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;";

        // Language table for services
        $sql[] = "CREATE TABLE IF NOT EXISTS `{$db_prefix}mltheme_services_lang` (
            `id_mltheme_service` int(11) NOT NULL,
            `id_lang` int(11) NOT NULL,
            `id_shop` int(11) NOT NULL DEFAULT 1,
            `title` varchar(255) DEFAULT NULL,
            `description` text DEFAULT NULL,
            PRIMARY KEY (`id_mltheme_service`, `id_lang`, `id_shop`)
        ) ENGINE={$mysql_engine} DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;";

        // Table for brands
        $sql[] = "CREATE TABLE IF NOT EXISTS `{$db_prefix}mltheme_brands` (
            `id_mltheme_brand` int(11) NOT NULL AUTO_INCREMENT,
            `name` varchar(255) NOT NULL,
            `logo` varchar(255) DEFAULT NULL COMMENT 'Filename of the logo image',
            `url` varchar(255) DEFAULT NULL,
            `position` int(11) NOT NULL DEFAULT 0,
            `active` tinyint(1) NOT NULL DEFAULT 1,
            `date_add` datetime NOT NULL,
            `date_upd` datetime NOT NULL,
            PRIMARY KEY (`id_mltheme_brand`)
        ) ENGINE={$mysql_engine} DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;";

        // Table for global styles and advanced settings (alternative to multiple Configuration entries)
        $sql[] = "CREATE TABLE IF NOT EXISTS `{$db_prefix}mltheme_settings` (
            `id_mltheme_setting` int(11) NOT NULL AUTO_INCREMENT,
            `id_shop_group` int(11) DEFAULT NULL,
            `id_shop` int(11) DEFAULT NULL,
            `name` varchar(255) NOT NULL,
            `value` longtext,
            `date_add` datetime NOT NULL,
            `date_upd` datetime NOT NULL,
            PRIMARY KEY (`id_mltheme_setting`),
            UNIQUE KEY `idx_mltheme_settings_name_shop_group_shop` (`name`, `id_shop_group`, `id_shop`)
        ) ENGINE={$mysql_engine} DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;";


        foreach ($sql as $query) {
            if (!Db::getInstance()->execute($query)) {
                $this->_errors[] = Db::getInstance()->getMsgError();
                return false;
            }
        }
        return true;
    }

    private function deleteTables()
    {
        $sql = array(
            'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'mltheme_sections_lang`',
            'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'mltheme_sections`',
            'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'mltheme_services_lang`',
            'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'mltheme_services`',
            'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'mltheme_brands`',
            'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'mltheme_settings`',
        );

        foreach ($sql as $query) {
            if (!Db::getInstance()->execute($query)) {
                // Log error or handle if needed, but uninstall should proceed
            }
        }
        return true;
    }

    public function installModuleTabs()
    {
        $languages = Language::getLanguages(false);
        foreach ($this->tabs as $tabDetails) {
            $tab = new Tab();
            $tab->class_name = $tabDetails['class_name'];
            $tab->module = $this->name;
            $tab->id_parent = (int)Tab::getIdFromClassName($tabDetails['parent_class_name']);
            $tab->active = $tabDetails['visible'] ? 1 : 0;
            $tab->icon = $tabDetails['icon'] ?? null;

            foreach ($languages as $lang) {
                // Tab names should be in English and then translated via PrestaShop's translation system
                // For module tabs, the name often comes from the module itself or a generic term.
                $tab->name[$lang['id_lang']] = $this->getTranslator()->trans($tabDetails['name'], [], 'Modules.Mlthemebuilder.Admin');
            }
            if (!$tab->save()) {
                $this->_errors[] = $this->l('Failed to install tab: ') . $tabDetails['name'];
                return false;
            }
        }
        return true;
    }

    public function uninstallModuleTabs()
    {
        foreach ($this->tabs as $tabDetails) {
            $id_tab = (int)Tab::getIdFromClassName($tabDetails['class_name']);
            if ($id_tab) {
                $tab = new Tab($id_tab);
                if (Validate::isLoadedObject($tab)) {
                    if (!$tab->delete()) {
                        $this->_errors[] = $this->l('Failed to uninstall tab: ') . $tabDetails['name'];
                        // Continue trying to uninstall other tabs
                    }
                }
            }
        }
        return empty($this->_errors); // Return true if no errors
    }

    private function installDefaultData()
    {
        $default_sections = array(
            array('name' => 'hero_main', 'type' => 'hero', 'position' => 1, 'active' => 1, 'config' => '{}',
                  'title' => array('es' => 'Bienvenido a Mundo Limpio', 'en' => 'Welcome to Mundo Limpio'),
                  'content' => array('es' => 'Soluciones ecológicas para un futuro sostenible.', 'en' => 'Ecological solutions for a sustainable future.'),
                  'button_text' => array('es' => 'Ver Productos', 'en' => 'View Products'), 'button_link' => array('es' => '#', 'en' => '#')),
            array('name' => 'services_overview', 'type' => 'services', 'position' => 2, 'active' => 1, 'config' => '{"columns_services": 3}',
                  'title' => array('es' => 'Nuestros Servicios', 'en' => 'Our Services')),
            array('name' => 'featured_products', 'type' => 'products', 'position' => 3, 'active' => 1, 'config' => '{"display_type_products": "featured", "num_products": 4}',
                  'title' => array('es' => 'Productos Destacados', 'en' => 'Featured Products')),
            array('name' => 'cta_banner_promo', 'type' => 'banner', 'position' => 4, 'active' => 1, 'config' => '{}',
                  'title' => array('es' => 'Oferta Especial', 'en' => 'Special Offer')),
            array('name' => 'trusted_brands', 'type' => 'brands', 'position' => 5, 'active' => 1, 'config' => '{}',
                  'title' => array('es' => 'Marcas de Confianza', 'en' => 'Trusted Brands')),
            array('name' => 'ecology_commitment', 'type' => 'ecology', 'position' => 6, 'active' => 1, 'config' => '{}',
                  'title' => array('es' => 'Compromiso Ecológico', 'en' => 'Ecological Commitment')),
            array('name' => 'contact_us', 'type' => 'contact', 'position' => 7, 'active' => 1, 'config' => '{"show_form_contact": true}',
                  'title' => array('es' => 'Contáctanos', 'en' => 'Contact Us')),
        );

        $languages = Language::getLanguages(false);

        foreach ($default_sections as $section_data) {
            $section = new MlThemeSection(); // Use the new class name
            $section->name = $section_data['name'];
            $section->type = $section_data['type'];
            $section->position = $section_data['position'];
            $section->active = $section_data['active'];
            $section->config = $section_data['config'];

            foreach ($languages as $lang) {
                $id_lang = (int)$lang['id_lang'];
                $iso_code = $lang['iso_code'];
                $section->title[$id_lang] = $section_data['title'][$iso_code] ?? $section_data['title']['en'] ?? $section_data['name'];
                $section->content[$id_lang] = $section_data['content'][$iso_code] ?? $section_data['content']['en'] ?? '';
                $section->button_text[$id_lang] = $section_data['button_text'][$iso_code] ?? $section_data['button_text']['en'] ?? '';
                $section->button_link[$id_lang] = $section_data['button_link'][$iso_code] ?? $section_data['button_link']['en'] ?? '#';
            }

            if (!$section->add()) {
                $this->_errors[] = $this->l('Failed to install default section: ') . $section_data['name'];
            }
        }

        // Default Services
        $default_services = [
            ['icon' => 'fas fa-recycle', 'title' => ['es' => 'Reciclaje Eficiente', 'en' => 'Efficient Recycling'], 'description' => ['es' => 'Optimizamos procesos de reciclaje.', 'en' => 'We optimize recycling processes.']],
            ['icon' => 'fas fa-leaf', 'title' => ['es' => 'Productos Ecológicos', 'en' => 'Eco-Friendly Products'], 'description' => ['es' => 'Amplia gama de productos sostenibles.', 'en' => 'Wide range of sustainable products.']],
            ['icon' => 'fas fa-lightbulb', 'title' => ['es' => 'Consultoría Verde', 'en' => 'Green Consulting'], 'description' => ['es' => 'Asesoramiento para un impacto positivo.', 'en' => 'Advice for a positive impact.']],
        ];

        foreach ($default_services as $idx => $service_data) {
            $service = new MlThemeService();
            $service->icon = $service_data['icon'];
            $service->position = $idx + 1;
            $service->active = 1;
            foreach ($languages as $lang) {
                $id_lang = (int)$lang['id_lang'];
                $iso_code = $lang['iso_code'];
                $service->title[$id_lang] = $service_data['title'][$iso_code] ?? $service_data['title']['en'];
                $service->description[$id_lang] = $service_data['description'][$iso_code] ?? $service_data['description']['en'];
            }
            $service->add();
        }

        return empty($this->_errors);
    }

    /**
     * Main configuration page for the module.
     */
    public function getContent()
    {
        // This method is called when the "Configure" button is clicked in the module list,
        // or when navigating to the module's admin tab.
        // It should output the HTML for the configuration page.
        Tools::redirectAdmin($this->context->link->getAdminLink('AdminMlThemeBuilder'));
        return null; // Redirecting, so no output needed here.
    }

    /**
     * Hook for adding CSS/JS to the admin controller pages.
     */
    public function hookActionAdminControllerSetMedia()
    {
        // Only add on our module's controller page
        if (Tools::getValue('controller') == 'AdminMlThemeBuilder' ||
            (Tools::getValue('configure') == $this->name && Tools::getValue('tab_module') == $this->tab && Tools::getValue('module_name') == $this->name)
           ) {
            $this->context->controller->addJqueryUI('ui.sortable');
            $this->context->controller->addJS($this->_path . 'views/js/admin.js');
            $this->context->controller->addCSS($this->_path . 'views/css/admin.css');

            // For image uploads with preview
            $this->context->controller->addJS(_PS_JS_DIR_.'admin/tinymce.inc.js'); // For PS functions like createTemplate
            $this->context->controller->addJS(_PS_JS_DIR_.'tiny_mce/tiny_mce.js'); // Core TinyMCE if using its image uploader

            // Add translations to JavaScript
            Media::addJsDef($this->getJsTranslations());
        }
    }

    private function getJsTranslations()
    {
        return array(
            'ctb_translations' => array( // Keep same JS var name for existing TPLs, or update TPLs too
                'orderUpdated' => $this->l('Order updated successfully'),
                'errorUpdatingOrder' => $this->l('Error updating order'),
                'configSaved' => $this->l('Configuration saved successfully'),
                'errorSavingConfig' => $this->l('Error saving configuration'),
                'statusUpdated' => $this->l('Status updated successfully'),
                'errorUpdatingStatus' => $this->l('Error updating status'),
                'confirmDeleteSection' => $this->l('Are you sure you want to delete this section?'),
                'sectionDeleted' => $this->l('Section deleted successfully.'),
                'errorDeletingSection' => $this->l('Error deleting section.'),
                'confirmDeleteService' => $this->l('Are you sure you want to delete this service?'),
                'serviceDeleted' => $this->l('Service deleted successfully.'),
                'errorDeletingService' => $this->l('Error deleting service.'),
                'confirmDeleteBrand' => $this->l('Are you sure you want to delete this brand?'),
                'brandDeleted' => $this->l('Brand deleted successfully.'),
                'errorDeletingBrand' => $this->l('Error deleting brand.'),
                'loading' => $this->l('Loading...'),
                'errorLoadingForm' => $this->l('Error loading configuration form.'),
                'imgUploadSuccess' => $this->l('Image uploaded successfully.'),
                'imgUploadError' => $this->l('Error uploading image.'),
                'selectAnImage' => $this->l('Please select an image file.'),
                'itemAdded' => $this->l('Item added.'),
                'itemRemoved' => $this->l('Item removed.'),
                'selectPartsToExport' => $this->l('Please select at least one part to export.'),
                'importingConfig' => $this->l('Importing configuration...'),
                'errorImportingConfig' => $this->l('Error importing configuration.'),
                'errorImportingConfigAjax' => $this->l('AJAX error during import.'),
            )
        );
    }


    public function hookDisplayHeader($params)
    {
        // Add global CSS
        $this->context->controller->addCSS($this->_path . 'views/css/front.css', 'all');

        // Add global JS
        $this->context->controller->addJS($this->_path . 'views/js/front.js');

        // Add animations CSS if enabled
        // Using MlThemeSetting class to get this value
        $enable_animations = MlThemeSetting::getSettingValue('enable_animations', $this->context->shop->id, true);
        if ($enable_animations) {
            $this->context->controller->addCSS($this->_path . 'views/css/animations.css', 'all');
        }

        // Add Google Fonts if URL is set
        $google_fonts_url = MlThemeSetting::getSettingValue('google_fonts_url', $this->context->shop->id);
        if ($google_fonts_url && Validate::isAbsoluteUrl($google_fonts_url)) {
            $this->context->controller->registerStylesheet(
                'module-' . $this->name . '-googlefonts',
                $google_fonts_url,
                ['server' => 'remote', 'priority' => 10]
            );
        }

        // Add custom CSS from settings
        $custom_css = MlThemeSetting::getSettingValue('custom_css', $this->context->shop->id);
        if ($custom_css) {
            $this->context->smarty->assign('mltheme_custom_css', $custom_css);
        }

        // Add custom JS from settings (header)
        $custom_js_header = MlThemeSetting::getSettingValue('custom_js_header', $this->context->shop->id);
         if ($custom_js_header) {
            $this->context->smarty->assign('mltheme_custom_js_header', $custom_js_header);
        }

        // Assign global style variables to Smarty for inline styling or CSS variables
        $global_styles = MlThemeSetting::getMultipleSettings([
            'primary_color', 'secondary_color', 'text_color', 'link_color',
            'bg_light_color', 'bg_dark_color', 'base_font_size', 'button_border_radius'
        ], $this->context->shop->id);

        $this->context->smarty->assign('mltheme_global_styles', $global_styles);

        return $this->display(__FILE__, 'views/templates/hook/header.tpl');
    }

    public function hookDisplayFooter($params)
    {
        // Add custom JS from settings (footer)
        $custom_js_footer = MlThemeSetting::getSettingValue('custom_js_footer', $this->context->shop->id);
        if ($custom_js_footer) {
            $this->context->smarty->assign('mltheme_custom_js_footer', $custom_js_footer);
        }
        return $this->display(__FILE__, 'views/templates/hook/footer.tpl');
    }

    public function hookDisplayHome($params)
    {
        $output = '';
        $id_lang = (int)$this->context->language->id;
        $id_shop = (int)$this->context->shop->id;

        $sections = MlThemeSection::getSectionsByPosition(true, $id_lang, $id_shop);

        if ($sections) {
            foreach ($sections as $section_data) {
                // Create an instance of the section to easily access its properties
                $section_obj = new MlThemeSection((int)$section_data['id_mltheme_section'], $id_lang, $id_shop);
                if (Validate::isLoadedObject($section_obj) && $section_obj->active) {
                     $output .= $this->renderSection($section_obj);
                }
            }
        }
        return $output;
    }

    private function renderSection(MlThemeSection $section) // Use new class name
    {
        $template_file_path = 'views/templates/hook/sections/' . $section->type . '.tpl';
        $template_full_path = $this->getLocalPath() . $template_file_path;

        if (!file_exists($template_full_path)) {
            // Optionally log this error or return a placeholder
            // error_log("Template not found for section type: {$section->type}");
            return '<div class="alert alert-warning">Section template `'.$section->type.'.tpl` not found.</div>';
        }

        $cache_id = $this->name . '|' . $section->type . '|' . $section->id . '|' . $this->context->language->id . '|' . $this->context->shop->id;

        // Check if section caching is enabled
        $enable_section_cache = MlThemeSetting::getSettingValue('enable_section_cache', $this->context->shop->id, true);

        if (!$enable_section_cache || !$this->isCached($template_file_path, $cache_id)) {
            $section_render_data = array();
            $section_render_data['section'] = (array)$section; // Basic section data

            // Multilingual fields are already loaded in $section object if $id_lang was passed to constructor
            $section_render_data['section']['title'] = $section->title;
            $section_render_data['section']['content'] = $section->content;
            $section_render_data['section']['button_text'] = $section->button_text;
            $section_render_data['section']['button_link'] = $section->button_link;

            $section_render_data['section']['config'] = json_decode($section->config, true);
            if ($section_render_data['section']['config'] === null) $section_render_data['section']['config'] = [];

            // Add id_section for convenience in template
            $section_render_data['section']['id_section'] = $section->id;


            // Load specific data based on section type by calling dedicated methods
            $methodName = 'get' . ucfirst($section->type) . 'Data';
            if (method_exists($this, $methodName)) {
                $specific_data = $this->$methodName($section);
                $section_render_data['section'] = array_merge($section_render_data['section'], $specific_data);
            }

            // Common variables for all section templates
            $section_render_data['img_dir_theme'] = $this->context->link->getMediaLink($this->_path . 'views/img/');
            $section_render_data['language'] = $this->context->language;


            $this->context->smarty->assign($section_render_data);
        }
        return $this->fetch($template_file_path, ($enable_section_cache ? $cache_id : null));
    }

    // Data retrieval methods for each section type
    private function getHeroData(MlThemeSection $section)
    {
        $config = $section->config ? json_decode($section->config, true) : []; // Already decoded in renderSection
        $id_lang = $this->context->language->id;

        // Fallbacks: Config -> Object Property -> Default Translatable String
        $data = [];
        $data['hero_title'] = $config['title_hero'][$id_lang] ?? $section->title ?? $this->l('Main Title Hero', 'mlthemebuilder');
        $data['hero_subtitle'] = $config['subtitle_hero'][$id_lang] ?? '';
        $data['hero_image'] = $config['image_hero'] ?? ''; // Filename, path constructed in TPL
        $data['hero_button_text'] = $config['button_text_hero'][$id_lang] ?? $section->button_text ?? $this->l('View Products', 'mlthemebuilder');
        $data['hero_button_link'] = $config['button_link_hero'][$id_lang] ?? $section->button_link ?? Context::getContext()->link->getPageLink('index');

        return $data;
    }

    private function getServicesData(MlThemeSection $section)
    {
        $config = $section->config ? json_decode($section->config, true) : [];
        $id_lang = $this->context->language->id;
        $id_shop = $this->context->shop->id;

        $limit = $config['max_services'] ?? null;

        return array(
            'services_list_title' => $config['title_services'][$id_lang] ?? $section->title ?? $this->l('Our Services', 'mlthemebuilder'),
            'services_list_subtitle' => $config['subtitle_services'][$id_lang] ?? $section->content ?? '',
            'services_list' => MlThemeService::getActiveServices($id_lang, $id_shop, $limit),
            'columns_services' => $config['columns_services'] ?? 3,
        );
    }

    private function getProductsData(MlThemeSection $section)
    {
        $config = $section->config ? json_decode($section->config, true) : [];
        $id_lang = $this->context->language->id;

        $data = [];
        $data['products_list_title'] = $config['title_products'][$id_lang] ?? $section->title ?? $this->l('Featured Products', 'mlthemebuilder');
        $data['products_list_subtitle'] = $config['subtitle_products'][$id_lang] ?? $section->content ?? '';

        $display_type = $config['display_type_products'] ?? 'featured'; // featured, new, category, bestsellers
        $num_products = isset($config['num_products']) ? (int)$config['num_products'] : 8;
        $id_category = isset($config['id_category_products']) ? (int)$config['id_category_products'] : null;

        $products = [];
        if ($display_type == 'category' && $id_category) {
            $category = new Category($id_category, $id_lang);
            if (Validate::isLoadedObject($category)) {
                $products = $category->getProducts($id_lang, 1, $num_products, 'position'); // Or by date_add, etc.
            }
        } elseif ($display_type == 'new') {
            $products = Product::getNewProducts($id_lang, 0, $num_products);
        } elseif ($display_type == 'bestsellers') {
            $products = ProductSale::getBestSales($id_lang, 0, $num_products);
        } else { // Default to featured (on sale)
            $products = Product::getPricesDrop($id_lang, 0, $num_products, false); // PrestaShop's "on sale"
             if (!$products) { // Fallback if no products on sale
                $products = Product::getNewProducts($id_lang, 0, $num_products);
            }
        }

        $presenterFactory = new ProductPresenterFactory($this->context);
        $presentationSettings = $presenterFactory->getPresentationSettings();
        $productPresenter = $presenterFactory->getPresenter();

        $data['products_list'] = [];
        if ($products) {
            foreach ($products as $product) {
                $data['products_list'][] = $productPresenter->present(
                    $presentationSettings,
                    $product,
                    $this->context->language
                );
            }
        }

        // For category display type
        if ($display_type == 'categories') {
             $data['categories_list'] = Category::getCategories($id_lang, true, false); // Simple list of categories
             // More complex category data might be needed depending on TPL
        }

        return $data;
    }

    private function getBrandsData(MlThemeSection $section)
    {
        $config = $section->config ? json_decode($section->config, true) : [];
        $id_lang = $this->context->language->id; // Not directly used for brands unless they become translatable

        $limit = $config['max_brands'] ?? null;

        return array(
            'brands_list_title' => $config['title_brands'][$id_lang] ?? $section->title ?? $this->l('Our Brands', 'mlthemebuilder'),
            'brands_list' => MlThemeBrand::getActiveBrands($this->context->shop->id, $limit)
        );
    }

    private function getBannerData(MlThemeSection $section)
    {
        $config = $section->config ? json_decode($section->config, true) : [];
        $id_lang = $this->context->language->id;

        $data = [];
        $data['banner_title'] = $config['title_banner'][$id_lang] ?? $section->title ?? '';
        $data['banner_text'] = $config['text_banner'][$id_lang] ?? $section->content ?? '';
        $data['banner_image'] = $config['image_banner'] ?? ''; // Filename
        $data['banner_background_image'] = $config['background_image_banner'] ?? ''; // Filename
        $data['banner_background_color'] = $config['background_color_banner'] ?? '';
        $data['banner_button_text'] = $config['button_text_banner'][$id_lang] ?? $section->button_text ?? '';
        $data['banner_button_link'] = $config['button_link_banner'][$id_lang] ?? $section->button_link ?? '';
        $data['layout_banner'] = $config['layout_banner'] ?? 'image_right'; // image_left, image_right, text_only, image_background

        return $data;
    }

    private function getEcologyData(MlThemeSection $section)
    {
        $config = $section->config ? json_decode($section->config, true) : [];
        $id_lang = $this->context->language->id;

        $data = [];
        $data['ecology_title'] = $config['title_ecology'][$id_lang] ?? $section->title ?? $this->l('Ecological Commitment', 'mlthemebuilder');
        $data['ecology_text'] = $config['text_ecology'][$id_lang] ?? $section->content ?? '';
        $data['ecology_image'] = $config['image_ecology'] ?? ''; // Filename
        $data['layout_ecology'] = $config['layout_ecology'] ?? 'image_right';

        $items = [];
        if (isset($config['items_ecology']) && is_array($config['items_ecology'])) {
            foreach ($config['items_ecology'] as $item_conf) {
                $items[] = [
                    'text' => $item_conf['text'][$id_lang] ?? '',
                    'icon' => $item_conf['icon'] ?? ''
                ];
            }
        }
        $data['ecology_items_list'] = $items;
        return $data;
    }

    private function getContactData(MlThemeSection $section)
    {
        $config = $section->config ? json_decode($section->config, true) : [];
        $id_lang = $this->context->language->id;

        $data = [];
        $data['contact_title'] = $config['title_contact'][$id_lang] ?? $section->title ?? $this->l('Contact Us', 'mlthemebuilder');
        $data['contact_address'] = $config['address_contact'][$id_lang] ?? Configuration::get('PS_SHOP_ADDR1');
        $data['contact_phone'] = $config['phone_contact'][$id_lang] ?? Configuration::get('PS_SHOP_PHONE');
        $data['contact_email'] = $config['email_contact'][$id_lang] ?? Configuration::get('PS_SHOP_EMAIL');
        $data['contact_hours'] = $config['hours_contact'][$id_lang] ?? '';
        $data['show_form_contact'] = $config['show_form_contact'] ?? true;
        $data['show_map_contact'] = $config['show_map_contact'] ?? false;
        $data['map_embed_code_contact'] = $config['map_embed_code_contact'] ?? ''; // Should be sanitized if outputting directly

        return $data;
    }

    /**
     * Gets the path to the module's image directory.
     * @param string $type 'icons', 'sections', 'brands', etc.
     * @return string Physical path.
     */
    public functiongetLocalImgPath($type = null)
    {
        $path = $this->getLocalPath().'views/img/';
        if ($type && is_string($type) && preg_match('/^[a-zA-Z0-9_-]+$/', $type)) {
            $path .= $type . '/';
        }
        return $path;
    }

    /**
     * Gets the URL to the module's image directory.
     * @param string $type 'icons', 'sections', 'brands', etc.
     * @return string URL.
     */
    public functiongetModuleImgUri($type = null)
    {
        $uri = $this->_path.'views/img/';
        if ($type && is_string($type) && preg_match('/^[a-zA-Z0-9_-]+$/', $type)) {
            $uri .= $type . '/';
        }
        return $uri;
    }
}
