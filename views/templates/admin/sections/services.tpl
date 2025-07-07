{* Configuration form for Services Section *}
<input type="hidden" name="config[type]" value="services">

{* Language tabs for multilingual fields *}
{if $languages|count > 1}
<div class="translations tabbable">
    <ul class="nav nav-tabs">
        {foreach from=$languages item=language}
            <li class="nav-item {if $language.id_lang == $current_language.id_lang}active{/if}">
                <a href="#services_lang_{$language.id_lang|escape:'htmlall':'UTF-8'}" class="nav-link" data-toggle="tab">{$language.name|escape:'htmlall':'UTF-8'}</a>
            </li>
        {/foreach}
    </ul>
    <div class="tab-content">
{/if}
    {foreach from=$languages item=language}
        {assign var=id_lang value=$language.id_lang}
        <div class="tab-pane {if $id_lang == $current_language.id_lang}active{/if}" id="services_lang_{$id_lang|escape:'htmlall':'UTF-8'}">
            <div class="form-group">
                <label class="control-label">{l s='Section Title' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="text" name="title[{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.titles[$id_lang]|default:''|escape:'htmlall':'UTF-8'}" placeholder="{l s='e.g., Our Services' d='Modules.Mlthemebuilder.Admin'}">
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Section Subtitle/Description' d='Modules.Mlthemebuilder.Admin'}</label>
                <textarea name="config[subtitle_services][{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" rows="3">{$section_data.config.subtitle_services[$id_lang]|default:''|escape:'htmlall':'UTF-8'}</textarea>
                <p class="help-block">{l s='Optional text displayed below the section title.' d='Modules.Mlthemebuilder.Admin'}</p>
            </div>
        </div>
    {/foreach}
{if $languages|count > 1}
    </div>
</div>
{/if}

<hr>
<h4>{l s='Layout & Content' d='Modules.Mlthemebuilder.Admin'}</h4>

<div class="form-group">
    <label class="control-label">{l s='Number of Columns' d='Modules.Mlthemebuilder.Admin'}</label>
    <select name="config[columns_services]" class="form-control">
        <option value="2" {if $section_data.config.columns_services|default:3 == 2}selected{/if}>2 {l s='Columns' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="3" {if $section_data.config.columns_services|default:3 == 3}selected{/if}>3 {l s='Columns' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="4" {if $section_data.config.columns_services|default:3 == 4}selected{/if}>4 {l s='Columns' d='Modules.Mlthemebuilder.Admin'}</option>
    </select>
    <p class="help-block">{l s='How many services to display per row.' d='Modules.Mlthemebuilder.Admin'}</p>
</div>

<div class="form-group">
    <label class="control-label">{l s='Maximum Services to Display' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="number" name="config[max_services]" class="form-control" value="{$section_data.config.max_services|default:6|escape:'htmlall':'UTF-8'}" min="1" max="20">
    <p class="help-block">{l s='Total number of services to show in this section. Leave empty or 0 for all active services.' d='Modules.Mlthemebuilder.Admin'}</p>
</div>

<div class="alert alert-info">
    <i class="icon-info-sign"></i>
    {l s='Services (icons, titles, descriptions) are managed globally under the "Manage Services" tab in the module configuration.' d='Modules.Mlthemebuilder.Admin'}
    {l s='This section will display active services based on their order.' d='Modules.Mlthemebuilder.Admin'}
</div>


<hr>
<h4>{l s='Appearance' d='Modules.Mlthemebuilder.Admin'}</h4>
<div class="form-group">
    <label class="control-label">{l s='Background Color' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="color" name="config[background_color_services]" class="form-control color-picker" value="{$section_data.config.background_color_services|default:'#f8f9fa'|escape:'htmlall':'UTF-8'}">
</div>

<div class="form-group">
    <label class="control-label">{l s='Service Card Style' d='Modules.Mlthemebuilder.Admin'}</label>
    <select name="config[card_style_services]" class="form-control">
        <option value="default" {if $section_data.config.card_style_services|default:'default' == 'default'}selected{/if}>{l s='Default (icon top, text below)' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="icon_left" {if $section_data.config.card_style_services|default:'' == 'icon_left'}selected{/if}>{l s='Icon Left, Text Right' d='Modules.Mlthemebuilder.Admin'}</option>
        {* Add more style options if implemented in CSS/front.tpl *}
    </select>
</div>

<div class="form-group">
    <label class="control-label">{l s='Custom CSS Class' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="text" name="config[custom_css_class]" class="form-control" value="{$section_data.config.custom_css_class|default:''|escape:'htmlall':'UTF-8'}" placeholder="{l s='e.g., my-custom-services-style' d='Modules.Mlthemebuilder.Admin'}">
</div>

{* Initialize Bootstrap tabs if they are part of the loaded form *}
<script type="text/javascript">
    $('#section-modal-form-content .nav-tabs a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
    $('#section-modal-form-content .nav-tabs li:first-child a').tab('show');
</script>
