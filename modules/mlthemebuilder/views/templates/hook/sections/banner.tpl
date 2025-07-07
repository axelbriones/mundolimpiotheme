<!-- Banner CTA Section Template -->
<section class="banner-cta-section" id="banner-{$section.section_id|escape:'htmlall':'UTF-8'}" style="{if isset($section.config.background_color_banner) && $section.config.background_color_banner}background-color: {$section.config.background_color_banner|escape:'htmlall':'UTF-8'};{/if} {if isset($section.config.background_image_banner) && $section.config.background_image_banner}background-image: url('{$img_dir_theme|escape:'htmlall':'UTF-8'}sections/{$section.config.background_image_banner|escape:'htmlall':'UTF-8'}');{/if}">
    <div class="banner-container container">
        <div class="banner-content {if isset($section.config.layout_banner) && $section.config.layout_banner == 'image_left'}image-left{else}image-right{/if}">
            <div class="banner-text">
                {if isset($section.title) && $section.title}
                    <h2 class="banner-title">{$section.title|escape:'htmlall':'UTF-8'}</h2>
                {elseif isset($section.banner_title) && $section.banner_title}
                     <h2 class="banner-title">{$section.banner_title|escape:'htmlall':'UTF-8'}</h2>
                {/if}

                {if isset($section.content) && $section.content}
                    <p class="banner-description">{$section.content nofilter}</p> {* Allow HTML, sanitize on input *}
                {elseif isset($section.banner_text) && $section.banner_text}
                    <p class="banner-description">{$section.banner_text nofilter}</p>
                {/if}

                {if (isset($section.button_text) && $section.button_text) || (isset($section.banner_button_text) && $section.banner_button_text)}
                <a href="{if isset($section.button_link) && $section.button_link}{$section.button_link|escape:'htmlall':'UTF-8'}{elseif isset($section.banner_button_link) && $section.banner_button_link}{$section.banner_button_link|escape:'htmlall':'UTF-8'}{else}#{/if}" class="btn btn-secondary banner-btn">
                    {if isset($section.button_text) && $section.button_text}{$section.button_text|escape:'htmlall':'UTF-8'}{elseif isset($section.banner_button_text) && $section.banner_button_text}{$section.banner_button_text|escape:'htmlall':'UTF-8'}{/if}
                </a>
                {/if}
            </div>
            <div class="banner-image">
                {if isset($section.config.image_banner) && $section.config.image_banner}
                    <img src="{$img_dir_theme|escape:'htmlall':'UTF-8'}sections/{$section.config.image_banner|escape:'htmlall':'UTF-8'}" alt="{if isset($section.title)}{$section.title|escape:'htmlall':'UTF-8'}{elseif isset($section.banner_title)}{$section.banner_title|escape:'htmlall':'UTF-8'}{/if}" class="banner-img lazyload">
                {elseif isset($section.banner_image) && $section.banner_image}
                     <img src="{$section.banner_image|escape:'htmlall':'UTF-8'}" alt="{if isset($section.title)}{$section.title|escape:'htmlall':'UTF-8'}{elseif isset($section.banner_title)}{$section.banner_title|escape:'htmlall':'UTF-8'}{/if}" class="banner-img lazyload">
                {/if}
            </div>
        </div>
    </div>
</section>
