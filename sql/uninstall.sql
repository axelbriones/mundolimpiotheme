-- SQL Uninstall Script for MlThemeBuilder Module

-- Drop language table for theme sections
DROP TABLE IF EXISTS `PREFIX_mltheme_sections_lang`;

-- Drop main table for theme sections
DROP TABLE IF EXISTS `PREFIX_mltheme_sections`;

-- Drop language table for services
DROP TABLE IF EXISTS `PREFIX_mltheme_services_lang`;

-- Drop main table for services
DROP TABLE IF EXISTS `PREFIX_mltheme_services`;

-- Drop table for brands
DROP TABLE IF EXISTS `PREFIX_mltheme_brands`;

-- Drop table for global module settings
DROP TABLE IF EXISTS `PREFIX_mltheme_settings`;

-- Note: Configuration values stored in PrestaShop's `ps_configuration` table
-- are typically removed within the module's uninstall() method in PHP using Configuration::deleteByName().
-- Example:
-- DELETE FROM `PREFIX_configuration` WHERE `name` LIKE 'MLTHEME_%';

-- It's generally safer to let the PHP uninstall method handle Configuration table cleanup.
