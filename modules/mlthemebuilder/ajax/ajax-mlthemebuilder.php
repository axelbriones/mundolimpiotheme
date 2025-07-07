<?php
/**
 * MlThemeBuilder AJAX Handler
 */

// Bootstrap PrestaShop
require_once dirname(__FILE__) . '/../../../config/config.inc.php';
require_once dirname(__FILE__) . '/../../../init.php'; // init.php will load ObjectModels

// Security check: Ensure it's a valid AJAX request and user has permissions
// This is a basic check; your AdminController would handle permissions more robustly for BO actions.
if (!Tools::isSubmit('ajax') || !Tools::isSubmit('action') /* || !Context::getContext()->employee->isLoggedBack() */) {
    die(json_encode(['error' => true, 'message' => 'Invalid AJAX request or permission denied.']));
}

// Ensure module is active
$module = Module::getInstanceByName('mlthemebuilder');
if (!$module || !$module->active) {
    die(json_encode(['error' => true, 'message' => 'Module not active.']));
}

$action = Tools::getValue('action');
$response = ['error' => true, 'message' => 'Unknown error.']; // Default response

// --- Autoload classes if not done by init.php for some reason or for direct script access ---
// spl_autoload_register(function ($class_name) {
//     $file = _PS_MODULE_DIR_ . 'mlthemebuilder/classes/' . $class_name . '.php';
//     if (file_exists($file)) {
//         require_once $file;
//     }
// });

// --- ACTION ROUTER ---
// Note: For actions that modify data and are initiated from the BO,
// it's best practice to handle them within an AdminController for security (tokens, permissions).
// This AJAX handler might be more suitable for frontend AJAX calls or very specific, simple BO tasks
// if an AdminController is not used for them.
// The AdminMlThemeBuilderController already has many AJAX methods. This file might be redundant
// or for different purposes (e.g., frontend AJAX).
// Assuming this file is for general AJAX and might duplicate some BO logic if not careful.

$context = Context::getContext();
$id_shop = (int)$context->shop->id;
$id_lang = (int)$context->language->id;

