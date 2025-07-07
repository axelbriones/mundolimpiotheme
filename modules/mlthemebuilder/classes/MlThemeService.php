<?php

class MlThemeService extends ObjectModel
{
    public $id_mltheme_service; // Primary key
    public $icon; // Class name for icon (e.g., "fa fa-truck") or path to image
    public $position;
    public $active = 1;
    public $date_add;
    public $date_upd;

    // Multilingual fields
    public $title;
    public $description;
    // public $link; // Optional: if services can link somewhere

    public static $definition = array(
        'table' => 'mltheme_services', // Updated table name
        'primary' => 'id_mltheme_service', // Updated primary key
        'multilang' => true,
        'multilang_shop' => true,
        'fields' => array(
            'icon' => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'size' => 255, 'required' => false), // Allow HTML for SVG icons or class names
            'position' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedInt'),
            'active' => array('type' => self::TYPE_BOOL, 'validate' => 'isBool'),
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDate', 'copy_post' => false),
            'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDate', 'copy_post' => false),

            // Multilingual fields
            'title' => array('type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isGenericName', 'required' => true, 'size' => 255),
            'description' => array('type' => self::TYPE_HTML, 'lang' => true, 'validate' => 'isCleanHtml', 'required' => false), // Allow some HTML
            // 'link' => array('type' => self::TYPE_STRING, 'lang' => true, 'validate' => 'isUrlOrEmpty', 'size' => 255, 'required' => false),
        ),
        'orderBy' => array('position' => 'ASC'),
    );

    public function __construct($id = null, $id_lang = null, $id_shop = null)
    {
        Shop::addTableAssociation(self::$definition['table'].'_lang', array('type' => 'fk_shop'));
        parent::__construct($id, $id_lang, $id_shop);
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
        // Assuming services are not shop specific in main table. If they are, add id_shop to WHERE.
        $sql = 'SELECT MAX(`position`) FROM `' . _DB_PREFIX_ . self::$definition['table'] . '`';
        // If main table has id_shop: $sql .= ' WHERE `id_shop` = '.(int)$id_shop;
        $position = DB::getInstance()->getValue($sql);
        return (is_numeric($position)) ? (int)$position : -1;
    }

    /**
     * Get active services for a given language and shop.
     * @param int $id_lang
     * @param int $id_shop
     * @param int|null $limit
     * @return array|false
     */
    public static function getActiveServices($id_lang, $id_shop, $limit = null)
    {
        $sql = new DbQuery();
        $sql->select('s.*, sl.title, sl.description');
        $sql->from(self::$definition['table'], 's');
        $sql->innerJoin(self::$definition['table'].'_lang', 'sl',
            's.`'.self::$definition['primary'].'` = sl.`'.self::$definition['primary'].'`
            AND sl.`id_lang` = ' . (int)$id_lang . ' AND sl.`id_shop` = ' . (int)$id_shop
        );
        $sql->where('s.active = 1');
        // If services are shop-specific in main table 's':
        // $sql->where('s.id_shop = '.(int)$id_shop);
        $sql->orderBy('s.position ASC');

        if ($limit !== null && (int)$limit > 0) {
            $sql->limit((int)$limit);
        }

        return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
    }

    /**
     * Get all services for a shop.
     * @param int|null $id_lang
     * @param bool|null $active
     * @param int|null $id_shop
     * @return array|false
     */
    public static function getServices($id_lang = null, $active = null, $id_shop = null)
    {
        $context = Context::getContext();
        $id_lang = $id_lang ?? (int)$context->language->id;
        $id_shop = $id_shop ?? (int)$context->shop->id;

        $sql = new DbQuery();
        $sql->select('s.*, sl.*');
        $sql->from(self::$definition['table'], 's');
        $sql->innerJoin(self::$definition['table'].'_lang', 'sl',
            's.`'.self::$definition['primary'].'` = sl.`'.self::$definition['primary'].'`
            AND sl.`id_lang` = ' . (int)$id_lang . ' AND sl.`id_shop` = ' . (int)$id_shop
        );

        if ($active !== null) {
            $sql->where('s.active = ' . (int)$active);
        }
        // If services are shop-specific in main table 's':
        // $sql->where('s.id_shop = '.(int)$id_shop);
        $sql->orderBy('s.position ASC');

        return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
    }

    /**
     * Updates the positions of multiple services.
     * @param array $positions_data Array of arrays, each containing 'id' and 'position'.
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
                    // If shop specific in main table: . ' AND `id_shop` = ' . (int)Context::getContext()->shop->id
                );
            }
        } catch (PrestaShopDatabaseException $e) {
             PrestaShopLogger::addLog("MlThemeService::updatePositions Error: " . $e->getMessage());
            return false;
        }
        return true;
    }

    /**
     * Reorders positions for all services (e.g., after a delete).
     * @param int|null $id_shop
     * @return bool
     */
    public static function reorderPositions($id_shop = null)
    {
        $id_shop = $id_shop ?? Context::getContext()->shop->id;
        $services = self::getServices(null, null, $id_shop);

        $position = 1;
        foreach ($services as $service_data) {
            Db::getInstance()->update(
                self::$definition['table'],
                ['position' => $position++, 'date_upd' => date('Y-m-d H:i:s')],
                '`'.self::$definition['primary'].'` = ' . (int)$service_data[self::$definition['primary']]
                // If shop specific in main table: . ' AND `id_shop` = ' . (int)$id_shop
            );
        }
        return true;
    }

    public function delete()
    {
        if (!parent::delete()) {
            return false;
        }
        self::reorderPositions($this->id_shop);
        return true;
    }

    public function getErrorMsg()
    {
        return $this->errors;
    }
}
