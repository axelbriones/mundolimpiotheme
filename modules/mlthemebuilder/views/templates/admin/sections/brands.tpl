{* Configuration form for Brands Section *}
<input type="hidden" name="config[type]" value="brands">

{* Language tabs for multilingual fields *}
{if $languages|count > 1}
<div class="translations tabbable">
    <ul class="nav nav-tabs">
        {foreach from=$languages item=language}
            <li class="nav-item {if $language.id_lang == $current_language.id_lang}active{/if}">
                <a href="#brands_lang_{$language.id_lang|escape:'htmlall':'UTF-8'}" class="nav-link" data-toggle="tab">{$language.name|escape:'htmlall':'UTF-8'}</a>
            </li>
        {/foreach}
    </ul>
    <div class="tab-content">
{/if}
    {foreach from=$languages item=language}
        {assign var=id_lang value=$language.id_lang}
        <div class="tab-pane {if $id_lang == $current_language.id_lang}active{/if}" id="brands_lang_{$id_lang|escape:'htmlall':'UTF-8'}">
            <div class="form-group">
                <label class="control-label">{l s='Section Title' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="text" name="title[{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.titles[$id_lang]|default:''|escape:'htmlall':'UTF-8'}" placeholder="{l s='e.g., Our Partners' d='Modules.Mlthemebuilder.Admin'}">
            </div>
        </div>
    {/foreach}
{if $languages|count > 1}
    </div>
</div>
{/if}

<hr>
<h4>{l s='Slider Configuration' d='Modules.Mlthemebuilder.Admin'}</h4>

<div class="form-group">
    <label class="control-label">{l s='Animation Speed (duration for one full loop)' d='Modules.Mlthemebuilder.Admin'}</label>
    <div class="input-group">
        <input type="number" name="config[speed_brands]" class="form-control" value="{$section_data.config.speed_brands|default:30|escape:'htmlall':'UTF-8'}" min="5" max="120">
        <span class="input-group-addon">{l s='seconds' d='Modules.Mlthemebuilder.Admin'}</span>
    </div>
    <p class="help-block">{l s='Lower value means faster animation.' d='Modules.Mlthemebuilder.Admin'}</p>
</div>

<div class="form-group">
    <label class="control-label">{l s='Maximum Brands to Display' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="number" name="config[max_brands]" class="form-control" value="{$section_data.config.max_brands|default:0|escape:'htmlall':'UTF-8'}" min="0" max="50">
    <p class="help-block">{l s='Total number of brand logos to show in the slider. Leave empty or 0 for all active brands.' d='Modules.Mlthemebuilder.Admin'}</p>
</div>

<div class="form-group">
    <label class="control-label">{l s='Pause on Hover' d='Modules.Mlthemebuilder.Admin'}</label>
    <span class="switch prestashop-switch fixed-width-sm">
        <input type="radio" name="config[pause_on_hover_brands]" id="pause_on_hover_brands_on" value="1" {if $section_data.config.pause_on_hover_brands|default:true}checked="checked"{/if}>
        <label for="pause_on_hover_brands_on">{l s='Yes' d='Modules.Mlthemebuilder.Admin'}</label>
        <input type="radio" name="config[pause_on_hover_brands]" id="pause_on_hover_brands_off" value="0" {if !$section_data.config.pause_on_hover_brands|default:true}checked="checked"{/if}>
        <label for="pause_on_hover_brands_off">{l s='No' d='Modules.Mlthemebuilder.Admin'}</label>
        <a class="slide-button btn"></a>
    </span>
    <p class="help-block">{l s='Pause the slider animation when the mouse is over it.' d='Modules.Mlthemebuilder.Admin'}</p>
</div>

<div class="alert alert-info">
    <i class="icon-info-sign"></i>
    {l s='Brand logos and their links are managed globally under the "Manage Brands" tab in the module configuration.' d='Modules.Mlthemebuilder.Admin'}
    {l s='This section will display active brands based on their order.' d='Modules.Mlthemebuilder.Admin'}
</div>

<hr>
<h4>{l s='Appearance' d='Modules.Mlthemebuilder.Admin'}</h4>
<div class="form-group">
    <label class="control-label">{l s='Background Color' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="color" name="config[background_color_brands]" class="form-control color-picker" value="{$section_data.config.background_color_brands|default:'#f8f9fa'|escape:'htmlall':'UTF-8'}">
</div>

<div class="form-group">
    <label class="control-label">{l s='Logo Style' d='Modules.Mlthemebuilder.Admin'}</label>
    <select name="config[logo_style_brands]" class="form-control">
        <option value="grayscale_hover_color" {if $section_data.config.logo_style_brands|default:'grayscale_hover_color' == 'grayscale_hover_color'}selected{/if}>{l s='Grayscale, Color on Hover' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="color" {if $section_data.config.logo_style_brands|default:'' == 'color'}selected{/if}>{l s='Full Color' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="grayscale" {if $section_data.config.logo_style_brands|default:'' == 'grayscale'}selected{/if}>{l s='Always Grayscale' d='Modules.Mlthemebuilder.Admin'}</option>
    </select>
    <p class="help-block">{l s='Visual style for the brand logos.' d='Modules.Mlthemebuilder.Admin'}</p>
</div>

<div class="form-group">
    <label class="control-label">{l s='Logo Max Height' d='Modules.Mlthemebuilder.Admin'}</label>
    <div class="input-group">
        <input type="number" name="config[logo_max_height_brands]" class="form-control" value="{$section_data.config.logo_max_height_brands|default:60|escape:'htmlall':'UTF-8'}" min="20" max="150">
        <span class="input-group-addon">{l s='px' d='Modules.Mlthemebuilder.Admin'}</span>
    </div>
</div>

<div class="form-group">
    <label class="control-label">{l s='Custom CSS Class' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="text" name="config[custom_css_class]" class="form-control" value="{$section_data.config.custom_css_class|default:''|escape:'htmlall':'UTF-8'}">
</div>

<script type="text/javascript">
    $('#section-modal-form-content .nav-tabs a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
    $('#section-modal-form-content .nav-tabs li:first-child a').tab('show');
</script>