switch ($action) {
    // --- Section Actions (Example, mirror AdminController if needed) ---
    case 'updateMlSectionOrder': // Renamed from updateSectionOrder
        // This should ideally be in AdminMlThemeBuilderController with token check
        $order = json_decode(Tools::getValue('order'), true);
        if (is_array($order) && MlThemeSection::updatePositions($order)) {
            $module->clearCache('*');
            $response = ['success' => true, 'message' => $module->l('Section order updated.', 'ajax-mlthemebuilder')];
        } else {
            $response = ['error' => true, 'message' => $module->l('Failed to update section order.', 'ajax-mlthemebuilder')];
        }
        break;

    case 'toggleMlSectionStatus': // Renamed
        // Again, better in AdminController
        $id_section = (int)Tools::getValue('id_mltheme_section');
        $section = new MlThemeSection($id_section);
        if (Validate::isLoadedObject($section)) {
            $section->active = !$section->active;
            if ($section->save()) {
                $module->clearCache('*');
                $response = ['success' => true, 'message' => $module->l('Section status updated.', 'ajax-mlthemebuilder'), 'active' => $section->active];
            } else {
                $response = ['error' => true, 'message' => $module->l('Failed to update section status.', 'ajax-mlthemebuilder')];
            }
        } else {
            $response = ['error' => true, 'message' => $module->l('Section not found.', 'ajax-mlthemebuilder')];
        }
        break;

    case 'saveMlSectionConfig': // Renamed
        // Better in AdminController
        $id_section = (int)Tools::getValue('id_mltheme_section');
        $section = new MlThemeSection($id_section, null, $id_shop);
        if (!Validate::isLoadedObject($section)) {
             $response = ['error' => true, 'message' => $module->l('Section not found.', 'ajax-mlthemebuilder')];
             break;
        }

        $config_data = Tools::getValue('config', []);
        $titles = Tools::getValue('title');
        $contents = Tools::getValue('content');
        $button_texts = Tools::getValue('button_text');
        $button_links = Tools::getValue('button_link');

        $languages = Language::getLanguages(false);
        foreach ($languages as $lang) {
            $id_l = (int)$lang['id_lang'];
            if (isset($titles[$id_l])) $section->title[$id_l] = $titles[$id_l];
            if (isset($contents[$id_l])) $section->content[$id_l] = $contents[$id_l];
            if (isset($button_texts[$id_l])) $section->button_text[$id_l] = $button_texts[$id_l];
            if (isset($button_links[$id_l])) $section->button_link[$id_l] = $button_links[$id_l];
        }
        $section->config = json_encode($config_data);

        if ($section->save()) {
            $module->clearCache('*');
            $response = ['success' => true, 'message' => $module->l('Configuration saved.', 'ajax-mlthemebuilder')];
        } else {
            $response = ['error' => true, 'message' => $module->l('Error saving configuration.', 'ajax-mlthemebuilder') . implode(', ', $section->getErrorMsg())];
        }
        break;

    // --- Frontend Actions (Example: Contact Form) ---
    case 'submitContactForm':
        $contact_name = Tools::getValue('name');
        $contact_email = Tools::getValue('email');
        $contact_message = Tools::getValue('message');
        $id_section_form = (int)Tools::getValue('id_section'); // To potentially get recipient from section config

        if (!Validate::isGenericName($contact_name) || !Validate::isEmail($contact_email) || empty($contact_message)) {
            $response = ['error' => true, 'message' => $module->l('Please fill all required fields correctly.', 'ajax-mlthemebuilder')];
            break;
        }

        // Determine recipient email (e.g., from shop contact or section config)
        $recipient_email = Configuration::get('PS_SHOP_EMAIL');
        // $id_lang_mail = $context->language->id; // Or shop default language

        // You might want to load section config to see if there's a specific recipient for this form
        // if ($id_section_form) {
        //     $section = new MlThemeSection($id_section_form, $id_lang, $id_shop);
        //     if (Validate::isLoadedObject($section) && $section->config) {
        //         $config = json_decode($section->config, true);
        //         if (!empty($config['recipient_email_contact']) && Validate::isEmail($config['recipient_email_contact'])) {
        //             $recipient_email = $config['recipient_email_contact'];
        //         }
        //     }
        // }

        $template_vars = array(
            '{name}' => $contact_name,
            '{email}' => $contact_email,
            '{message}' => nl2br(Tools:: htmlentitiesUTF8($contact_message)), // nl2br for display in HTML email
            '{shop_name}' => Configuration::get('PS_SHOP_NAME'),
            '{shop_url}' => Context::getContext()->link->getPageLink('index', true, $id_lang)
        );

        $mail_subject = $module->l('New message from your website contact form', 'ajax-mlthemebuilder') . ' - ' . Configuration::get('PS_SHOP_NAME');

        if (Mail::Send(
            $id_lang, // id_lang, for template selection
            'contact_form_submission', // template name (e.g., modules/mlthemebuilder/mails/es/contact_form_submission.html)
            $mail_subject,
            $template_vars,
            $recipient_email, // To
            null, // To Name
            $contact_email, // From
            $contact_name, // From Name
            null, // FileAttachment
            null, // SMTP
            _PS_MODULE_DIR_ . $module->name . '/mails/' // Path to mail templates
        )) {
            $response = ['success' => true, 'message' => $module->l('Your message has been sent successfully!', 'ajax-mlthemebuilder')];
        } else {
            $response = ['error' => true, 'message' => $module->l('An error occurred while sending your message. Please try again later.', 'ajax-mlthemebuilder')];
        }
        break;

    // --- Add other AJAX actions for Services, Brands, Settings as needed if not handled by AdminController ---
    // These would mirror the ajaxProcess[ActionName] methods in AdminMlThemeBuilderController.
    // It's generally better to centralize BO AJAX actions in the controller.
    // This file is more appropriate if you have frontend AJAX needs.

    default:
        $response = ['error' => true, 'message' => $module->l('Invalid action specified.', 'ajax-mlthemebuilder')];
        break;
}

// Output JSON response
header('Content-Type: application/json');
die(json_encode($response));
