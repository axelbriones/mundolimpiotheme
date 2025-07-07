<?php
/**
 * AdminMlThemeBuilderController
 *
 * This controller handles the configuration interface for the MlThemeBuilder module.
 * It allows users to manage sections, customize their appearance, and handle other settings.
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

class AdminMlThemeBuilderController extends ModuleAdminController
{
    protected $moduleInstance;

    public function __construct()
    {
        $this->bootstrap = true;
        $this->display = 'view'; // Use 'view' for custom template, 'list' for HelperList
        $this->className = 'MlThemeSection'; // Main ObjectModel for sections
        $this->table = MlThemeSection::$definition['table']; // Main table for sections, prefixed
       // $this->identifier = MlThemeSection::$definition['primary']; // Primary key for sections

        parent::__construct();
        $this->moduleInstance = Module::getInstanceByName('mlthemebuilder');

        // Check if module instance is valid
        if (!$this->moduleInstance instanceof Module) {
            // Handle error, e.g., redirect or display an error message
            $this->errors[] = $this->trans('Module instance could not be loaded.', [], 'Modules.Mlthemebuilder.Admin');
            // You might want to log this error as well.
        }


        $this->page_header_toolbar_title = $this->l('Mundo Limpio Theme Builder');
        $this->toolbar_title = $this->l('Mundo Limpio Theme Builder Configuration');
    }

    /**
     * Initialize the controller.
     * Set up context, assign Smarty variables.
     */
    public function init()
    {
        parent::init();
        // This is crucial if you are using a custom template for the entire page
        // And not relying on HelperList or HelperForm for the main view.
        // $this->content = $this->renderView(); // Calls renderView method
    }

    /**
     * This method is called if $this->display = 'view';
     * It should return the HTML content of your custom configuration page.
     */
    public function renderView()
    {
        if (!$this->moduleInstance) {
             return '<div class="alert alert-danger">'.$this->trans('Module not loaded.', [], 'Modules.Mlthemebuilder.Admin').'</div>';
        }
        // Fetch all necessary data for the main configuration template
        $id_lang = $this->context->language->id;
        $id_shop = $this->context->shop->id;

        // Sections for the manager
        $sections = MlThemeSection::getSections(null, $id_lang, $id_shop);
        $this->context->smarty->assign('sections', $sections);

        // Services for the manager
        $services_list = MlThemeService::getServices($id_lang, null, $id_shop); // Get all services
        $this->context->smarty->assign('services_list', $services_list);

        // Brands for the manager
        $brands_list = MlThemeBrand::getBrands(null, $id_shop); // Get all brands
        $this->context->smarty->assign('brands_list', $brands_list);

        // Global Styles & Advanced Settings (from MlThemeSetting class)
        $global_styles_keys = ['primary_color', 'secondary_color', 'text_color', 'link_color', 'bg_light_color', 'bg_dark_color', 'primary_font', 'secondary_font', 'base_font_size', 'heading_font_scale', 'google_fonts_url', 'container_max_width', 'section_padding_y', 'button_border_radius'];
        $advanced_settings_keys = ['custom_css', 'custom_js_header', 'custom_js_footer', 'enable_animations', 'enable_lazy_loading', 'enable_dark_mode', 'enable_section_cache'];

        $this->context->smarty->assign('global_styles', MlThemeSetting::getMultipleSettings($global_styles_keys, $id_shop));
        $this->context->smarty->assign('advanced_settings', MlThemeSetting::getMultipleSettings($advanced_settings_keys, $id_shop));


        // Other variables for the template
        $this->context->smarty->assign(array(
            'module_dir' => $this->moduleInstance->_path,
            'module_local_path' => $this->moduleInstance->getLocalPath(),
            'theme_img_path' => $this->moduleInstance->getModuleImgUri(), // Path to module's img dir for previews
            'ajax_url' => $this->context->link->getAdminLink('AdminMlThemeBuilder', true, [], ['ajax' => 1]), // Generic AJAX URL
            'img_upload_url' => $this->context->link->getAdminLink('AdminMlThemeBuilder', true, [], ['ajax' => 1, 'action' => 'UploadImage']), // Specific for image uploads
            'export_config_url' => $this->context->link->getAdminLink('AdminMlThemeBuilder', true, [], ['action' => 'ExportConfig']),
            'import_config_url' => $this->context->link->getAdminLink('AdminMlThemeBuilder', true, [], ['action' => 'ImportConfig']), // This will be handled by AJAX
            'languages' => Language::getLanguages(false),
            'default_language' => (int)Configuration::get('PS_LANG_DEFAULT'),
            'current_language' => $this->context->language,
            'ps_version' => _PS_VERSION_
        ));

        // Fetch the main configuration template
        return $this->moduleInstance->display($this->moduleInstance->getLocalPath(), 'views/templates/admin/configure.tpl');
    }

    /**
     * This is the entry point for actions when the page is loaded or a form is submitted.
     * PrestaShop calls this method for POST requests.
     */
    public function postProcess()
    {
        if (Tools::isSubmit('submitMlThemeBuilderGlobal')) {
            $this->processSaveGlobalSettings();
        }
        // Other specific form submissions can be handled here if not using AJAX
        // For AJAX actions, they are typically handled in ajaxProcess[ActionName]() methods.

        // Note: processSave() is typically for HelperForm submissions.
        // If your global settings form is custom, you handle it manually.
        parent::postProcess();
    }

    protected function processSaveGlobalSettings()
    {
        $id_shop_group = $this->context->shop->id_shop_group;
        $id_shop = $this->context->shop->id;
        $languages = Language::getLanguages(false);

        // Save Global Styles
        if (Tools::isSubmit('ctb_global_style')) { // Using 'ctb_' prefix from TPL for now
            $global_styles = Tools::getValue('ctb_global_style');
            if (is_array($global_styles)) {
                foreach ($global_styles as $key => $value) {
                    MlThemeSetting::updateSettingValue($key, $value, $id_shop);
                }
            }
        }

        // Save Advanced Settings
        if (Tools::isSubmit('ctb_advanced_settings')) {
            $advanced_settings = Tools::getValue('ctb_advanced_settings');
             if (is_array($advanced_settings)) {
                foreach ($advanced_settings as $key => $value) {
                    // Sanitize boolean values from switches
                    if (in_array($key, ['enable_animations', 'enable_lazy_loading', 'enable_dark_mode', 'enable_section_cache'])) {
                        $value = (int)$value;
                    }
                    MlThemeSetting::updateSettingValue($key, $value, $id_shop);
                }
            }
        }

        // Clear module cache if settings affecting frontend are changed
        $this->moduleInstance->clearCache('*');

        $this->confirmations[] = $this->l('Global settings updated successfully.');
    }


    /**
     * Handles AJAX requests.
     * This method is called by PrestaShop when an AJAX request is made to this controller.
     * The specific action is determined by Tools::getValue('action').
     */
    public function ajaxProcess()
    {
        $action = Tools::getValue('action');
        // error_log("AdminMlThemeBuilderController AJAX action: " . $action); // For debugging

        // Secure AJAX calls: check token if needed, check employee permissions
        if (!$this->tabAccess['view']) {
             $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Access denied.')]));
        }

        // Whitelist of allowed AJAX actions
        $allowed_actions = [
            'UpdateSectionOrder', 'ToggleSectionStatus', 'SaveSectionConfig', 'GetSectionForm', 'AddSection', 'DeleteSection',
            'UpdateServiceOrder', 'ToggleServiceStatus', 'SaveService', 'GetService', 'DeleteService', 'GetUploadedIcons', 'UploadServiceIcon',
            'UpdateBrandOrder', 'ToggleBrandStatus', 'SaveBrand', 'GetBrand', 'DeleteBrand', 'UploadBrandLogo', 'RemoveBrandLogo',
            'UploadImage', // Generic image uploader for section configs
            'ExportConfig', 'ImportConfig' // Import/Export actions
        ];

        if ($action && in_array($action, $allowed_actions) && method_exists($this, 'ajaxProcess' . $action)) {
            return $this->{'ajaxProcess' . $action}();
        } else {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Invalid AJAX action.') . $action]));
        }
    }

    // --- Section AJAX Methods ---
    public function ajaxProcessUpdateSectionOrder()
    {
        $orderData = Tools::getValue('order'); // Expecting an array of id_mltheme_section
        if ($orderData && is_array($orderData)) {
            $positions = [];
            foreach ($orderData as $position => $id_section) {
                // $id_section might be like "section_item_X" from some JS libs, extract X
                if (is_string($id_section) && strpos($id_section, '_') !== false) {
                     $id_parts = explode('_', $id_section);
                     $id_section = (int)end($id_parts);
                } else {
                    $id_section = (int)$id_section;
                }
                if ($id_section > 0) {
                    $positions[] = ['id' => $id_section, 'position' => $position + 1];
                }
            }
            if (MlThemeSection::updatePositions($positions)) {
                $this->moduleInstance->clearCache('*');
                $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Section order updated.')]));
            }
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to update section order.')]));
    }

    public function ajaxProcessToggleSectionStatus()
    {
        $id_section = (int)Tools::getValue('id_mltheme_section');
        if (!$id_section) {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Invalid section ID.')]));
        }
        $section = new MlThemeSection($id_section);
        if (!Validate::isLoadedObject($section)) {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Section not found.')]));
        }
        $section->active = !$section->active;
        if ($section->save()) {
            $this->moduleInstance->clearCache('*');
            $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Section status updated.'), 'active' => $section->active]));
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to update section status.')]));
    }

    public function ajaxProcessAddSection()
    {
        $name = Tools::getValue('new_section_name');
        $type = Tools::getValue('new_section_type');
        $titles = Tools::getValue('new_section_title'); // Array by id_lang

        if (empty($name) || !Validate::isGenericName($name)) {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Invalid section name.')]));
        }
        if (empty($type) || !Validate::isGenericName($type)) {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Invalid section type.')]));
        }

        $section = new MlThemeSection();
        $section->name = $name;
        $section->type = $type;
        $section->active = 1; // Active by default
        $section->config = '{}'; // Default empty JSON config

        $languages = Language::getLanguages(false);
        foreach ($languages as $lang) {
            $id_lang = (int)$lang['id_lang'];
            $section->title[$id_lang] = isset($titles[$id_lang]) ? $titles[$id_lang] : $name; // Default title to name if not provided
            // Other multilingual fields can be defaulted here if needed
        }

        if ($section->add()) {
            $this->moduleInstance->clearCache('*');
            // Prepare data for the new row in template
            $default_lang_id = (int)Configuration::get('PS_LANG_DEFAULT');
            $display_name = $section->title[$default_lang_id] ?? $section->name;

            $this->ajaxDie(json_encode([
                'success' => true,
                'message' => $this->l('Section added successfully.'),
                'section' => [
                    'id_mltheme_section' => $section->id,
                    'name' => $section->name, // internal name
                    'raw_name' => $section->name, // for template placeholder
                    'display_name' => $display_name, // for template placeholder {name}
                    'type' => $section->type,
                    'position' => $section->position,
                    'active' => $section->active,
                ]
            ]));
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to add section.') . implode(', ', $section->getErrorMsg())]));
    }

    public function ajaxProcessDeleteSection()
    {
        $id_section = (int)Tools::getValue('id_mltheme_section');
        if (!$id_section) {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Invalid section ID.')]));
        }
        $section = new MlThemeSection($id_section);
        if (!Validate::isLoadedObject($section)) {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Section not found.')]));
        }
        if ($section->delete()) {
            $this->moduleInstance->clearCache('*');
            // Also re-calculate positions for remaining sections if needed, though usually not required on simple delete.
            MlThemeSection::reorderPositions($this->context->shop->id);
            $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Section deleted.')]));
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to delete section.')]));
    }


    public function ajaxProcessSaveSectionConfig()
    {
        $id_section = (int)Tools::getValue('id_mltheme_section');
        if (!$id_section) {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Invalid Section ID')]));
        }
        $section = new MlThemeSection($id_section, null, $this->context->shop->id);
        if (!Validate::isLoadedObject($section)) {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Section not found')]));
        }

        $config_data = Tools::getValue('config', []); // Expect an array of config fields
        $titles = Tools::getValue('title'); // Array by id_lang
        $contents = Tools::getValue('content'); // Array by id_lang
        $button_texts = Tools::getValue('button_text'); // Array by id_lang
        $button_links = Tools::getValue('button_link'); // Array by id_lang

        $languages = Language::getLanguages(false);
        foreach ($languages as $lang) {
            $id_lang = (int)$lang['id_lang'];
            if (isset($titles[$id_lang])) $section->title[$id_lang] = $titles[$id_lang];
            if (isset($contents[$id_lang])) $section->content[$id_lang] = $contents[$id_lang]; // Make sure to use 'isCleanHTML' validation
            if (isset($button_texts[$id_lang])) $section->button_text[$id_lang] = $button_texts[$id_lang];
            if (isset($button_links[$id_lang])) $section->button_link[$id_lang] = $button_links[$id_lang];
        }

        // Sanitize config data before encoding, especially if it contains HTML or complex structures
        // For example, if a 'custom_html' field is part of config:
        // if (isset($config_data['custom_html_field'])) {
        //     $config_data['custom_html_field'] = Tools::purifyHTML($config_data['custom_html_field']);
        // }
        $section->config = json_encode($config_data);
        $section->date_upd = date('Y-m-d H:i:s');

        if ($section->save()) {
            $this->moduleInstance->clearCache('*');
            $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Configuration saved.')]));
        } else {
            $errors = $section->getErrorMsg();
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Error saving configuration: ') . ($errors ? implode(', ', $errors) : '')]));
        }
    }

    public function ajaxProcessGetSectionForm()
    {
        $id_section = (int)Tools::getValue('id_mltheme_section');
        $section = new MlThemeSection($id_section, null, $this->context->shop->id); // Load for all languages initially

        if (!Validate::isLoadedObject($section)) {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Section not found')]));
        }

        $config = json_decode($section->config, true);
        if ($config === null) $config = [];

        $languages = Language::getLanguages(false);
        $section_data_for_tpl = [
            'id_section' => $section->id,
            'type' => $section->type,
            'name' => $section->name,
            'config' => $config,
            'titles' => [], 'contents' => [], 'button_texts' => [], 'button_links' => [], // Initialize lang arrays
        ];

        foreach ($languages as $lang) {
            $id_lang = (int)$lang['id_lang'];
            // ObjectModel loads multilingual fields as arrays, access them directly
            $section_data_for_tpl['titles'][$id_lang] = $section->title[$id_lang] ?? '';
            $section_data_for_tpl['contents'][$id_lang] = $section->content[$id_lang] ?? '';
            $section_data_for_tpl['button_texts'][$id_lang] = $section->button_text[$id_lang] ?? '';
            $section_data_for_tpl['button_links'][$id_lang] = $section->button_link[$id_lang] ?? '';
        }

        $template_file = 'admin/sections/' . Tools::strtolower($section->type) . '.tpl';
        $template_path_full = $this->moduleInstance->getLocalPath() . 'views/templates/' . $template_file;

        if (!file_exists($template_path_full)) {
             $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Config template not found for type:') . ' ' . $section->type]));
        }

        $this->context->smarty->assign(array(
            'section_data' => $section_data_for_tpl,
            'languages' => $languages,
            'current_language' => $this->context->language, // Current BO language
            'default_language' => (int)Configuration::get('PS_LANG_DEFAULT'),
            'theme_img_path' => $this->moduleInstance->getModuleImgUri(), // For image previews
            'module_local_path' => $this->moduleInstance->getLocalPath(), // For any server-side includes if necessary
        ));

        $form_html = $this->context->smarty->fetch($template_path_full);
        $this->ajaxDie(json_encode(['success' => true, 'form_html' => $form_html, 'section_name' => $section_data_for_tpl['titles'][$this->context->language->id] ?? $section->name]));
    }

    // --- Service AJAX Methods ---
    public function ajaxProcessUpdateServiceOrder() { /* ... similar to sections ... */
        $orderData = Tools::getValue('order');
        if ($orderData && is_array($orderData)) {
            $positions = [];
            foreach ($orderData as $position => $id_service_raw) {
                 $id_service = (int)str_replace('service_item_', '', $id_service_raw);
                if ($id_service > 0) {
                    $positions[] = ['id' => $id_service, 'position' => $position + 1];
                }
            }
            if (MlThemeService::updatePositions($positions)) {
                $this->moduleInstance->clearCache('*');
                $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Service order updated.')]));
            }
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to update service order.')]));
    }
    public function ajaxProcessToggleServiceStatus() { /* ... similar to sections ... */
        $id_service = (int)Tools::getValue('id_mltheme_service');
        $service = new MlThemeService($id_service);
        if (!Validate::isLoadedObject($service)) $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Service not found.')]));
        $service->active = !$service->active;
        if ($service->save()) {
            $this->moduleInstance->clearCache('*');
            $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Service status updated.'), 'active' => $service->active]));
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to update service status.')]));
    }
    public function ajaxProcessSaveService() { /* ... new object or load, populate, save ... */
        $id_service = (int)Tools::getValue('id_mltheme_service');
        $service = new MlThemeService($id_service ?: null, null, $this->context->shop->id);

        $service->icon = Tools::getValue('icon');
        $service->active = (int)Tools::getValue('active');

        $languages = Language::getLanguages(false);
        foreach ($languages as $lang) {
            $id_lang = (int)$lang['id_lang'];
            $service->title[$id_lang] = Tools::getValue('title_' . $id_lang);
            $service->description[$id_lang] = Tools::getValue('description_' . $id_lang, ''); // Allow HTML, validate on model
        }

        if ($service->save()) {
            $this->moduleInstance->clearCache('*');
            $default_lang_id = (int)Configuration::get('PS_LANG_DEFAULT');
            $this->ajaxDie(json_encode([
                'success' => true,
                'message' => $this->l('Service saved.'),
                'service' => [
                    'id_mltheme_service' => $service->id,
                    'icon' => $service->icon,
                    'title_default' => $service->title[$default_lang_id] ?? '',
                    'active' => $service->active,
                    // Pass all lang titles if needed for template update
                     'titles' => $service->title,
                ]
            ]));
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to save service.') . implode(', ', $service->getErrorMsg())]));
    }
    public function ajaxProcessGetService() { /* ... load and return JSON data for form population ... */
        $id_service = (int)Tools::getValue('id_mltheme_service');
        $service = new MlThemeService($id_service, null, $this->context->shop->id);
        if (!Validate::isLoadedObject($service)) $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Service not found.')]));

        $data = (array)$service;
        // Ensure multilingual fields are correctly formatted if not already arrays by ObjectModel
        $data['title'] = $service->title;
        $data['description'] = $service->description;

        $this->ajaxDie(json_encode(['success' => true, 'service' => $data]));
    }
    public function ajaxProcessDeleteService() { /* ... load and delete ... */
        $id_service = (int)Tools::getValue('id_mltheme_service');
        $service = new MlThemeService($id_service);
        if (!Validate::isLoadedObject($service)) $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Service not found.')]));
        if ($service->delete()) {
            $this->moduleInstance->clearCache('*');
            MlThemeService::reorderPositions($this->context->shop->id);
            $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Service deleted.')]));
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to delete service.')]));
    }
    public function ajaxProcessGetUploadedIcons() { /* ... list files from img/icons ... */
        $icons_dir = $this->moduleInstance->getLocalImgPath('icons');
        $icons_uri = $this->moduleInstance->getModuleImgUri('icons');
        $files = [];
        if (is_dir($icons_dir)) {
            $scanned_files = scandir($icons_dir);
            foreach ($scanned_files as $file) {
                if ($file !== '.' && $file !== '..' && $file !== 'index.php' && is_file($icons_dir . $file)) {
                    if (preg_match('/\.(jpg|jpeg|png|gif|svg)$/i', $file)) {
                        $files[] = ['name' => $file, 'url' => $icons_uri . $file];
                    }
                }
            }
        }
        $this->ajaxDie(json_encode(['success' => true, 'icons' => $files]));
    }
    public function ajaxProcessUploadServiceIcon() { /* ... handle file upload to img/icons ... */
        if (isset($_FILES['service_icon_file']) && $_FILES['service_icon_file']['error'] == 0) {
            $uploader = new Uploader('service_icon_file');
            $uploader->setAcceptTypes(['jpeg', 'jpg', 'png', 'gif', 'svg']);
            $uploader->setSavePath($this->moduleInstance->getLocalImgPath('icons'));
            $file = $uploader->process();

            if ($file && !empty($file[0]) && $file[0]['status'] == 'ok') {
                $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Icon uploaded.'), 'filename' => $file[0]['name'], 'url' => $this->moduleInstance->getModuleImgUri('icons') . $file[0]['name']]));
            } else {
                $errors = $uploader->getErrors() ?: [$this->l('Unknown upload error.')];
                $this->ajaxDie(json_encode(['error' => true, 'message' => implode(', ', $errors)]));
            }
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('No file uploaded or upload error.')]));
    }


    // --- Brand AJAX Methods ---
    public function ajaxProcessUpdateBrandOrder() { /* ... similar to sections ... */
        $orderData = Tools::getValue('order');
        if ($orderData && is_array($orderData)) {
            $positions = [];
            foreach ($orderData as $position => $id_brand_raw) {
                 $id_brand = (int)str_replace('brand_item_', '', $id_brand_raw); // Assuming JS sends IDs like 'brand_item_X'
                if ($id_brand > 0) {
                    $positions[] = ['id' => $id_brand, 'position' => $position + 1];
                }
            }
            if (MlThemeBrand::updatePositions($positions)) {
                $this->moduleInstance->clearCache('*');
                $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Brand order updated.')]));
            }
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to update brand order.')]));
    }
    public function ajaxProcessToggleBrandStatus() { /* ... similar to sections ... */
        $id_brand = (int)Tools::getValue('id_mltheme_brand');
        $brand = new MlThemeBrand($id_brand);
        if (!Validate::isLoadedObject($brand)) $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Brand not found.')]));
        $brand->active = !$brand->active;
        if ($brand->save()) {
            $this->moduleInstance->clearCache('*');
            $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Brand status updated.'), 'active' => $brand->active]));
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to update brand status.')]));
    }
    public function ajaxProcessSaveBrand() { /* ... new object or load, populate, save, handle logo upload ... */
        $id_brand = (int)Tools::getValue('id_mltheme_brand');
        $brand = new MlThemeBrand($id_brand ?: null, null, $this->context->shop->id);

        $brand->name = Tools::getValue('name');
        $brand->url = Tools::getValue('url');
        $brand->active = (int)Tools::getValue('active');
        $current_logo = Tools::getValue('current_logo');

        // Handle logo upload
        if (isset($_FILES['logo_file']) && $_FILES['logo_file']['error'] == 0) {
            $uploader = new Uploader('logo_file');
            $uploader->setAcceptTypes(['jpeg', 'jpg', 'png', 'gif', 'svg']);
            $uploader->setSavePath($this->moduleInstance->getLocalImgPath('brands'));
            $file = $uploader->process($brand->name . '_' . time()); // Add timestamp to avoid overwrites

            if ($file && !empty($file[0]) && $file[0]['status'] == 'ok') {
                // Delete old logo if exists and different
                if ($brand->logo && $brand->logo != $file[0]['name'] && file_exists($this->moduleInstance->getLocalImgPath('brands') . $brand->logo)) {
                    @unlink($this->moduleInstance->getLocalImgPath('brands') . $brand->logo);
                }
                $brand->logo = $file[0]['name'];
            } else {
                $errors = $uploader->getErrors() ?: [$this->l('Logo upload error.')];
                $this->ajaxDie(json_encode(['error' => true, 'message' => implode(', ', $errors)]));
                return; // Stop processing if upload failed
            }
        } elseif ($current_logo) {
            $brand->logo = $current_logo; // Keep current logo if no new one uploaded
        } else {
            // If current_logo is empty and no new file, it means remove logo.
            // Delete old logo if it exists
            if ($brand->logo && file_exists($this->moduleInstance->getLocalImgPath('brands') . $brand->logo)) {
                @unlink($this->moduleInstance->getLocalImgPath('brands') . $brand->logo);
            }
            $brand->logo = null;
        }


        if ($brand->save()) {
            $this->moduleInstance->clearCache('*');
            $this->ajaxDie(json_encode([
                'success' => true,
                'message' => $this->l('Brand saved.'),
                'brand' => [
                    'id_mltheme_brand' => $brand->id,
                    'name' => $brand->name,
                    'logo' => $brand->logo,
                    'logo_url' => $brand->logo ? $this->moduleInstance->getModuleImgUri('brands') . $brand->logo : null,
                    'active' => $brand->active,
                ]
            ]));
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to save brand.') . implode(', ', $brand->getErrorMsg())]));
    }
    public function ajaxProcessGetBrand() { /* ... load and return JSON data for form population ... */
        $id_brand = (int)Tools::getValue('id_mltheme_brand');
        $brand = new MlThemeBrand($id_brand, null, $this->context->shop->id);
        if (!Validate::isLoadedObject($brand)) $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Brand not found.')]));

        $data = (array)$brand;
        $data['logo_url'] = $brand->logo ? $this->moduleInstance->getModuleImgUri('brands') . $brand->logo : null;
        $this->ajaxDie(json_encode(['success' => true, 'brand' => $data]));
    }
    public function ajaxProcessDeleteBrand() { /* ... load and delete, also delete logo file ... */
        $id_brand = (int)Tools::getValue('id_mltheme_brand');
        $brand = new MlThemeBrand($id_brand);
        if (!Validate::isLoadedObject($brand)) $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Brand not found.')]));

        // Delete logo file first
        if ($brand->logo && file_exists($this->moduleInstance->getLocalImgPath('brands') . $brand->logo)) {
            @unlink($this->moduleInstance->getLocalImgPath('brands') . $brand->logo);
        }

        if ($brand->delete()) {
            $this->moduleInstance->clearCache('*');
            MlThemeBrand::reorderPositions($this->context->shop->id);
            $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Brand deleted.')]));
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to delete brand.')]));
    }
     public function ajaxProcessRemoveBrandLogo() {
        $id_brand = (int)Tools::getValue('id_mltheme_brand');
        $brand = new MlThemeBrand($id_brand);
        if (!Validate::isLoadedObject($brand)) {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Brand not found.')]));
        }
        if ($brand->logo && file_exists($this->moduleInstance->getLocalImgPath('brands') . $brand->logo)) {
            @unlink($this->moduleInstance->getLocalImgPath('brands') . $brand->logo);
        }
        $brand->logo = null;
        if ($brand->save()) {
            $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Logo removed.')]));
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Failed to remove logo.')]));
    }

    // --- Generic Image Uploader for Section Configs ---
    public function ajaxProcessUploadImage()
    {
        $upload_type = Tools::getValue('upload_type'); // e.g., 'section_background', 'section_image', 'icon'
        $id_item = (int)Tools::getValue('id_item'); // e.g., id_section or other relevant ID
        $destination_folder = '';

        switch ($upload_type) {
            case 'section_background':
            case 'section_image':
                $destination_folder = 'sections';
                break;
            case 'icon': // For generic icons if not using service/brand specific uploaders
                $destination_folder = 'icons';
                break;
            default:
                $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Invalid upload type.')]));
        }

        $save_path = $this->moduleInstance->getLocalImgPath($destination_folder);
        if (!is_dir($save_path) || !is_writable($save_path)) {
             @mkdir($save_path, 0775, true); // Try to create if not exists
             if (!is_dir($save_path) || !is_writable($save_path)) {
                $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Upload directory is not writable or does not exist: ') . $save_path]));
             }
        }

        if (isset($_FILES['file']) && $_FILES['file']['error'] == 0) {
            $uploader = new Uploader('file'); // Input name is 'file'
            $uploader->setAcceptTypes(['jpeg', 'jpg', 'png', 'gif', 'svg', 'webp']);
            $uploader->setSavePath($save_path);
            // Generate a unique filename, perhaps prefixed by section ID or type
            $original_name = pathinfo($_FILES['file']['name'], PATHINFO_FILENAME);
            $extension = pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION);
            $filename_base = Tools::link_rewrite($original_name) . ($id_item ? '_'.$id_item : '');

            $file = $uploader->process($filename_base . '_' . time() . '.' . $extension);

            if ($file && !empty($file[0]) && $file[0]['status'] == 'ok') {
                $this->ajaxDie(json_encode([
                    'success' => true,
                    'message' => $this->l('Image uploaded.'),
                    'filename' => $file[0]['name'],
                    'url' => $this->moduleInstance->getModuleImgUri($destination_folder) . $file[0]['name']
                ]));
            } else {
                $errors = $uploader->getErrors() ?: [$this->l('Unknown upload error for image.')];
                $this->ajaxDie(json_encode(['error' => true, 'message' => implode(', ', $errors)]));
            }
        }
        $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('No file uploaded or general upload error.')]));
    }

    // --- Import/Export AJAX Methods ---
    public function ajaxProcessExportConfig() {
        // This might not be AJAX if it forces a file download directly.
        // If it is AJAX, it would generate the file then provide a link.
        // For simplicity, direct download is often handled outside typical AJAX flow.
        // However, if triggering via JS, JS can construct the URL with selected parts.

        $parts_to_export = Tools::getValue('parts'); // Comma-separated string like "sections_structure,global_styles"
        if ($parts_to_export) {
            $parts_array = explode(',', $parts_to_export);
        } else {
            // Default: export all
            $parts_array = ['sections_structure', 'sections_content', 'services_data', 'brands_data', 'global_styles', 'advanced_settings'];
        }

        $export_data = [];
        $id_lang_default = (int)Configuration::get('PS_LANG_DEFAULT');
        $id_shop = (int)$this->context->shop->id;

        if (in_array('sections_structure', $parts_array) || in_array('sections_content', $parts_array)) {
            $sections = MlThemeSection::getSections(null, null, $id_shop); // Get all sections, all languages
            $export_data['sections'] = [];
            foreach ($sections as $s_db) {
                $s_obj = new MlThemeSection($s_db['id_mltheme_section'], null, $id_shop);
                $section_export = [
                    'name' => $s_obj->name,
                    'type' => $s_obj->type,
                    'position' => $s_obj->position,
                    'active' => $s_obj->active,
                ];
                if (in_array('sections_content', $parts_array)) {
                    $section_export['config'] = json_decode($s_obj->config, true) ?: new stdClass(); // Ensure object if empty
                    $section_export['titles'] = $s_obj->title;
                    $section_export['contents'] = $s_obj->content;
                    $section_export['button_texts'] = $s_obj->button_text;
                    $section_export['button_links'] = $s_obj->button_link;
                }
                $export_data['sections'][] = $section_export;
            }
        }

        if (in_array('services_data', $parts_array)) {
            $services = MlThemeService::getServices(null, null, $id_shop); // All services, all langs
            $export_data['services'] = [];
            foreach ($services as $s_db) {
                $s_obj = new MlThemeService($s_db['id_mltheme_service'], null, $id_shop);
                $export_data['services'][] = [
                    'icon' => $s_obj->icon,
                    'position' => $s_obj->position,
                    'active' => $s_obj->active,
                    'titles' => $s_obj->title,
                    'descriptions' => $s_obj->description,
                ];
            }
        }

        if (in_array('brands_data', $parts_array)) {
             $brands = MlThemeBrand::getBrands(null, $id_shop); // All brands
             $export_data['brands'] = [];
             foreach ($brands as $b_db) {
                 $export_data['brands'][] = [
                     'name' => $b_db['name'],
                     'logo' => $b_db['logo'], // Filename only
                     'url' => $b_db['url'],
                     'position' => $b_db['position'],
                     'active' => $b_db['active'],
                 ];
             }
        }

        if (in_array('global_styles', $parts_array)) {
            $keys = ['primary_color', 'secondary_color', 'text_color', 'link_color', 'bg_light_color', 'bg_dark_color', 'primary_font', 'secondary_font', 'base_font_size', 'heading_font_scale', 'google_fonts_url', 'container_max_width', 'section_padding_y', 'button_border_radius'];
            $export_data['global_styles'] = MlThemeSetting::getMultipleSettings($keys, $id_shop);
        }

        if (in_array('advanced_settings', $parts_array)) {
            $keys = ['custom_css', 'custom_js_header', 'custom_js_footer', 'enable_animations', 'enable_lazy_loading', 'enable_dark_mode', 'enable_section_cache'];
            $export_data['advanced_settings'] = MlThemeSetting::getMultipleSettings($keys, $id_shop);
        }

        $filename = 'mlthemebuilder_config_' . date('Ymd_His') . '.json';
        header('Content-Disposition: attachment; filename="' . $filename . '"');
        header('Content-Type: application/json');
        // No die() or exit() here if called from non-AJAX context to allow download.
        // If this is truly an AJAX endpoint that returns JSON to trigger download on client:
        // $this->ajaxDie(json_encode($export_data));
        // For direct download from a link:
        echo json_encode($export_data, JSON_PRETTY_PRINT);
        exit;
    }

    public function ajaxProcessImportConfig() {
        if (!isset($_FILES['import_file']) || $_FILES['import_file']['error'] != 0) {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('No file uploaded or upload error.')]));
        }

        $json_content = Tools::file_get_contents($_FILES['import_file']['tmp_name']);
        $data = json_decode($json_content, true);

        if (json_last_error() !== JSON_ERROR_NONE) {
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Invalid JSON file: ') . json_last_error_msg()]));
        }

        $import_mode = Tools::getValue('import_mode', 'overwrite_all'); // overwrite_all, merge_append
        // $skip_uploads = (bool)Tools::getValue('import_skip_uploads', false); // Not implemented in detail here

        $id_shop = (int)$this->context->shop->id;
        $languages = Language::getLanguages(false);
        $default_lang_id = (int)Configuration::get('PS_LANG_DEFAULT');
        $errors = [];

        Db::getInstance()->beginTransaction();

        try {
            // Global Styles
            if (isset($data['global_styles']) && is_array($data['global_styles'])) {
                if ($import_mode == 'overwrite_all') { /* Consider deleting existing first if necessary */ }
                foreach ($data['global_styles'] as $key => $value) {
                    MlThemeSetting::updateSettingValue($key, $value, $id_shop);
                }
            }
            // Advanced Settings
            if (isset($data['advanced_settings']) && is_array($data['advanced_settings'])) {
                 if ($import_mode == 'overwrite_all') { /* Consider deleting existing first */ }
                foreach ($data['advanced_settings'] as $key => $value) {
                    MlThemeSetting::updateSettingValue($key, $value, $id_shop);
                }
            }

            // Sections
            if (isset($data['sections']) && is_array($data['sections'])) {
                if ($import_mode == 'overwrite_all') {
                    Db::getInstance()->execute('DELETE FROM `'._DB_PREFIX_.'mltheme_sections_lang` WHERE id_shop = '.$id_shop);
                    Db::getInstance()->execute('DELETE FROM `'._DB_PREFIX_.'mltheme_sections`'); // Assuming sections are not shop-specific in main table or add shop condition
                     // Reset auto_increment if needed, though usually not critical for this type of import
                }
                foreach ($data['sections'] as $s_data) {
                    $section = null;
                    if ($import_mode == 'merge_append') { // Try to find existing by name
                        $existing_id = MlThemeSection::getIdByName($s_data['name'], $id_shop);
                        if ($existing_id) $section = new MlThemeSection($existing_id, null, $id_shop);
                    }
                    if (!$section) $section = new MlThemeSection(null, null, $id_shop);

                    $section->name = $s_data['name'];
                    $section->type = $s_data['type'];
                    $section->position = $s_data['position'];
                    $section->active = $s_data['active'];
                    $section->config = isset($s_data['config']) ? json_encode($s_data['config']) : '{}';

                    foreach ($languages as $lang) {
                        $id_l = (int)$lang['id_lang'];
                        $iso = $lang['iso_code'];
                        $section->title[$id_l] = $s_data['titles'][$iso] ?? $s_data['titles'][$id_l] ?? $s_data['titles'][$default_lang_id] ?? $s_data['name'];
                        $section->content[$id_l] = $s_data['contents'][$iso] ?? $s_data['contents'][$id_l] ?? $s_data['contents'][$default_lang_id] ?? '';
                        $section->button_text[$id_l] = $s_data['button_texts'][$iso] ?? $s_data['button_texts'][$id_l] ?? $s_data['button_texts'][$default_lang_id] ?? '';
                        $section->button_link[$id_l] = $s_data['button_links'][$iso] ?? $s_data['button_links'][$id_l] ?? $s_data['button_links'][$default_lang_id] ?? '#';
                    }
                    if (!$section->save()) $errors[] = $this->l('Error saving section ') . $s_data['name'] . ': ' . implode(', ',$section->getErrorMsg());
                }
            }

            // Services
            if (isset($data['services']) && is_array($data['services'])) {
                if ($import_mode == 'overwrite_all') {
                    Db::getInstance()->execute('DELETE FROM `'._DB_PREFIX_.'mltheme_services_lang` WHERE id_shop = '.$id_shop);
                    Db::getInstance()->execute('DELETE FROM `'._DB_PREFIX_.'mltheme_services`');
                }
                foreach ($data['services'] as $s_data) {
                    // Merge logic for services might be by title in default lang if no unique internal name
                    $service = new MlThemeService(null, null, $id_shop); // Simpler to always create for now
                    $service->icon = $s_data['icon'];
                    $service->position = $s_data['position'];
                    $service->active = $s_data['active'];
                     foreach ($languages as $lang) {
                        $id_l = (int)$lang['id_lang'];
                        $iso = $lang['iso_code'];
                        $service->title[$id_l] = $s_data['titles'][$iso] ?? $s_data['titles'][$id_l] ?? $s_data['titles'][$default_lang_id] ?? 'Service';
                        $service->description[$id_l] = $s_data['descriptions'][$iso] ?? $s_data['descriptions'][$id_l] ?? $s_data['descriptions'][$default_lang_id] ?? '';
                    }
                    if (!$service->save()) $errors[] = $this->l('Error saving service ') . ($service->title[$default_lang_id] ?? 'Unknown');
                }
            }

            // Brands
            if (isset($data['brands']) && is_array($data['brands'])) {
                if ($import_mode == 'overwrite_all') {
                    Db::getInstance()->execute('DELETE FROM `'._DB_PREFIX_.'mltheme_brands`'); // Assuming brands are global or add shop condition
                }
                 foreach ($data['brands'] as $b_data) {
                    // Merge for brands could be by name
                    $brand = new MlThemeBrand(null, null, $id_shop); // Simpler to always create for now
                    $brand->name = $b_data['name'];
                    $brand->logo = $b_data['logo']; // Assumes logo files will be manually handled or exist
                    $brand->url = $b_data['url'];
                    $brand->position = $b_data['position'];
                    $brand->active = $b_data['active'];
                    if (!$brand->save()) $errors[] = $this->l('Error saving brand ') . $b_data['name'];
                 }
            }

            if (!empty($errors)) {
                Db::getInstance()->rollback();
                $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Import failed with errors:'), 'errors' => $errors]));
            }

            Db::getInstance()->commit();
            $this->moduleInstance->clearCache('*');
            $this->ajaxDie(json_encode(['success' => true, 'message' => $this->l('Configuration imported successfully.')]));

        } catch (Exception $e) {
            Db::getInstance()->rollback();
            $this->ajaxDie(json_encode(['error' => true, 'message' => $this->l('Exception during import: ') . $e->getMessage()]));
        }
    }
}
