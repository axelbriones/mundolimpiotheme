<?php

class MlThemeSetting extends ObjectModel
{
    public $id_mltheme_setting;
    public $id_shop_group;
    public $id_shop;
    public $name;
    public $value;
    public $date_add;
    public $date_upd;

    public static $definition = array(
        'table' => 'mltheme_settings',
        'primary' => 'id_mltheme_setting',
        'fields' => array(
            'id_shop_group' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'allow_null' => true),
            'id_shop' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'allow_null' => true),
            'name' => array('type' => self::TYPE_STRING, 'validate' => 'isConfigName', 'required' => true, 'size' => 255),
            'value' => array('type' => self::TYPE_HTML, 'validate' => 'isAnything', 'allow_null' => true), // Store as HTML/Text, JSON encode/decode in getter/setter if complex
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDate'),
            'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDate'),
        ),
    );

    /**
     * Get a specific setting value.
     *
     * @param string $name Setting name
     * @param int|null $id_shop Shop ID (null for current context)
     * @param mixed $default Default value if not found
     * @return mixed Setting value or default
     */
    public static function getSettingValue($name, $id_shop = null, $default = null)
    {
        if ($id_shop === null) {
            $id_shop = Context::getContext()->shop->id;
        }
        $id_shop_group = Context::getContext()->shop->id_shop_group;

        $sql = new DbQuery();
        $sql->select('value');
        $sql->from(self::$definition['table']);
        $sql->where('name = \'' . pSQL($name) . '\'');
        $sql->where('(`id_shop` = ' . (int)$id_shop . ' OR `id_shop` IS NULL OR `id_shop` = 0)'); // Shop specific or global for shop
        $sql->where('(`id_shop_group` = ' . (int)$id_shop_group . ' OR `id_shop_group` IS NULL OR `id_shop_group` = 0)'); // Group specific or global for group
        $sql->orderBy('`id_shop` DESC, `id_shop_group` DESC'); // Prioritize shop-specific, then group-specific

        $result = Db::getInstance(_PS_USE_SQL_SLAVE_)->getValue($sql);

        if ($result === false) { // Db::getValue returns false if not found
            return $default;
        }

        // Attempt to decode if it's JSON, otherwise return as is
        $decoded = json_decode($result, true);
        return (json_last_error() === JSON_ERROR_NONE) ? $decoded : $result;
    }

    /**
     * Update or create a setting value.
     *
     * @param string $name Setting name
     * @param mixed $value Setting value
     * @param int|null $id_shop Shop ID (null for current context, 0 for all shops in group, specific ID for specific shop)
     * @param int|null $id_shop_group Shop Group ID (null for current context, 0 for all groups)
     * @return bool Success or failure
     */
    public static function updateSettingValue($name, $value, $id_shop = null, $id_shop_group = null)
    {
        if ($id_shop === null && Context::getContext()->shop->id) {
            $id_shop = Context::getContext()->shop->id;
        }
        if ($id_shop_group === null && Context::getContext()->shop->id_shop_group) {
            $id_shop_group = Context::getContext()->shop->id_shop_group;
        }

        // If $id_shop is 0, it means apply to all shops in the group (or all shops if group is also 0/null)
        // If $id_shop is specific, $id_shop_group should ideally match or be the parent.

        $setting_id = self::getSettingIdByName($name, $id_shop, $id_shop_group);

        $setting = new MlThemeSetting($setting_id);
        $setting->name = $name;

        // If value is an array or object, JSON encode it
        if (is_array($value) || is_object($value)) {
            $setting->value = json_encode($value);
        } else {
            $setting->value = $value;
        }

        $setting->id_shop = (int)$id_shop; // Ensure it's int, 0 for global within group
        $setting->id_shop_group = (int)$id_shop_group; // Ensure it's int, 0 for truly global

        if ($setting_id) { // Update existing
            return $setting->update();
        } else { // Create new
            $setting->date_add = date('Y-m-d H:i:s');
            return $setting->add();
        }
    }

    /**
     * Get multiple settings.
     * @param array $keys Array of setting names
     * @param int|null $id_shop
     * @param array $defaults Associative array of default values
     * @return array Associative array of settings
     */
    public static function getMultipleSettings(array $keys, $id_shop = null, array $defaults = [])
    {
        $settings = [];
        foreach ($keys as $key) {
            $default_value = isset($defaults[$key]) ? $defaults[$key] : null;
            // Try to infer boolean default for specific keys, otherwise null
            if (in_array($key, ['enable_animations', 'enable_lazy_loading', 'enable_section_cache'])) {
                $default_value = $defaults[$key] ?? true;
            } elseif (in_array($key, ['enable_dark_mode'])) {
                 $default_value = $defaults[$key] ?? false;
            }
            $settings[$key] = self::getSettingValue($key, $id_shop, $default_value);
        }
        return $settings;
    }


    /**
     * Get the ID of a setting by its name and shop context.
     * Helper function for updateSettingValue.
     */
    private static function getSettingIdByName($name, $id_shop = null, $id_shop_group = null)
    {
        $sql = new DbQuery();
        $sql->select(self::$definition['primary']);
        $sql->from(self::$definition['table']);
        $sql->where('name = \'' . pSQL($name) . '\'');

        if ($id_shop !== null) {
            $sql->where('id_shop = ' . (int)$id_shop);
        } else {
            $sql->where('id_shop IS NULL OR id_shop = 0');
        }

        if ($id_shop_group !== null) {
            $sql->where('id_shop_group = ' . (int)$id_shop_group);
        } else {
            $sql->where('id_shop_group IS NULL OR id_shop_group = 0');
        }

        return Db::getInstance(_PS_USE_SQL_SLAVE_)->getValue($sql);
    }

    /**
     * Delete a setting by name.
     * @param string $name Setting name
     * @param int|null $id_shop
     * @param int|null $id_shop_group
     * @return bool
     */
    public static function deleteSettingValue($name, $id_shop = null, $id_shop_group = null)
    {
        $where_clauses = ['name = \'' . pSQL($name) . '\''];
        if ($id_shop !== null) {
            $where_clauses[] = 'id_shop = ' . (int)$id_shop;
        }
        if ($id_shop_group !== null) {
            $where_clauses[] = 'id_shop_group = ' . (int)$id_shop_group;
        }
        return Db::getInstance()->delete(self::$definition['table'], implode(' AND ', $where_clauses));
    }
}
