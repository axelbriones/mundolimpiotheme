<?php

class MlThemeBrand extends ObjectModel
{
    public $id_mltheme_brand; // Primary key
    public $name;
    public $logo; // Filename of the logo image
    public $url;
    public $position;
    public $active = 1;
    public $date_add;
    public $date_upd;
    public $id_shop; // For shop association if brands are shop-specific

    public static $definition = array(
        'table' => 'mltheme_brands', // Updated table name
        'primary' => 'id_mltheme_brand', // Updated primary key
        'fields' => array(
            'name' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName', 'required' => true, 'size' => 255),
            'logo' => array('type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'size' => 255, 'required' => false), // Filename, not path
            'url' => array('type' => self::TYPE_STRING, 'validate' => 'isUrlOrEmpty', 'size' => 255, 'required' => false),
            'position' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedInt'),
            'active' => array('type' => self::TYPE_BOOL, 'validate' => 'isBool'),
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDate', 'copy_post' => false),
            'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDate', 'copy_post' => false),
            // 'id_shop' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true), // Uncomment if brands are shop-specific
        ),
        'orderBy' => array('position' => 'ASC'),
    );

    public function __construct($id = null, $id_lang = null, $id_shop = null)
    {
        // Shop::addTableAssociation(self::$definition['table'], array('type' => 'shop')); // If brands are shop-specific
        parent::__construct($id, $id_lang, $id_shop);
        // If not using multishop context for this ObjectModel directly, ensure id_shop is handled if needed.
        // if (!$this->id_shop && $id_shop) {
        //     $this->id_shop = $id_shop;
        // } elseif (!$this->id_shop) {
        //     $this->id_shop = Context::getContext()->shop->id;
        // }
    }

    public static function isUrlOrEmpty($url_string)
    {
        if (empty($url_string)) {
            return true;
        }
        return Validate::isAbsoluteUrl($url_string) || preg_match('/^(\/|#|mailto:|tel:)/', $url_string) || !preg_match('/[<>"\'\s]/', $url_string);
    }

    public function add($auto_date = true, $null_values = false)
    {
        // if (!$this->id_shop) $this->id_shop = Context::getContext()->shop->id; // Ensure shop ID
        if ($this->position <= 0) {
            $this->position = self::getHighestPosition($this->id_shop) + 1;
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
        $sql = 'SELECT MAX(`position`) FROM `' . _DB_PREFIX_ . self::$definition['table'] . '`';
        // If shop-specific: $sql .= ' WHERE `id_shop` = '.(int)$id_shop;
        $position = DB::getInstance()->getValue($sql);
        return (is_numeric($position)) ? (int)$position : -1;
    }

    /**
     * Get active brands for a shop.
     * @param int|null $id_shop
     * @param int|null $limit
     * @return array|false
     */
    public static function getActiveBrands($id_shop = null, $limit = null)
    {
        $id_shop = $id_shop ?? Context::getContext()->shop->id;
        $sql = new DbQuery();
        $sql->select('*');
        $sql->from(self::$definition['table']);
        $sql->where('active = 1');
        // If shop-specific: $sql->where('id_shop = '.(int)$id_shop);
        $sql->orderBy('position ASC');

        if ($limit !== null && (int)$limit > 0) {
            $sql->limit((int)$limit);
        }

        return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
    }

    /**
     * Get all brands for a shop.
     * @param bool|null $active
     * @param int|null $id_shop
     * @return array|false
     */
    public static function getBrands($active = null, $id_shop = null)
    {
        $id_shop = $id_shop ?? Context::getContext()->shop->id;
        $sql = new DbQuery();
        $sql->select('*');
        $sql->from(self::$definition['table']);

        if ($active !== null) {
            $sql->where('active = ' . (int)$active);
        }
        // If shop-specific: $sql->where('id_shop = '.(int)$id_shop); // Add this if uncommented id_shop field
        $sql->orderBy('position ASC');

        return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
    }

    public function delete()
    {
        // Delete associated logo file
        if ($this->logo) {
            $logo_path = _PS_MODULE_DIR_ . 'mlthemebuilder/views/img/brands/' . $this->logo;
            if (file_exists($logo_path)) {
                @unlink($logo_path);
            }
        }
        if (!parent::delete()) {
            return false;
        }
        self::reorderPositions($this->id_shop);
        return true;
    }

    /**
     * Updates the positions of multiple brands.
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
                    // If shop specific: . ' AND `id_shop` = ' . (int)Context::getContext()->shop->id
                );
            }
        } catch (PrestaShopDatabaseException $e) {
            PrestaShopLogger::addLog("MlThemeBrand::updatePositions Error: " . $e->getMessage());
            return false;
        }
        return true;
    }

    /**
     * Reorders positions for all brands (e.g., after a delete).
     * @param int|null $id_shop
     * @return bool
     */
    public static function reorderPositions($id_shop = null)
    {
        $id_shop = $id_shop ?? Context::getContext()->shop->id;
        $brands = self::getBrands(null, $id_shop);

        $position = 1;
        foreach ($brands as $brand_data) {
            Db::getInstance()->update(
                self::$definition['table'],
                ['position' => $position++, 'date_upd' => date('Y-m-d H:i:s')],
                '`'.self::$definition['primary'].'` = ' . (int)$brand_data[self::$definition['primary']]
                // If shop specific: . ' AND `id_shop` = ' . (int)$id_shop
            );
        }
        return true;
    }

    public function getErrorMsg()
    {
        return $this->errors;
    }
}
