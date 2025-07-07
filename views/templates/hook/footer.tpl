{* MlThemeBuilder - Hook Footer Template *}

{* This template can be used to output custom JS from settings before the closing </body> tag *}

{if isset($mltheme_custom_js_footer) && $mltheme_custom_js_footer}
    <script type="text/javascript" id="mltheme-custom-js-footer">
        //<![CDATA[
        {$mltheme_custom_js_footer nofilter} {* Use with caution, ensure sanitization on input if possible, or trust admin input *}
        //]]>
    </script>
{/if}

{* Example: Add a scroll-to-top button if enabled in settings (or handle in front.js) *}
{* {if MlThemeSetting::getSettingValue('enable_scroll_to_top')}
    <a href="#" class="ml-scroll-to-top" title="{l s='Scroll to top' d='Modules.Mlthemebuilder.Shop'}">
        <i class="material-icons">keyboard_arrow_up</i>
    </a>
{/if} *}

{* Schema.org markup or other structured data can also be added here if relevant to the module's global functionality *}
{*
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "{$shop.name|escape:'htmlall':'UTF-8'}",
  "url": "{$urls.base_url|escape:'htmlall':'UTF-8'}"
  {if $shop.logo}, "logo": "{$shop.logo|escape:'htmlall':'UTF-8'}"{/if}
}
</script>
*}
