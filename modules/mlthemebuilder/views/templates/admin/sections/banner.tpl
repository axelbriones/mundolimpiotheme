{* Configuration form for Banner CTA Section *}
<input type="hidden" name="config[type]" value="banner">

{* Language tabs for multilingual fields *}
{if $languages|count > 1}
<div class="translations tabbable">
    <ul class="nav nav-tabs">
        {foreach from=$languages item=language}
            <li class="nav-item {if $language.id_lang == $current_language.id_lang}active{/if}">
                <a href="#banner_lang_{$language.id_lang|escape:'htmlall':'UTF-8'}" class="nav-link" data-toggle="tab">{$language.name|escape:'htmlall':'UTF-8'}</a>
            </li>
        {/foreach}
    </ul>
    <div class="tab-content">
{/if}
    {foreach from=$languages item=language}
        {assign var=id_lang value=$language.id_lang}
        <div class="tab-pane {if $id_lang == $current_language.id_lang}active{/if}" id="banner_lang_{$id_lang|escape:'htmlall':'UTF-8'}">
            <div class="form-group">
                <label class="control-label">{l s='Title' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="text" name="title[{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.titles[$id_lang]|default:''|escape:'htmlall':'UTF-8'}">
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Text/Content' d='Modules.Mlthemebuilder.Admin'}</label>
                <textarea name="config[text_banner][{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control rte-admin" rows="4">{$section_data.config.text_banner[$id_lang]|default:''|escape:'htmlall':'UTF-8'}</textarea>
                <p class="help-block">{l s='Main text content for the banner. HTML is allowed if RTE is enabled.' d='Modules.Mlthemebuilder.Admin'}</p>
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Button Text' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="text" name="button_text[{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.button_texts[$id_lang]|default:''|escape:'htmlall':'UTF-8'}">
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Button Link' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="text" name="button_link[{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.button_links[$id_lang]|default:'#'|escape:'htmlall':'UTF-8'}" placeholder="https://example.com/targetpage">
            </div>
        </div>
    {/foreach}
{if $languages|count > 1}
    </div>
</div>
{/if}

<hr>
<h4>{l s='Appearance & Media' d='Modules.Mlthemebuilder.Admin'}</h4>

<div class="form-group">
    <label class="control-label">{l s='Layout Style' d='Modules.Mlthemebuilder.Admin'}</label>
    <select name="config[layout_banner]" class="form-control">
        <option value="image_right" {if $section_data.config.layout_banner|default:'image_right' == 'image_right'}selected{/if}>{l s='Text Left, Image Right' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="image_left" {if $section_data.config.layout_banner|default:'' == 'image_left'}selected{/if}>{l s='Image Left, Text Right' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="text_only" {if $section_data.config.layout_banner|default:'' == 'text_only'}selected{/if}>{l s='Text Only (Centered)' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="image_background" {if $section_data.config.layout_banner|default:'' == 'image_background'}selected{/if}>{l s='Text Centered, Image as Full Background' d='Modules.Mlthemebuilder.Admin'}</option>
    </select>
</div>

<div class="form-group">
    <label class="control-label">{l s='Content Image (for layouts with image)' d='Modules.Mlthemebuilder.Admin'}</label>
    <div class="input-group">
        <input type="text" name="config[image_banner]" id="banner_image_path" class="form-control" value="{$section_data.config.image_banner|default:''|escape:'htmlall':'UTF-8'}" placeholder="{l s='e.g., cta_image.jpg' d='Modules.Mlthemebuilder.Admin'}">
        <span class="input-group-btn">
            <button type="button" class="btn btn-default btn-file-uploader" data-input-id="banner_image_path" data-preview-id="banner_image_preview" data-upload-type="section_image" data-section-id="{$section_data.id_section|escape:'htmlall':'UTF-8'}">
                <i class="icon-upload"></i> {l s='Upload' d='Modules.Mlthemebuilder.Admin'}
            </button>
        </span>
    </div>
    {if isset($section_data.config.image_banner) && $section_data.config.image_banner}
        <img id="banner_image_preview" src="{$theme_img_path|escape:'htmlall':'UTF-8'}sections/{$section_data.config.image_banner|escape:'htmlall':'UTF-8'}?rand={rand(0,1000)}" alt="{l s='Image Preview' d='Modules.Mlthemebuilder.Admin'}" class="img-thumbnail image-upload-preview">
         <button type="button" class="btn btn-xs btn-danger remove-image-btn" data-input-id="banner_image_path" data-preview-id="banner_image_preview">{l s='Remove' d='Modules.Mlthemebuilder.Admin'}</button>
    {else}
        <img id="banner_image_preview" src="#" alt="{l s='Image Preview' d='Modules.Mlthemebuilder.Admin'}" class="img-thumbnail image-upload-preview hidden">
        <button type="button" class="btn btn-xs btn-danger remove-image-btn hidden" data-input-id="banner_image_path" data-preview-id="banner_image_preview">{l s='Remove' d='Modules.Mlthemebuilder.Admin'}</button>
    {/if}
</div>

<div class="form-group">
    <label class="control-label">{l s='Background Color' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="color" name="config[background_color_banner]" class="form-control color-picker" value="{$section_data.config.background_color_banner|default:'#ff6b6b'|escape:'htmlall':'UTF-8'}">
</div>

<div class="form-group">
    <label class="control-label">{l s='Background Image (for layouts or full background)' d='Modules.Mlthemebuilder.Admin'}</label>
     <div class="input-group">
        <input type="text" name="config[background_image_banner]" id="banner_bg_image_path" class="form-control" value="{$section_data.config.background_image_banner|default:''|escape:'htmlall':'UTF-8'}" placeholder="{l s='e.g., banner_bg.jpg' d='Modules.Mlthemebuilder.Admin'}">
        <span class="input-group-btn">
            <button type="button" class="btn btn-default btn-file-uploader" data-input-id="banner_bg_image_path" data-preview-id="banner_bg_image_preview" data-upload-type="section_background" data-section-id="{$section_data.id_section|escape:'htmlall':'UTF-8'}">
                <i class="icon-upload"></i> {l s='Upload' d='Modules.Mlthemebuilder.Admin'}
            </button>
        </span>
    </div>
    {if isset($section_data.config.background_image_banner) && $section_data.config.background_image_banner}
        <img id="banner_bg_image_preview" src="{$theme_img_path|escape:'htmlall':'UTF-8'}sections/{$section_data.config.background_image_banner|escape:'htmlall':'UTF-8'}?rand={rand(0,1000)}" alt="{l s='Background Preview' d='Modules.Mlthemebuilder.Admin'}" class="img-thumbnail image-upload-preview">
        <button type="button" class="btn btn-xs btn-danger remove-image-btn" data-input-id="banner_bg_image_path" data-preview-id="banner_bg_image_preview">{l s='Remove' d='Modules.Mlthemebuilder.Admin'}</button>
    {else}
        <img id="banner_bg_image_preview" src="#" alt="{l s='Background Preview' d='Modules.Mlthemebuilder.Admin'}" class="img-thumbnail image-upload-preview hidden">
        <button type="button" class="btn btn-xs btn-danger remove-image-btn hidden" data-input-id="banner_bg_image_path" data-preview-id="banner_bg_image_preview">{l s='Remove' d='Modules.Mlthemebuilder.Admin'}</button>
    {/if}
</div>

<div class="form-group">
    <label class="control-label">{l s='Text Color (if background is dark or image)' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="color" name="config[text_color_banner]" class="form-control color-picker" value="{$section_data.config.text_color_banner|default:'#ffffff'|escape:'htmlall':'UTF-8'}">
</div>

<div class="form-group">
    <label class="control-label">{l s='Button Style' d='Modules.Mlthemebuilder.Admin'}</label>
    <select name="config[button_style_banner]" class="form-control">
        <option value="btn-primary" {if $section_data.config.button_style_banner|default:'btn-secondary' == 'btn-primary'}selected{/if}>{l s='Primary Button' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="btn-secondary" {if $section_data.config.button_style_banner|default:'btn-secondary' == 'btn-secondary'}selected{/if}>{l s='Secondary Button' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="btn-light" {if $section_data.config.button_style_banner|default:'' == 'btn-light'}selected{/if}>{l s='Light Button (for dark backgrounds)' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="btn-outline-light" {if $section_data.config.button_style_banner|default:'' == 'btn-outline-light'}selected{/if}>{l s='Outline Light (for dark backgrounds)' d='Modules.Mlthemebuilder.Admin'}</option>
    </select>
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
    // Init RTE for textareas with class .rte-admin if function exists
    if (typeof initTinyMCE !== 'undefined') {
        initTinyMCE($('textarea.rte-admin'));
    } else if (typeof tinyMCE !== 'undefined' && typeof tinyMCE.init !== 'undefined') {
        // Fallback or manual init if initTinyMCE is not PS global
        // tinyMCE.init({ selector: 'textarea.rte-admin', ... });
    }
</script>
