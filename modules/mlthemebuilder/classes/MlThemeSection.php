<?php

class MlThemeSection extends ObjectModel
{
    public $id_mltheme_section; // Primary key
    public $name; // Internal name (e.g., "hero_slider")
    public $type; // Type of section (e.g., "hero", "products", "banner")
    public $position;
    public $active = 1;
    public $config; // JSON string for specific section configurations
    public $date_add;
    public $date_upd;

    // Multilingual fields
    public $title;       // e.g., "Our Amazing Products"
    public $content;     // e.g., "Check out this amazing selection..."
    public $button_text; // e.g., "Shop Now"
    public $button_link; // e.g., URL or route

    public static $definition = array(
        'table' => 'mltheme_sections', // Updated table name
        'primary' => 'id_mltheme_section', // Updated primary key
        'multilang' => true,
        'multilang_shop' => true, // Data can be different per shop for multilingual fields
        'fields' => array(
            'name' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName', 'required' => true, 'size' => 255, 'db_comment' => 'Internal name for identification'),
            'type' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName', 'required' => true, 'size' => 50, 'db_comment' => 'Type of section'),
            'position' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedInt'),
            'active' => array('type' => self::TYPE_BOOL, 'validate' => 'isBool'),
            'config' => array('type' => self::TYPE_HTML, 'validate' => 'isJson', 'db_comment' => 'JSON configuration for the section'), // Stored as JSON
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDate', 'copy_post' => false),
            'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDate', 'copy_post' => false),

            // Multilang fields
            'title' => array('type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isCleanHtml', 'size' => 255, 'required' => false),
            'content' => array('type' => self::TYPE_HTML, 'lang' => true, 'validate' => 'isCleanHtml', 'required' => false), // Allow some HTML
            'button_text' => array('type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isCleanHtml', 'size' => 100, 'required' => false),
            'button_link' => array('type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isUrlOrEmpty', 'size' => 255, 'required' => false),
        ),
        'orderBy' => array('position' => 'ASC'),
    );

    public function __construct($id = null, $id_lang = null, $id_shop = null)
    {
        Shop::addTableAssociation(self::$definition['table'].'_lang', array('type' => 'fk_shop'));
        parent::__construct($id, $id_lang, $id_shop);
    }

    // Custom validation method for URLs or empty strings, or simple relative paths
    public static function isUrlOrEmpty($url)
    {
        if (empty($url)) {
            return true;
        }
        // Allow absolute URLs, root-relative, page-relative, or anchor links
        return Validate::isAbsoluteUrl($url) || preg_match('/^(\/|#|[a-zA-Z0-9_-]+)/', $url);
    }

    public function add($auto_date = true, $null_values = false)
    {
        if ($this->position <= 0) {
            $this->position = self::getHighestPosition($this->id_shop ?? Context::getContext()->shop->id) + 1;
        }
        if ($auto_date) {
            $this->date_add = date('Y-m-d H:i:s');
            $this->date_upd = date('Y-m-d H:i:s');
        }
        return parent::add($auto_date, $null_values);
    }

    public function update($null_values = false)
    {
        $this->date_upd = date('Y-m-d H:i:s');
        return parent::update($null_values);
    }

    public static function getHighestPosition($id_shop = null)
    {
        $id_shop = $id_shop ?? Context::getContext()->shop->id;
        // Assuming sections are not shop specific in the main table, but lang table is.
        // If sections are shop-specific, add a where clause for id_shop.
        $sql = 'SELECT MAX(`position`) FROM `' . _DB_PREFIX_ . self::$definition['table'] . '`';
        // If main table has id_shop: $sql .= ' WHERE `id_shop` = '.(int)$id_shop;
        $position = DB::getInstance()->getValue($sql);
        return (is_numeric($position)) ? (int)$position : -1;
    }


    /**
     * Get all sections for a shop, ordered by position.
     * @param bool|null $active Filter by active status
     * @param int|null $id_lang Language ID
     * @param int|null $id_shop Shop ID
     * @return array|false
     */
    public static function getSections($active = null, $id_lang = null, $id_shop = null)
    {
        $context = Context::getContext();
        $id_lang = $id_lang ?? (int)$context->language->id;
        $id_shop = $id_shop ?? (int)$context->shop->id;

        $sql = new DbQuery();
        $sql->select('s.*, sl.*'); // Select all from both section and its lang table
        $sql->from(self::$definition['table'], 's');
        $sql->innerJoin(self::$definition['table'].'_lang', 'sl',
            's.`'.self::$definition['primary'].'` = sl.`'.self::$definition['primary'].'`
            AND sl.`id_lang` = ' . (int)$id_lang . ' AND sl.`id_shop` = ' . (int)$id_shop
        );

        if ($active !== null) {
            $sql->where('s.active = ' . (int)$active);
        }
        // If sections are shop-specific in the main table 's':
        // $sql->where('s.id_shop = '.(int)$id_shop);

        $sql->orderBy('s.position ASC');

        return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
    }

    /**
     * Get sections by position, typically for front office display.
     * @param bool|null $active
     * @param int|null $id_lang
     * @param int|null $id_shop
     * @return array
     */
    public static function getSectionsByPosition($active = null, $id_lang = null, $id_shop = null)
    {
        // This method is essentially the same as getSections with current parameters.
        // Kept for compatibility if specific logic was intended.
        return self::getSections($active, $id_lang, $id_shop);
    }


    /**
     * Updates the positions of multiple sections.
     * @param array $positions Array of arrays, each containing 'id' and 'position'.
     * @return bool True on success, false on failure.
     */
    public static function updatePositions($positions_data)
    {
        if (!is_array($positions_data)) {
            return false;
        }
        $db = Db::getInstance();
        try {
            foreach ($positions_data as $item) {
                if (!isset($item['id']) || !isset($item['position'])) {
                    continue;
                }
                $db->update(
                    self::$definition['table'],
                    array('position' => (int)$item['position'], 'date_upd' => date('Y-m-d H:i:s')),
                    '`'.self::$definition['primary'].'` = ' . (int)$item['id']
                    // If sections are shop-specific, add shop ID to where clause:
                    // . ' AND `id_shop` = ' . (int)Context::getContext()->shop->id
                );
            }
        } catch (PrestaShopDatabaseException $e) {
            PrestaShopLogger::addLog("MlThemeSection::updatePositions Error: " . $e->getMessage());
            return false;
        }
        return true;
    }

    /**
     * Reorders positions for all sections (e.g., after a delete).
     * @param int|null $id_shop
     * @return bool
     */
    public static function reorderPositions($id_shop = null)
    {
        $id_shop = $id_shop ?? Context::getContext()->shop->id;
        $sections = self::getSections(null, null, $id_shop); // Get all sections for the shop, ordered by position

        $position = 1;
        foreach ($sections as $section_data) {
            Db::getInstance()->update(
                self::$definition['table'],
                ['position' => $position++, 'date_upd' => date('Y-m-d H:i:s')],
                '`'.self::$definition['primary'].'` = ' . (int)$section_data[self::$definition['primary']]
                // If shop specific in main table: . ' AND `id_shop` = ' . (int)$id_shop
            );
        }
        return true;
    }

    /**
     * Get a section ID by its internal name.
     * @param string $name Internal name of the section.
     * @param int|null $id_shop Shop ID.
     * @return int|false Section ID or false if not found.
     */
    public static function getIdByName($name, $id_shop = null)
    {
        $id_shop = $id_shop ?? Context::getContext()->shop->id;
        $sql = new DbQuery();
        $sql->select('s.`'.self::$definition['primary'].'`');
        $sql->from(self::$definition['table'], 's');
        $sql->where('s.`name` = \'' . pSQL($name) . '\'');
        // If sections are shop-specific in the main table 's':
        // $sql->where('s.id_shop = '.(int)$id_shop);

        return Db::getInstance(_PS_USE_SQL_SLAVE_)->getValue($sql);
    }


    /**
     * Deletes a section and its related data (lang entries).
     * Also handles file deletions if config contains image paths.
     * @return bool
     */
    public function delete()
    {
        // Example: Delete associated images if stored in module specific folders
        // $config = json_decode($this->config, true);
        // if ($config && isset($config['image_hero']) && $config['image_hero']) {
        //     $image_path = _PS_MODULE_DIR_ . 'mlthemebuilder/views/img/sections/' . $config['image_hero'];
        //     if (file_exists($image_path)) @unlink($image_path);
        // }
        // Similar for other image fields in config across section types.

        if (!parent::delete()) {
            return false;
        }
        // After successful delete, reorder positions
        self::reorderPositions($this->id_shop);
        return true;
    }

    /**
     * Duplicates a section.
     * @return MlThemeSection|false The new duplicated section object or false on failure.
     */
    public function duplicate()
    {
        $new_section = new MlThemeSection(null, null, $this->id_shop); // Use current object's shop context
        foreach (self::$definition['fields'] as $field_name => $field_def) {
            if (property_exists($this, $field_name) && $field_name != $this->def['primary']) {
                 if ($field_name === 'active') {
                    $new_section->$field_name = 0; // Duplicates are inactive by default
                } elseif (isset($field_def['lang']) && $field_def['lang']) {
                    // Copy multilingual fields for all languages
                    foreach (Language::getIDs(false) as $id_lang) {
                        if (isset($this->{$field_name}[$id_lang])) {
                            $new_section->{$field_name}[$id_lang] = $this->{$field_name}[$id_lang];
                        }
                    }
                } else {
                    $new_section->$field_name = $this->$field_name;
                }
            }
        }

        // Modify name to indicate it's a copy
        $new_section->name = $this->name . '_copy_' . time();
        foreach (Language::getIDs(false) as $id_lang) {
             if (isset($new_section->title[$id_lang])) {
                $new_section->title[$id_lang] .= ' (' . MlThemeBuilder::getPsInstance()->l('Copy', 'AdminMlThemeBuilderController') . ')';
             } else {
                 $new_section->title[$id_lang] = $new_section->name . ' (' . MlThemeBuilder::getPsInstance()->l('Copy', 'AdminMlThemeBuilderController') . ')';
             }
        }

        $new_section->position = self::getHighestPosition($this->id_shop) + 1;
        // date_add and date_upd will be set by add() method

        if ($new_section->add()) {
            return $new_section;
        }
        return false;
    }

    /**
     * Get error messages.
     * @return array
     */
    public function getErrorMsg()
    {
        return $this->errors;
    }
}
