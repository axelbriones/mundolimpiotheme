{* Configuration form for Contact Section *}
<input type="hidden" name="config[type]" value="contact">

{* Language tabs for multilingual fields *}
{if $languages|count > 1}
<div class="translations tabbable">
    <ul class="nav nav-tabs">
        {foreach from=$languages item=language}
            <li class="nav-item {if $language.id_lang == $current_language.id_lang}active{/if}">
                <a href="#contact_lang_{$language.id_lang|escape:'htmlall':'UTF-8'}" class="nav-link" data-toggle="tab">{$language.name|escape:'htmlall':'UTF-8'}</a>
            </li>
        {/foreach}
    </ul>
    <div class="tab-content">
{/if}
    {foreach from=$languages item=language}
        {assign var=id_lang value=$language.id_lang}
        <div class="tab-pane {if $id_lang == $current_language.id_lang}active{/if}" id="contact_lang_{$id_lang|escape:'htmlall':'UTF-8'}">
            <div class="form-group">
                <label class="control-label">{l s='Section Title' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="text" name="title[{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.titles[$id_lang]|default:''|escape:'htmlall':'UTF-8'}">
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Address' d='Modules.Mlthemebuilder.Admin'}</label>
                <textarea name="config[address_contact][{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" rows="2">{$section_data.config.address_contact[$id_lang]|default:''|escape:'htmlall':'UTF-8'}</textarea>
                <p class="help-block">{l s='Shop address. Supports multiple lines.' d='Modules.Mlthemebuilder.Admin'}</p>
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Phone Number' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="text" name="config[phone_contact][{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.config.phone_contact[$id_lang]|default:''|escape:'htmlall':'UTF-8'}">
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Email Address' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="email" name="config[email_contact][{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.config.email_contact[$id_lang]|default:''|escape:'htmlall':'UTF-8'}">
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Opening Hours' d='Modules.Mlthemebuilder.Admin'}</label>
                <textarea name="config[hours_contact][{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" rows="3">{$section_data.config.hours_contact[$id_lang]|default:''|escape:'htmlall':'UTF-8'}</textarea>
                <p class="help-block">{l s='e.g., Mon-Fri: 9am-5pm, Sat: 10am-2pm. Supports multiple lines.' d='Modules.Mlthemebuilder.Admin'}</p>
            </div>
        </div>
    {/foreach}
{if $languages|count > 1}
    </div>
</div>
{/if}

<hr>
<h4>{l s='Features' d='Modules.Mlthemebuilder.Admin'}</h4>
<div class="form-group">
    <label class="control-label">{l s='Show Contact Form' d='Modules.Mlthemebuilder.Admin'}</label>
    <span class="switch prestashop-switch fixed-width-sm">
        <input type="radio" name="config[show_form_contact]" id="show_form_contact_on" value="1" {if $section_data.config.show_form_contact|default:true}checked="checked"{/if}>
        <label for="show_form_contact_on">{l s='Yes' d='Modules.Mlthemebuilder.Admin'}</label>
        <input type="radio" name="config[show_form_contact]" id="show_form_contact_off" value="0" {if !$section_data.config.show_form_contact|default:true}checked="checked"{/if}>
        <label for="show_form_contact_off">{l s='No' d='Modules.Mlthemebuilder.Admin'}</label>
        <a class="slide-button btn"></a>
    </span>
</div>

<div class="form-group">
    <label class="control-label">{l s='Enable CAPTCHA on Form (if available)' d='Modules.Mlthemebuilder.Admin'}</label>
    <span class="switch prestashop-switch fixed-width-sm">
        <input type="radio" name="config[enable_captcha_contact]" id="enable_captcha_contact_on" value="1" {if $section_data.config.enable_captcha_contact|default:false}checked="checked"{/if}>
        <label for="enable_captcha_contact_on">{l s='Yes' d='Modules.Mlthemebuilder.Admin'}</label>
        <input type="radio" name="config[enable_captcha_contact]" id="enable_captcha_contact_off" value="0" {if !$section_data.config.enable_captcha_contact|default:false}checked="checked"{/if}>
        <label for="enable_captcha_contact_off">{l s='No' d='Modules.Mlthemebuilder.Admin'}</label>
        <a class="slide-button btn"></a>
    </span>
    <p class="help-block">{l s='Requires a CAPTCHA module to be installed and configured, or manual integration.' d='Modules.Mlthemebuilder.Admin'}</p>
</div>

<div class="form-group">
    <label class="control-label">{l s='Show Map' d='Modules.Mlthemebuilder.Admin'}</label>
    <span class="switch prestashop-switch fixed-width-sm">
        <input type="radio" name="config[show_map_contact]" id="show_map_contact_on" value="1" {if $section_data.config.show_map_contact|default:false}checked="checked"{/if}>
        <label for="show_map_contact_on">{l s='Yes' d='Modules.Mlthemebuilder.Admin'}</label>
        <input type="radio" name="config[show_map_contact]" id="show_map_contact_off" value="0" {if !$section_data.config.show_map_contact|default:false}checked="checked"{/if}>
        <label for="show_map_contact_off">{l s='No' d='Modules.Mlthemebuilder.Admin'}</label>
        <a class="slide-button btn"></a>
    </span>
</div>
<div class="form-group" id="map_embed_code_group" {if !$section_data.config.show_map_contact|default:false}style="display:none;"{/if}>
    <label class="control-label">{l s='Map Embed Code (HTML)' d='Modules.Mlthemebuilder.Admin'}</label>
    <textarea name="config[map_embed_code_contact]" class="form-control" rows="4" placeholder="{l s='e.g., <iframe src=...></iframe> from Google Maps' d='Modules.Mlthemebuilder.Admin'}">{$section_data.config.map_embed_code_contact|default:''|escape:'htmlall':'UTF-8'}</textarea>
    <p class="help-block">{l s='Paste the HTML embed code for your map (e.g., from Google Maps).' d='Modules.Mlthemebuilder.Admin'}</p>
</div>

<hr>
<h4>{l s='Appearance' d='Modules.Mlthemebuilder.Admin'}</h4>
<div class="form-group">
    <label class="control-label">{l s='Background Color' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="color" name="config[background_color_contact]" class="form-control color-picker" value="{$section_data.config.background_color_contact|default:'#333333'|escape:'htmlall':'UTF-8'}">
</div>
<div class="form-group">
    <label class="control-label">{l s='Text Color' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="color" name="config[text_color_contact]" class="form-control color-picker" value="{$section_data.config.text_color_contact|default:'#ffffff'|escape:'htmlall':'UTF-8'}">
</div>
<div class="form-group">
    <label class="control-label">{l s='Background Image' d='Modules.Mlthemebuilder.Admin'}</label>
     <div class="input-group">
        <input type="text" name="config[background_image_contact]" id="contact_bg_image_path" class="form-control" value="{$section_data.config.background_image_contact|default:''|escape:'htmlall':'UTF-8'}" placeholder="{l s='e.g., contact_bg.jpg' d='Modules.Mlthemebuilder.Admin'}">
        <span class="input-group-btn">
            <button type="button" class="btn btn-default btn-file-uploader" data-input-id="contact_bg_image_path" data-preview-id="contact_bg_image_preview" data-upload-type="section_background" data-section-id="{$section_data.id_section|escape:'htmlall':'UTF-8'}">
                <i class="icon-upload"></i> {l s='Upload' d='Modules.Mlthemebuilder.Admin'}
            </button>
        </span>
    </div>
    {if isset($section_data.config.background_image_contact) && $section_data.config.background_image_contact}
        <img id="contact_bg_image_preview" src="{$theme_img_path|escape:'htmlall':'UTF-8'}sections/{$section_data.config.background_image_contact|escape:'htmlall':'UTF-8'}?rand={rand(0,1000)}" alt="{l s='Background Preview' d='Modules.Mlthemebuilder.Admin'}" class="img-thumbnail image-upload-preview">
        <button type="button" class="btn btn-xs btn-danger remove-image-btn" data-input-id="contact_bg_image_path" data-preview-id="contact_bg_image_preview">{l s='Remove' d='Modules.Mlthemebuilder.Admin'}</button>
    {else}
        <img id="contact_bg_image_preview" src="#" alt="{l s='Background Preview' d='Modules.Mlthemebuilder.Admin'}" class="img-thumbnail image-upload-preview hidden">
        <button type="button" class="btn btn-xs btn-danger remove-image-btn hidden" data-input-id="contact_bg_image_path" data-preview-id="contact_bg_image_preview">{l s='Remove' d='Modules.Mlthemebuilder.Admin'}</button>
    {/if}
</div>

<div class="form-group">
    <label class="control-label">{l s='Custom CSS Class' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="text" name="config[custom_css_class]" class="form-control" value="{$section_data.config.custom_css_class|default:''|escape:'htmlall':'UTF-8'}">
</div>

<script type="text/javascript">
$(document).ready(function() {
    function toggleMapEmbed() {
        if ($('input[name="config[show_map_contact]"]:checked').val() == '1') {
            $('#map_embed_code_group').show();
        } else {
            $('#map_embed_code_group').hide();
        }
    }
    $('input[name="config[show_map_contact]"]').on('change', toggleMapEmbed);
    toggleMapEmbed(); // Initial call

    $('#section-modal-form-content .nav-tabs a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
    $('#section-modal-form-content .nav-tabs li:first-child a').tab('show');
});
</script>
