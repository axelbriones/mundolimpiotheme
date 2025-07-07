-- SQL Schema for MlThemeBuilder Module

-- Table for theme sections
CREATE TABLE IF NOT EXISTS `PREFIX_mltheme_sections` (
    `id_mltheme_section` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL COMMENT 'Internal name for identification',
    `type` varchar(50) NOT NULL COMMENT 'Type of section (hero, products, etc.)',
    `position` int(11) NOT NULL DEFAULT 0,
    `active` tinyint(1) NOT NULL DEFAULT 1,
    `config` text COMMENT 'JSON configuration for the section',
    `date_add` datetime NOT NULL,
    `date_upd` datetime NOT NULL,
    -- `id_shop` int(11) unsigned NOT NULL DEFAULT 1, -- Uncomment if sections are shop-specific in main table
    PRIMARY KEY (`id_mltheme_section`)
    -- KEY `idx_id_shop` (`id_shop`) -- Uncomment if sections are shop-specific
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Language table for theme sections
CREATE TABLE IF NOT EXISTS `PREFIX_mltheme_sections_lang` (
    `id_mltheme_section` int(11) NOT NULL,
    `id_lang` int(11) NOT NULL,
    `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
    `title` varchar(255) DEFAULT NULL,
    `content` text DEFAULT NULL,
    `button_text` varchar(100) DEFAULT NULL,
    `button_link` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id_mltheme_section`, `id_lang`, `id_shop`)
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table for services
CREATE TABLE IF NOT EXISTS `PREFIX_mltheme_services` (
    `id_mltheme_service` int(11) NOT NULL AUTO_INCREMENT,
    `icon` varchar(255) DEFAULT NULL,
    `position` int(11) NOT NULL DEFAULT 0,
    `active` tinyint(1) NOT NULL DEFAULT 1,
    `date_add` datetime NOT NULL,
    `date_upd` datetime NOT NULL,
    -- `id_shop` int(11) unsigned NOT NULL DEFAULT 1, -- Uncomment if services are shop-specific
    PRIMARY KEY (`id_mltheme_service`)
    -- KEY `idx_id_shop` (`id_shop`) -- Uncomment if services are shop-specific
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Language table for services
CREATE TABLE IF NOT EXISTS `PREFIX_mltheme_services_lang` (
    `id_mltheme_service` int(11) NOT NULL,
    `id_lang` int(11) NOT NULL,
    `id_shop` int(11) unsigned NOT NULL DEFAULT 1,
    `title` varchar(255) DEFAULT NULL,
    `description` text DEFAULT NULL,
    PRIMARY KEY (`id_mltheme_service`, `id_lang`, `id_shop`)
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table for brands
CREATE TABLE IF NOT EXISTS `PREFIX_mltheme_brands` (
    `id_mltheme_brand` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `logo` varchar(255) DEFAULT NULL COMMENT 'Filename of the logo image',
    `url` varchar(255) DEFAULT NULL,
    `position` int(11) NOT NULL DEFAULT 0,
    `active` tinyint(1) NOT NULL DEFAULT 1,
    `date_add` datetime NOT NULL,
    `date_upd` datetime NOT NULL,
    -- `id_shop` int(11) unsigned NOT NULL DEFAULT 1, -- Uncomment if brands are shop-specific
    PRIMARY KEY (`id_mltheme_brand`)
    -- KEY `idx_id_shop` (`id_shop`) -- Uncomment if brands are shop-specific
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table for global module settings (alternative to PrestaShop Configuration table for complex/multiple settings)
CREATE TABLE IF NOT EXISTS `PREFIX_mltheme_settings` (
    `id_mltheme_setting` int(11) NOT NULL AUTO_INCREMENT,
    `id_shop_group` int(11) unsigned DEFAULT NULL, -- Use NULL for all groups
    `id_shop` int(11) unsigned DEFAULT NULL, -- Use NULL for all shops (within group or global)
    `name` varchar(255) NOT NULL COMMENT 'Setting key name',
    `value` longtext DEFAULT NULL COMMENT 'Setting value (can be JSON for complex data)',
    `date_add` datetime NOT NULL,
    `date_upd` datetime NOT NULL,
    PRIMARY KEY (`id_mltheme_setting`),
    UNIQUE KEY `idx_mltheme_setting_name_shop_group_shop` (`name`, `id_shop_group`, `id_shop`) -- Ensure unique setting per scope
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Default data insertion will be handled by the module's installDefaultData() method in PHP
-- This ensures multilingual data and ObjectModel relations are handled correctly.
-- Example:
-- INSERT INTO `PREFIX_mltheme_sections` (`name`, `type`, `position`, `active`, `config`, `date_add`, `date_upd`) VALUES
-- ('hero_main', 'hero', 1, 1, '{}', NOW(), NOW()),
-- ('services_overview', 'services', 2, 1, '{\"columns_services\":3}', NOW(), NOW());
-- ... and corresponding _lang table entries.

-- Note: ENGINE_TYPE will be replaced by PrestaShop with _MYSQL_ENGINE_
-- Note: PREFIX_ will be replaced by PrestaShop with the actual database prefix.
