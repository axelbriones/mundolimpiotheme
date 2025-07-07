{* MlThemeBuilder - Hook Header Template *}

{* This template can be used to output global styles, custom CSS/JS from settings, etc., directly into the <head> *}

{if isset($mltheme_global_styles) && $mltheme_global_styles}
    <style type="text/css" id="mltheme-global-styles">
        :root {
            {if isset($mltheme_global_styles.primary_color) && $mltheme_global_styles.primary_color}
                --ml-primary-color: {$mltheme_global_styles.primary_color|escape:'htmlall':'UTF-8'};
                /* Basic RGB conversion for opacity usage, JS might be better for complex cases */
                {$rgb_primary = $mltheme_global_styles.primary_color|replace:'#':'' }
                {if $rgb_primary|strlen == 6}
                    --ml-primary-color-rgb: {hexdec(substr($rgb_primary, 0, 2))}, {hexdec(substr($rgb_primary, 2, 2))}, {hexdec(substr($rgb_primary, 4, 2))};
                {elseif $rgb_primary|strlen == 3}
                     --ml-primary-color-rgb: {hexdec(substr($rgb_primary, 0, 1)|str_repeat:2)}, {hexdec(substr($rgb_primary, 1, 1)|str_repeat:2)}, {hexdec(substr($rgb_primary, 2, 1)|str_repeat:2)};
                {/if}
            {/if}
            {if isset($mltheme_global_styles.secondary_color) && $mltheme_global_styles.secondary_color}
                --ml-secondary-color: {$mltheme_global_styles.secondary_color|escape:'htmlall':'UTF-8'};
            {/if}
            {if isset($mltheme_global_styles.text_color) && $mltheme_global_styles.text_color}
                --ml-text-color: {$mltheme_global_styles.text_color|escape:'htmlall':'UTF-8'};
            {/if}
            {if isset($mltheme_global_styles.link_color) && $mltheme_global_styles.link_color}
                --ml-link-color: {$mltheme_global_styles.link_color|escape:'htmlall':'UTF-8'};
            {else if isset($mltheme_global_styles.primary_color) && $mltheme_global_styles.primary_color}
                --ml-link-color: var(--ml-primary-color);
            {/if}
            {if isset($mltheme_global_styles.bg_light_color) && $mltheme_global_styles.bg_light_color}
                --ml-bg-light-color: {$mltheme_global_styles.bg_light_color|escape:'htmlall':'UTF-8'};
            {/if}
            {if isset($mltheme_global_styles.bg_dark_color) && $mltheme_global_styles.bg_dark_color}
                --ml-bg-dark-color: {$mltheme_global_styles.bg_dark_color|escape:'htmlall':'UTF-8'};
            {/if}
            {if isset($mltheme_global_styles.primary_font) && $mltheme_global_styles.primary_font}
                --ml-font-primary: {$mltheme_global_styles.primary_font|escape:'htmlall':'UTF-8'};
            {/if}
            {if isset($mltheme_global_styles.secondary_font) && $mltheme_global_styles.secondary_font}
                --ml-font-secondary: {$mltheme_global_styles.secondary_font|escape:'htmlall':'UTF-8'};
            {else if isset($mltheme_global_styles.primary_font) && $mltheme_global_styles.primary_font}
                 --ml-font-secondary: var(--ml-font-primary);
            {/if}
            {if isset($mltheme_global_styles.base_font_size) && $mltheme_global_styles.base_font_size}
                --ml-base-font-size: {$mltheme_global_styles.base_font_size|intval}px;
            {/if}
            {if isset($mltheme_global_styles.heading_font_scale) && $mltheme_global_styles.heading_font_scale}
                --ml-heading-font-scale: {$mltheme_global_styles.heading_font_scale|floatval};
            {/if}
            {if isset($mltheme_global_styles.container_max_width) && $mltheme_global_styles.container_max_width}
                --ml-container-max-width: {$mltheme_global_styles.container_max_width|intval}px;
            {/if}
            {if isset($mltheme_global_styles.section_padding_y) && $mltheme_global_styles.section_padding_y}
                --ml-section-padding-y: {$mltheme_global_styles.section_padding_y|intval}px;
            {/if}
            {if isset($mltheme_global_styles.button_border_radius) && $mltheme_global_styles.button_border_radius}
                --ml-button-border-radius: {$mltheme_global_styles.button_border_radius|intval}px;
            {/if}
        }
        body a { color: var(--ml-link-color); }
        /* Add more global styles here if needed, using the CSS variables */
    </style>
{/if}

{if isset($mltheme_custom_css) && $mltheme_custom_css}
    <style type="text/css" id="mltheme-custom-css">
        {$mltheme_custom_css nofilter} {* Use with caution, ensure sanitization on input if possible, or trust admin input *}
    </style>
{/if}

{if isset($mltheme_custom_js_header) && $mltheme_custom_js_header}
    <script type="text/javascript" id="mltheme-custom-js-header">
        //<![CDATA[
        {$mltheme_custom_js_header nofilter} {* Use with caution, ensure sanitization on input if possible, or trust admin input *}
        //]]>
    </script>
{/if}

{* Preload critical fonts if specified and not handled by Google Fonts link *}
{* Example: <link rel="preload" href="{$path_to_font_file}" as="font" type="font/woff2" crossorigin> *}

{* Add JS variables for frontend scripts, like AJAX URLs or translations if prestashop object is not fully populated *}
<script type="text/javascript">
    if (typeof window.prestashop === 'undefined') {
        window.prestashop = {};
    }
    if (typeof window.prestashop.modules === 'undefined') {
        window.prestashop.modules = {};
    }
    if (typeof window.prestashop.modules.mlthemebuilder === 'undefined') {
        window.prestashop.modules.mlthemebuilder = {};
    }
    // This should ideally match the AdminController's AJAX link generation
    window.prestashop.modules.mlthemebuilder.ajaxUrl = '{$link->getModuleLink("mlthemebuilder", "ajax", [], true)|escape:'htmlall':'UTF-8'}';

    // Frontend translations for JS (example)
    window.prestashop.modules.mlthemebuilder.translations = {
        sending: "{l s='Sending...' d='Modules.Mlthemebuilder.Shop' js=1}",
        messageSent: "{l s='Message sent successfully!' d='Modules.Mlthemebuilder.Shop' js=1}",
        errorSendingMessage: "{l s='An error occurred. Please try again.' d='Modules.Mlthemebuilder.Shop' js=1}",
        fillRequiredFields: "{l s='Please fill all required fields.' d='Modules.Mlthemebuilder.Shop' js=1}"
        // Add more as needed
    };
</script>
