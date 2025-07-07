{* Configuration form for Ecology Section *}
<input type="hidden" name="config[type]" value="ecology">

{* Language tabs for multilingual fields *}
{if $languages|count > 1}
<div class="translations tabbable">
    <ul class="nav nav-tabs">
        {foreach from=$languages item=language}
            <li class="nav-item {if $language.id_lang == $current_language.id_lang}active{/if}">
                <a href="#ecology_lang_{$language.id_lang|escape:'htmlall':'UTF-8'}" class="nav-link" data-toggle="tab">{$language.name|escape:'htmlall':'UTF-8'}</a>
            </li>
        {/foreach}
    </ul>
    <div class="tab-content">
{/if}
    {foreach from=$languages item=language}
        {assign var=id_lang value=$language.id_lang}
        <div class="tab-pane {if $id_lang == $current_language.id_lang}active{/if}" id="ecology_lang_{$id_lang|escape:'htmlall':'UTF-8'}">
            <div class="form-group">
                <label class="control-label">{l s='Title' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="text" name="title[{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.titles[$id_lang]|default:''|escape:'htmlall':'UTF-8'}">
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Text/Description' d='Modules.Mlthemebuilder.Admin'}</label>
                <textarea name="config[text_ecology][{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control rte-admin" rows="5">{$section_data.config.text_ecology[$id_lang]|default:''|escape:'htmlall':'UTF-8'}</textarea>
            </div>

            {* Repeatable items configuration will be handled below, outside language loop for structure, inside for text *}
        </div>
    {/foreach}
{if $languages|count > 1}
    </div>
</div>
{/if}

<hr>
<h4>{l s='Ecology Items' d='Modules.Mlthemebuilder.Admin'}</h4>
<div id="ecology-items-container" class="repeatable-item-container">
    {assign var=ecology_items value=$section_data.config.items_ecology|default:[]}
    {if $ecology_items|count > 0}
        {foreach from=$ecology_items item=item key=item_key}
            <div class="ecology-item-instance repeatable-item" data-index="{$item_key|escape:'htmlall':'UTF-8'}">
                <div class="repeatable-item-header">
                    <h5>{l s='Item' d='Modules.Mlthemebuilder.Admin'} #<span class="item-index">{$item_key+1|escape:'htmlall':'UTF-8'}</span></h5>
                    <button type="button" class="btn btn-danger btn-xs remove-ecology-item remove-repeatable-item"><i class="icon-trash"></i></button>
                </div>
                <div class="form-group">
                    <label class="control-label">{l s='Icon' d='Modules.Mlthemebuilder.Admin'}</label>
                    <input type="text" name="config[items_ecology][{$item_key|escape:'htmlall':'UTF-8'}][icon]" class="form-control" value="{$item.icon|default:''|escape:'htmlall':'UTF-8'}" placeholder="{l s='e.g., fas fa-leaf or icon.png' d='Modules.Mlthemebuilder.Admin'}">
                    <p class="help-block">{l s='FontAwesome class or filename from /views/img/icons/' d='Modules.Mlthemebuilder.Admin'}</p>
                </div>
                {foreach from=$languages item=language}
                    {assign var=id_lang_item value=$language.id_lang}
                    <div class="form-group">
                        <label class="control-label">{l s='Text' d='Modules.Mlthemebuilder.Admin'} ({$language.iso_code|escape:'htmlall':'UTF-8'})</label>
                        <input type="text" name="config[items_ecology][{$item_key|escape:'htmlall':'UTF-8'}][text][{$id_lang_item|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$item.text[$id_lang_item]|default:''|escape:'htmlall':'UTF-8'}">
                    </div>
                {/foreach}
            </div>
        {/foreach}
    {else}
        <p class="text-muted no-ecology-items">{l s='No ecology items added yet.' d='Modules.Mlthemebuilder.Admin'}</p>
    {/if}
</div>
<button type="button" id="add-ecology-item" class="btn btn-default add-repeatable-item"><i class="icon-plus"></i> {l s='Add Ecology Item' d='Modules.Mlthemebuilder.Admin'}</button>

{* Template for new ecology items (for JS) *}
<div id="ecology-item-template" style="display:none;">
    <div class="ecology-item-instance repeatable-item" data-index="{index}">
        <div class="repeatable-item-header">
             <h5>{l s='Item' d='Modules.Mlthemebuilder.Admin'} #<span class="item-index">{display_index}</span></h5>
            <button type="button" class="btn btn-danger btn-xs remove-ecology-item remove-repeatable-item"><i class="icon-trash"></i></button>
        </div>
        <div class="form-group">
            <label class="control-label">{l s='Icon' d='Modules.Mlthemebuilder.Admin'}</label>
            <input type="text" name="config[items_ecology][{index}][icon]" class="form-control" placeholder="{l s='e.g., fas fa-leaf or icon.png' d='Modules.Mlthemebuilder.Admin'}">
            <p class="help-block">{l s='FontAwesome class or filename from /views/img/icons/' d='Modules.Mlthemebuilder.Admin'}</p>
        </div>
        {foreach from=$languages item=language}
            {assign var=id_lang_template value=$language.id_lang}
            <div class="form-group">
                <label class="control-label">{l s='Text' d='Modules.Mlthemebuilder.Admin'} ({$language.iso_code|escape:'htmlall':'UTF-8'})</label>
                <input type="text" name="config[items_ecology][{index}][text][{$id_lang_template|escape:'htmlall':'UTF-8'}]" class="form-control">
            </div>
        {/foreach}
    </div>
</div>


<hr>
<h4>{l s='Appearance & Media' d='Modules.Mlthemebuilder.Admin'}</h4>

<div class="form-group">
    <label class="control-label">{l s='Layout Style' d='Modules.Mlthemebuilder.Admin'}</label>
    <select name="config[layout_ecology]" class="form-control">
        <option value="image_right" {if $section_data.config.layout_ecology|default:'image_right' == 'image_right'}selected{/if}>{l s='Text Left, Image Right' d='Modules.Mlthemebuilder.Admin'}</option>
        <option value="image_left" {if $section_data.config.layout_ecology|default:'' == 'image_left'}selected{/if}>{l s='Image Left, Text Right' d='Modules.Mlthemebuilder.Admin'}</option>
    </select>
</div>

<div class="form-group">
    <label class="control-label">{l s='Image' d='Modules.Mlthemebuilder.Admin'}</label>
    <div class="input-group">
        <input type="text" name="config[image_ecology]" id="ecology_image_path" class="form-control" value="{$section_data.config.image_ecology|default:''|escape:'htmlall':'UTF-8'}" placeholder="{l s='e.g., ecology_image.jpg' d='Modules.Mlthemebuilder.Admin'}">
        <span class="input-group-btn">
            <button type="button" class="btn btn-default btn-file-uploader" data-input-id="ecology_image_path" data-preview-id="ecology_image_preview" data-upload-type="section_image" data-section-id="{$section_data.id_section|escape:'htmlall':'UTF-8'}">
                <i class="icon-upload"></i> {l s='Upload' d='Modules.Mlthemebuilder.Admin'}
            </button>
        </span>
    </div>
    {if isset($section_data.config.image_ecology) && $section_data.config.image_ecology}
        <img id="ecology_image_preview" src="{$theme_img_path|escape:'htmlall':'UTF-8'}sections/{$section_data.config.image_ecology|escape:'htmlall':'UTF-8'}?rand={rand(0,1000)}" alt="{l s='Image Preview' d='Modules.Mlthemebuilder.Admin'}" class="img-thumbnail image-upload-preview">
        <button type="button" class="btn btn-xs btn-danger remove-image-btn" data-input-id="ecology_image_path" data-preview-id="ecology_image_preview">{l s='Remove' d='Modules.Mlthemebuilder.Admin'}</button>
    {else}
        <img id="ecology_image_preview" src="#" alt="{l s='Image Preview' d='Modules.Mlthemebuilder.Admin'}" class="img-thumbnail image-upload-preview hidden">
        <button type="button" class="btn btn-xs btn-danger remove-image-btn hidden" data-input-id="ecology_image_path" data-preview-id="ecology_image_preview">{l s='Remove' d='Modules.Mlthemebuilder.Admin'}</button>
    {/if}
</div>

<div class="form-group">
    <label class="control-label">{l s='Background Color' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="color" name="config[background_color_ecology]" class="form-control color-picker" value="{$section_data.config.background_color_ecology|default:'#e8f5e8'|escape:'htmlall':'UTF-8'}">
</div>

<div class="form-group">
    <label class="control-label">{l s='Custom CSS Class' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="text" name="config[custom_css_class]" class="form-control" value="{$section_data.config.custom_css_class|default:''|escape:'htmlall':'UTF-8'}">
</div>

<script type="text/javascript">
$(document).ready(function() {
    var ecologyItemIndex = {$ecology_items|count}; // Start index from current number of items

    $('#add-ecology-item').on('click', function() {
        var template = $('#ecology-item-template').html();
        template = template.replace(/{index}/g, ecologyItemIndex)
                           .replace(/{display_index}/g, ecologyItemIndex + 1);
        $('#ecology-items-container').append(template);
        $('.no-ecology-items').hide(); // Hide "no items" message
        ecologyItemIndex++;
    });

    $('#ecology-items-container').on('click', '.remove-ecology-item', function() {
        $(this).closest('.ecology-item-instance').remove();
        // Renumber items is complex, usually not needed if server handles array keys correctly
        // If no items left, show "no items" message
        if ($('#ecology-items-container .ecology-item-instance').length === 0) {
            $('.no-ecology-items').show();
        }
    });

    $('#section-modal-form-content .nav-tabs a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
    $('#section-modal-form-content .nav-tabs li:first-child a').tab('show');
    if (typeof initTinyMCE !== 'undefined') {
        initTinyMCE($('textarea.rte-admin'));
    }
});
</script>
