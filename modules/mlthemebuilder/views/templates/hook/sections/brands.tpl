<!-- Brands Section Template -->
<section class="brands-section" id="brands-{$section.section_id|escape:'htmlall':'UTF-8'}">
    <div class="container">
        <div class="section-header">
            {if isset($section.title) && $section.title}
                <h2 class="section-title">{$section.title|escape:'htmlall':'UTF-8'}</h2>
            {elseif isset($section.brands_list_title) && $section.brands_list_title}
                 <h2 class="section-title">{$section.brands_list_title|escape:'htmlall':'UTF-8'}</h2>
            {else}
                <h2 class="section-title">{l s='Brands We Trust' d='Modules.Customthemebuilder.Shop'}</h2>
            {/if}
        </div>

        {if isset($section.brands_list) && $section.brands_list}
            <div class="brands-slider" data-duration="{$section.config.speed_brands|default:30|escape:'htmlall':'UTF-8'}s">
                <div class="brands-track">
                    {foreach from=$section.brands_list item=brand_item}
                        <div class="brand-item">
                            {if isset($brand_item.url) && $brand_item.url}
                                <a href="{$brand_item.url|escape:'htmlall':'UTF-8'}" target="_blank" rel="noopener noreferrer">
                            {/if}

                            {if isset($brand_item.logo) && $brand_item.logo}
                                <img src="{$img_dir_theme|escape:'htmlall':'UTF-8'}brands/{$brand_item.logo|escape:'htmlall':'UTF-8'}" alt="{$brand_item.name|escape:'htmlall':'UTF-8'}" class="brand-logo lazyload" loading="lazy">
                            {else}
                                <span class="brand-name">{$brand_item.name|escape:'htmlall':'UTF-8'}</span>
                            {/if}

                            {if isset($brand_item.url) && $brand_item.url}
                                </a>
                            {/if}
                        </div>
                    {/foreach}
                    {* Duplicate for infinite scroll effect, handled by JS if more robust solution is needed *}
                     {foreach from=$section.brands_list item=brand_item}
                        <div class="brand-item">
                            {if isset($brand_item.url) && $brand_item.url}
                                <a href="{$brand_item.url|escape:'htmlall':'UTF-8'}" target="_blank" rel="noopener noreferrer">
                            {/if}

                            {if isset($brand_item.logo) && $brand_item.logo}
                                <img src="{$img_dir_theme|escape:'htmlall':'UTF-8'}brands/{$brand_item.logo|escape:'htmlall':'UTF-8'}" alt="{$brand_item.name|escape:'htmlall':'UTF-8'}" class="brand-logo lazyload" loading="lazy">
                            {else}
                                <span class="brand-name">{$brand_item.name|escape:'htmlall':'UTF-8'}</span>
                            {/if}

                            {if isset($brand_item.url) && $brand_item.url}
                                </a>
                            {/if}
                        </div>
                    {/foreach}
                </div>
            </div>
        {else}
            <p class="text-center">{l s='No brands to display at the moment.' d='Modules.Customthemebuilder.Shop'}</p>
        {/if}
    </div>
</section>
