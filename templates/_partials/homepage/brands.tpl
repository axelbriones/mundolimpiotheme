{**
 * Brands Slider Section for Mundo Limpio Theme Homepage
 * Content is semi-static for now.
 *}
<section class="homepage-section brands-section" id="brands">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">{l s='Marcas que Inspiran Confianza' d='Shop.Theme.Mundolimpio'}</h2>
            {* <p class="section-subtitle">{l s='Colaboramos con marcas comprometidas con la sostenibilidad y la calidad.' d='Shop.Theme.Mundolimpio'}</p> *}
        </div>
        <div class="brands-slider" data-duration="30s"> {* data-duration para control JS si es necesario *}
            <div class="brands-track">
                {* Ejemplo de Logos - Reemplazar con logos reales o un sistema dinámico *}
                {assign var=brand_logos value=[
                    ['name' => 'Marca Eco 1', 'logo' => '{$urls.theme_assets}img/placeholders/brand-logo-150x60.png', 'url' => '#'],
                    ['name' => 'Sello Orgánico', 'logo' => '{$urls.theme_assets}img/placeholders/brand-logo-150x60.png', 'url' => '#'],
                    ['name' => 'Certificado Verde', 'logo' => '{$urls.theme_assets}img/placeholders/brand-logo-150x60.png', 'url' => '#'],
                    ['name' => 'Amigo del Planeta', 'logo' => '{$urls.theme_assets}img/placeholders/brand-logo-150x60.png', 'url' => '#'],
                    ['name' => 'Naturalmente Tuyo', 'logo' => '{$urls.theme_assets}img/placeholders/brand-logo-150x60.png', 'url' => '#'],
                    ['name' => 'Comercio Justo Garantizado', 'logo' => '{$urls.theme_assets}img/placeholders/brand-logo-150x60.png', 'url' => '#']
                ]}

                {foreach from=$brand_logos item=brand}
                    <div class="brand-item">
                        {if $brand.url && $brand.url != '#'}
                            <a href="{$brand.url nofilter}" target="_blank" rel="noopener noreferrer" title="{$brand.name|escape:'htmlall':'UTF-8'}">
                        {/if}
                        <img src="{$brand.logo nofilter}" alt="{$brand.name|escape:'htmlall':'UTF-8'}" class="brand-logo lazyload">
                        {if $brand.url && $brand.url != '#'}
                            </a>
                        {/if}
                    </div>
                {/foreach}
                {* Se duplicarán por JS para el efecto de scroll infinito si es necesario, o por CSS *}
            </div>
        </div>
    </div>
</section>
