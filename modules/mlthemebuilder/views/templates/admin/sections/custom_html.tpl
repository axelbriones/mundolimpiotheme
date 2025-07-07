{* Configuration form for Custom HTML Section *}
{* This section allows direct HTML input, so it needs careful handling and potentially sanitization options or warnings. *}
<input type="hidden" name="config[type]" value="custom_html">

{* Language tabs for multilingual fields *}
{if $languages|count > 1}
<div class="translations tabbable">
    <ul class="nav nav-tabs">
        {foreach from=$languages item=language}
            <li class="nav-item {if $language.id_lang == $current_language.id_lang}active{/if}">
                <a href="#custom_html_lang_{$language.id_lang|escape:'htmlall':'UTF-8'}" class="nav-link" data-toggle="tab">{$language.name|escape:'htmlall':'UTF-8'}</a>
            </li>
        {/foreach}
    </ul>
    <div class="tab-content">
{/if}
    {foreach from=$languages item=language}
        {assign var=id_lang value=$language.id_lang}
        <div class="tab-pane {if $id_lang == $current_language.id_lang}active{/if}" id="custom_html_lang_{$id_lang|escape:'htmlall':'UTF-8'}">
            <div class="form-group">
                <label class="control-label">{l s='Section Title (Optional, for Admin only)' d='Modules.Mlthemebuilder.Admin'}</label>
                <input type="text" name="title[{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control" value="{$section_data.titles[$id_lang]|default:''|escape:'htmlall':'UTF-8'}" placeholder="{l s='e.g., Special Promotion Block' d='Modules.Mlthemebuilder.Admin'}">
                <p class="help-block">{l s='This title is for your reference in the admin panel and is not displayed on the frontend unless your custom HTML includes it.' d='Modules.Mlthemebuilder.Admin'}</p>
            </div>

            <div class="form-group">
                <label class="control-label">{l s='Custom HTML Content' d='Modules.Mlthemebuilder.Admin'}</label>
                <textarea name="config[custom_html_content][{$id_lang|escape:'htmlall':'UTF-8'}]" class="form-control code codemirror-html" data-editor-mode="htmlmixed" rows="15">{$section_data.config.custom_html_content[$id_lang]|default:''|escape:'htmlall':'UTF-8'}</textarea> {/* Note: Escaping here for safety in textarea, but on output it will be raw HTML */}
                <p class="help-block">
                    {l s='Enter your custom HTML code here. Be careful, as incorrect HTML/JS can break your site.' d='Modules.Mlthemebuilder.Admin'}
                    {l s='You can use Smarty variables available in the frontend context (e.g., {$shop.name}, {$urls.base_url}).' d='Modules.Mlthemebuilder.Admin'}
                    {l s='If using <script> tags, ensure they are correctly formatted and secure.' d='Modules.Mlthemebuilder.Admin'}
                </p>
            </div>
        </div>
    {/foreach}
{if $languages|count > 1}
    </div>
</div>
{/if}

<hr>
<h4>{l s='Appearance & Options' d='Modules.Mlthemebuilder.Admin'}</h4>

<div class="form-group">
    <label class="control-label">{l s='Full Width Section' d='Modules.Mlthemebuilder.Admin'}</label>
    <span class="switch prestashop-switch fixed-width-sm">
        <input type="radio" name="config[full_width_custom_html]" id="full_width_custom_html_on" value="1" {if $section_data.config.full_width_custom_html|default:false}checked="checked"{/if}>
        <label for="full_width_custom_html_on">{l s='Yes' d='Modules.Mlthemebuilder.Admin'}</label>
        <input type="radio" name="config[full_width_custom_html]" id="full_width_custom_html_off" value="0" {if !$section_data.config.full_width_custom_html|default:false}checked="checked"{/if}>
        <label for="full_width_custom_html_off">{l s='No' d='Modules.Mlthemebuilder.Admin'}</label>
        <a class="slide-button btn"></a>
    </span>
    <p class="help-block">{l s='If No, content will be wrapped in a standard container. If Yes, it spans the full browser width (you control container inside your HTML).' d='Modules.Mlthemebuilder.Admin'}</p>
</div>

<div class="form-group">
    <label class="control-label">{l s='Remove Section Padding' d='Modules.Mlthemebuilder.Admin'}</label>
    <span class="switch prestashop-switch fixed-width-sm">
        <input type="radio" name="config[no_padding_custom_html]" id="no_padding_custom_html_on" value="1" {if $section_data.config.no_padding_custom_html|default:false}checked="checked"{/if}>
        <label for="no_padding_custom_html_on">{l s='Yes' d='Modules.Mlthemebuilder.Admin'}</label>
        <input type="radio" name="config[no_padding_custom_html]" id="no_padding_custom_html_off" value="0" {if !$section_data.config.no_padding_custom_html|default:false}checked="checked"{/if}>
        <label for="no_padding_custom_html_off">{l s='No' d='Modules.Mlthemebuilder.Admin'}</label>
        <a class="slide-button btn"></a>
    </span>
    <p class="help-block">{l s='If Yes, removes the default top/bottom padding of the section wrapper. Useful for full-bleed designs.' d='Modules.Mlthemebuilder.Admin'}</p>
</div>


<div class="form-group">
    <label class="control-label">{l s='Background Color' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="color" name="config[background_color_custom_html]" class="form-control color-picker" value="{$section_data.config.background_color_custom_html|default:'#ffffff'|escape:'htmlall':'UTF-8'}">
</div>

<div class="form-group">
    <label class="control-label">{l s='Custom CSS Class for this Section' d='Modules.Mlthemebuilder.Admin'}</label>
    <input type="text" name="config[custom_css_class]" class="form-control" value="{$section_data.config.custom_css_class|default:''|escape:'htmlall':'UTF-8'}" placeholder="{l s='e.g., my-unique-html-block' d='Modules.Mlthemebuilder.Admin'}">
</div>

<div class="alert alert-warning">
    <strong>{l s='Security Warning:' d='Modules.Mlthemebuilder.Admin'}</strong>
    {l s='Allowing arbitrary HTML and JavaScript can be a security risk if non-trusted users have access to this configuration. Ensure that only trusted administrators can edit this section.' d='Modules.Mlthemebuilder.Admin'}
    {l s='This module does not sanitize the Custom HTML content by default to provide maximum flexibility. You are responsible for the security of the code you input.' d='Modules.Mlthemebuilder.Admin'}
</div>

<script type="text/javascript">
$(document).ready(function() {
    // Initialize CodeMirror or similar for HTML editing if available
    // This is a generic placeholder; actual CodeMirror init is more complex
    if (typeof CodeMirror !== 'undefined') {
        $('textarea.codemirror-html').each(function(){
            var editor = CodeMirror.fromTextArea(this, {
                mode: $(this).data('editor-mode') || "htmlmixed",
                lineNumbers: true,
                theme: "default", // or your preferred theme
                // ... other CodeMirror options
            });
            // Refresh editor if modal is resized or shown (if it was hidden)
            // $('#sectionConfigurationModal').on('shown.bs.modal', function () { editor.refresh(); });
        });
    }

    $('#section-modal-form-content .nav-tabs a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
     $('#section-modal-form-content .nav-tabs li:first-child a').tab('show');
});
</script>
