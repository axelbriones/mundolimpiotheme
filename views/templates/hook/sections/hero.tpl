<!-- Hero Section Template -->
<section class="hero-section" id="hero-{$section.section_id|escape:'htmlall':'UTF-8'}" style="{if isset($section.config.background_color) && $section.config.background_color}background-color: {$section.config.background_color|escape:'htmlall':'UTF-8'};{/if}">
    <div class="hero-container container">
        <div class="hero-content">
            <div class="hero-text">
                {if isset($section.title) && $section.title}
                    <h1 class="hero-title">{$section.title|escape:'htmlall':'UTF-8'}</h1>
                {elseif isset($section.hero_title) && $section.hero_title}
                     <h1 class="hero-title">{$section.hero_title|escape:'htmlall':'UTF-8'}</h1>
                {/if}

                {if isset($section.config.subtitle_hero[$language.id_lang]) && $section.config.subtitle_hero[$language.id_lang]}
                    <p class="hero-subtitle">{$section.config.subtitle_hero[$language.id_lang]|escape:'htmlall':'UTF-8'}</p>
                {elseif isset($section.hero_subtitle) && $section.hero_subtitle}
                     <p class="hero-subtitle">{$section.hero_subtitle|escape:'htmlall':'UTF-8'}</p>
                {/if}

                {if (isset($section.button_text) && $section.button_text) || (isset($section.hero_button_text) && $section.hero_button_text)}
                <div class="hero-buttons">
                    <a href="{if isset($section.button_link) && $section.button_link}{$section.button_link|escape:'htmlall':'UTF-8'}{elseif isset($section.hero_button_link) && $section.hero_button_link}{$section.hero_button_link|escape:'htmlall':'UTF-8'}{else}#{/if}" class="btn btn-primary hero-btn">
                        {if isset($section.button_text) && $section.button_text}{$section.button_text|escape:'htmlall':'UTF-8'}{elseif isset($section.hero_button_text) && $section.hero_button_text}{$section.hero_button_text|escape:'htmlall':'UTF-8'}{/if}
                    </a>
                </div>
                {/if}
            </div>
            <div class="hero-image">
                {if isset($section.config.image_hero) && $section.config.image_hero}
                    <img src="{$img_dir_theme|escape:'htmlall':'UTF-8'}sections/{$section.config.image_hero|escape:'htmlall':'UTF-8'}" alt="{if isset($section.title)}{$section.title|escape:'htmlall':'UTF-8'}{elseif isset($section.hero_title)}{$section.hero_title|escape:'htmlall':'UTF-8'}{/if}" class="hero-img lazyload">
                {elseif isset($section.hero_image) && $section.hero_image}
                     <img src="{$section.hero_image|escape:'htmlall':'UTF-8'}" alt="{if isset($section.title)}{$section.title|escape:'htmlall':'UTF-8'}{elseif isset($section.hero_title)}{$section.hero_title|escape:'htmlall':'UTF-8'}{/if}" class="hero-img lazyload">
                {/if}
            </div>
        </div>
    </div>
</section>
