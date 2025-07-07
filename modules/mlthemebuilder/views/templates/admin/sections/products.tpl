{* Configuration form for Products Section *}
<input type="hidden" name="config[type]" value="products">

{* Language tabs for multilingual fields *}
{if $languages|count > 1}
<div class="translations tabbable">
    <ul class="nav nav-tabs">
        {foreach from=$languages item=language}
            <li class="nav-item {if $language.id_lang == $current_language.id_lang}active{/if}">
                <a href="#products_lang_{$language.id_lang|escape:'htmlall':'UTF-8'}" class="nav-link" data-toggle="tab">{$language.name|escape:'htmlall':'UTF-8'}</a>
            </li>
        {/foreach}
    </ul>
    <div class="tab-content">
{/if}
    {foreach from=$languages item=language}
        {assign var=id_lang value=$language.id_lang}
        <div class="tab-pane {if $id_lang == $current_language.id_lang}active{/if}" id="products_lang_{$id_lang|escape:'htmlall':'UTF-8'}">
            <div class="form-group">
                <label class="control-label">{l s='Section Title' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="text" name="title[{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.titles[$id_lang]|default:''|escape:'htmlall':'UTF-8'}" placeholder="{l s='e.g., Our Products' d='Modules.Mlthemebuilder.Admin'}">
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Section Subtitle/Description' d='Modules.Mlthemebuilder.Admin'}</label>
                <textarea name="config[subtitle_products][{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" rows="3">{$section_data.config.subtitle_products[$id_lang]|default:''|escape:'htmlall':'UTF-8'}</textarea>
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Button Text (optional)' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="text" name="button_text[{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.button_texts[$id_lang]|default:''|escape:'htmlall':'UTF-8'}" placeholder="{l s='e.g., View All Products' d='Modules.Mlthemebuilder.Admin'}">
                <p class="help-block">{l s='If set, a button will appear below the products/categories, linking to the "Button Link".' d='Modules.Mlthemebuilder.Admin'}</p>
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Button Link (optional)' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="text" name="button_link[{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.button_links[$id_lang]|default:'#'|escape:'htmlall':'UTF-8'}" placeholder="{$link->getPageLink('products', true)|escape:'htmlall':'UTF-8'}">
            </div>
        </div>
    {/foreach}
{if $languages|count > 1}
    </div>
</div>
{/if}

<hr>
<h4>{l s='Content & Layout' d='Modules.Mlthemebuilder.Admin'}</h4>

<div class="form-group">
    <label class="control-label">{l s='Display Type' d='Modules.Mlthemebuilder.Admin'}</label>
    <select name="config[display_type_products]" id="display_type_products" class="form-control">
        <option value="featured" {if $section_data.config.display_type_products|default:'featured' == 'featured'}selected{/if}>{l s='Featured Products (On Sale / New)' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="new" {if $section_data.config.display_type_products|default:'' == 'new'}selected{/if}>{l s='New Products' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="bestsellers" {if $section_data.config.display_type_products|default:'' == 'bestsellers'}selected{/if}>{l s='Best Sellers' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="category" {if $section_data.config.display_type_products|default:'' == 'category'}selected{/if}>{l s='Products from a Specific Category' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="categories" {if $section_data.config.display_type_products|default:'' == 'categories'}selected{/if}>{l s='List of Categories' d='Modules.Mlthemebuilder.Admin'}</option>
    </select>
</div>

<div id="product_options_products" class="product-type-option" {if $section_data.config.display_type_products|default:'featured' == 'categories'}style="display:none;"{/if}>
    <div class="form-group">
        <label class="control-label">{l s='Number of Products' d='Modules.Mlthemebuilder.Admin'}</label>
        <input type="number" name="config[num_products]" class="form-control" value="{$section_data.config.num_products|default:8|escape:'htmlall':'UTF-8'}" min="1" max="24">
    </div>
</div>

<div id="category_options_products" class="product-type-option" {if $section_data.config.display_type_products|default:'featured' != 'category'}style="display:none;"{/if}>
    <div class="form-group">
        <label class="control-label">{l s='Select Category' d='Modules.Mlthemebuilder.Admin'}</label>
        <select name="config[id_category_products]" class="form-control">
            {if isset($categories_for_select) && $categories_for_select}
                {foreach from=$categories_for_select item=cat}
                    <option value="{$cat.id_category|escape:'htmlall':'UTF-8'}" {if $section_data.config.id_category_products|default:0 == $cat.id_category}selected{/if}>
                        {$cat.name|escape:'htmlall':'UTF-8'}
                    </option>
                {/foreach}
            {else}
                 <option value="0">{l s='No categories found' d='Modules.Mlthemebuilder.Admin'}</option>
            {/if}
        </select>
    </div>
</div>

<div id="categories_list_options_products" class="product-type-option" {if $section_data.config.display_type_products|default:'featured' != 'categories'}style="display:none;"{/if}>
    <div class="form-group">
        <label class="control-label">{l s='Number of Columns (Categories)' d='Modules.Mlthemebuilder.Admin'}</label>
        <select name="config[columns_categories]" class="form-control">
            <option value="2" {if $section_data.config.columns_categories|default:3 == 2}selected{/if}>2 {l s='Columns' d='Modules.Mlthemebuilder.Admin'}</option>
            <option value="3" {if $section_data.config.columns_categories|default:3 == 3}selected{/if}>3 {l s='Columns' d='Modules.Mlthemebuilder.Admin'}</option>
            <option value="4" {if $section_data.config.columns_categories|default:3 == 4}selected{/if}>4 {l s='Columns' d='Modules.Mlthemebuilder.Admin'}</option>
        </select>
    </div>
    <div class="form-group">
        <label class="control-label">{l s='Show Subcategories' d='Modules.Mlthemebuilder.Admin'}</label>
        <span class="switch prestashop-switch fixed-width-sm">
            <input type="radio" name="config[show_subcategories_products]" id="show_subcategories_products_on" value="1" {if $section_data.config.show_subcategories_products|default:false}checked="checked"{/if}>
            <label for="show_subcategories_products_on">{l s='Yes' d='Modules.Mlthemebuilder.Admin'}</label>
            <input type="radio" name="config[show_subcategories_products]" id="show_subcategories_products_off" value="0" {if !$section_data.config.show_subcategories_products|default:false}checked="checked"{/if}>
            <label for="show_subcategories_products_off">{l s='No' d='Modules.Mlthemebuilder.Admin'}</label>
            <a class="slide-button btn"></a>
        </span>
    </div>
     <div class="form-group">
        <label class="control-label">{l s='Max Subcategories to Show' d='Modules.Mlthemebuilder.Admin'}</label>
        <input type="number" name="config[max_subcategories_products]" class="form-control" value="{$section_data.config.max_subcategories_products|default:3|escape:'htmlall':'UTF-8'}" min="0" max="10">
         <p class="help-block">{l s='0 for all.' d='Modules.Mlthemebuilder.Admin'}</p>
    </div>
</div>


<hr>
<h4>{l s='Appearance' d='Modules.Mlthemebuilder.Admin'}</h4>
<div class="form-group">
    <label class="control-label">{l s='Background Color' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="color" name="config[background_color_products]" class="form-control color-picker" value="{$section_data.config.background_color_products|default:'#ffffff'|escape:'htmlall':'UTF-8'}">
</div>
<div class="form-group">
    <label class="control-label">{l s='Product Card Style' d='Modules.Mlthemebuilder.Admin'}</label>
    <select name="config[card_style_products]" class="form-control">
        <option value="default" {if $section_data.config.card_style_products|default:'default' == 'default'}selected{/if}>{l s='Default (Theme defined)' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="minimal" {if $section_data.config.card_style_products|default:'' == 'minimal'}selected{/if}>{l s='Minimal' d='Modules.Mlthemebuilder.Admin'}</option>
        {* Add more style options if implemented *}
    </select>
</div>

<div class="form-group">
    <label class="control-label">{l s='Custom CSS Class' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="text" name="config[custom_css_class]" class="form-control" value="{$section_data.config.custom_css_class|default:''|escape:'htmlall':'UTF-8'}">
</div>

<script type="text/javascript">
    $(document).ready(function() {
        function toggleProductOptions() {
            var selectedType = $('#display_type_products').val();
            $('.product-type-option').hide(); // Hide all options first
            if (selectedType === 'category') {
                $('#category_options_products').show();
                $('#product_options_products').show(); // Number of products still relevant
            } else if (selectedType === 'categories') {
                $('#categories_list_options_products').show();
            } else if (selectedType === 'featured' || selectedType === 'new' || selectedType === 'bestsellers') {
                 $('#product_options_products').show();
            }
        }
        $('#display_type_products').on('change', toggleProductOptions);
        toggleProductOptions(); // Initial call

        $('#section-modal-form-content .nav-tabs a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        });
         $('#section-modal-form-content .nav-tabs li:first-child a').tab('show');
    });
</script>
