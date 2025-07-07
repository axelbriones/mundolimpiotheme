<!-- Services Section Template -->
<section class="services-section" id="services-{$section.section_id|escape:'htmlall':'UTF-8'}">
    <div class="container">
        <div class="section-header">
            {if isset($section.title) && $section.title}
                <h2 class="section-title">{$section.title|escape:'htmlall':'UTF-8'}</h2>
            {elseif isset($section.config.title_services[$language.id_lang]) && $section.config.title_services[$language.id_lang]}
                <h2 class="section-title">{$section.config.title_services[$language.id_lang]|escape:'htmlall':'UTF-8'}</h2>
            {else}
                <h2 class="section-title">{l s='Our Services' d='Modules.Customthemebuilder.Shop'}</h2>
            {/if}

            {if isset($section.content) && $section.content}
                 <p class="section-subtitle">{$section.content|escape:'htmlall':'UTF-8'}</p>
            {elseif isset($section.config.subtitle_services[$language.id_lang]) && $section.config.subtitle_services[$language.id_lang]}
                <p class="section-subtitle">{$section.config.subtitle_services[$language.id_lang]|escape:'htmlall':'UTF-8'}</p>
            {else}
                <p class="section-subtitle">{l s='Discover what we can do for you' d='Modules.Customthemebuilder.Shop'}</p>
            {/if}
        </div>

        {if isset($section.services_list) && $section.services_list}
            <div class="services-grid columns-{$section.config.columns_services|default:3|escape:'htmlall':'UTF-8'}">
                {foreach from=$section.services_list item=service_item}
                    <div class="service-card">
                        {if isset($service_item.icon) && $service_item.icon}
                            <div class="service-icon">
                                {if $service_item.icon|startsWith:'fa-' || $service_item.icon|startsWith:'fas ' || $service_item.icon|startsWith:'far ' || $service_item.icon|startsWith:'fab '}
                                    <i class="{$service_item.icon|escape:'htmlall':'UTF-8'}"></i>
                                {else}
                                    <img src="{$img_dir_theme|escape:'htmlall':'UTF-8'}icons/{$service_item.icon|escape:'htmlall':'UTF-8'}" alt="{$service_item.title|escape:'htmlall':'UTF-8'}" class="service-icon-img lazyload">
                                {/if}
                            </div>
                        {/if}
                        {if isset($service_item.title) && $service_item.title}
                            <h3 class="service-title">{$service_item.title|escape:'htmlall':'UTF-8'}</h3>
                        {/if}
                        {if isset($service_item.description) && $service_item.description}
                            <div class="service-description">{$service_item.description nofilter}</div> {* Allow HTML for description, ensure it's sanitized on input *}
                        {/if}
                    </div>
                {/foreach}
            </div>
        {else}
            <p class="text-center">{l s='No services available at the moment.' d='Modules.Customthemebuilder.Shop'}</p>
        {/if}
    </div>
</section>
