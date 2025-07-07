<?php
/**
 * MlThemeBuilder Upgrade Script for version 1.0.1
 *
 * Example:
 * - Add a new configuration field
 * - Modify a database table (add a column, etc.)
 * - Install a new hook
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

/**
 * Handles the upgrade to version 1.0.1 of the MlThemeBuilder module.
 *
 * @param MlThemeBuilder $module Instance of your module
 * @return bool True if upgrade is successful, false otherwise.
 */
function upgrade_module_1_0_1($module)
{
    // Example: Add a new configuration value
    // Configuration::updateValue('MLTHEME_NEW_FEATURE_ENABLED', 0);

    // Example: Add a new column to an existing table
    // $sql_addColumn = 'ALTER TABLE `' . _DB_PREFIX_ . 'mltheme_sections` ADD `new_column` VARCHAR(255) NULL DEFAULT NULL AFTER `config`;';
    // if (!Db::getInstance()->execute($sql_addColumn)) {
    //     // Log error or add to module errors
    //     $module->addError('Failed to add new_column to mltheme_sections table.');
    //     return false;
    // }

    // Example: Register a new hook
    // if (!$module->registerHook('displayCustomHookName')) {
    //     $module->addError('Failed to register hook displayCustomHookName.');
    //     return false;
    // }

    // Example: Update an existing tab name or icon
    // $id_tab = Tab::getIdFromClassName('AdminMlThemeBuilder');
    // if ($id_tab) {
    //     $tab = new Tab((int)$id_tab);
    //     if (Validate::isLoadedObject($tab)) {
    //         // $tab->icon = 'new-icon-class'; // Update icon
    //         // foreach (Language::getLanguages(false) as $lang) {
    //         //    $tab->name[(int)$lang['id_lang']] = $module->getTranslator()->trans('Theme Builder Enhanced', [], 'Modules.Mlthemebuilder.Admin');
    //         // }
    //         // if (!$tab->update()) {
    //         //     $module->addError('Failed to update tab name/icon.');
    //         //     return false;
    //         // }
    //     }
    // }

    // Always return true if all operations are successful.
    // If any operation fails, log the error and return false.
    // PrestaShop will then mark the upgrade as failed.

    // For this initial setup, if no specific DB changes or actions are needed for 1.0.1,
    // just returning true is fine.
    // It's good practice to have these files for future versions.

    // Clear cache after upgrade
    $module->clearCache('*');

    return true;
}
