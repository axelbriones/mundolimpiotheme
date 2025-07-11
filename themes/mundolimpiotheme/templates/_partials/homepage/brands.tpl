{**
 * Brands Slider Section for Mundo Limpio Theme Homepage
 * Design based on React component.
 * Corrected Smarty array assignment for PS 1.7 compatibility.
 *}
<section class="homepage-section brands-section" id="marcas">
    <div class="section-header text-center mb-10 md:mb-12">
        <h2 class="font-montserrat font-bold text-2xl md:text-3xl text-corporate-blue mb-3 md:mb-4">
            {l s='Principales Marcas' d='Shop.Theme.Mundolimpio'}
        </h2>
        <p class="font-opensans text-md md:text-lg text-gray-600">
            {l s='Distribuimos las mejores marcas del mercado' d='Shop.Theme.Mundolimpio'}
        </p>
    </div>

    <div class="brands-slider-container relative overflow-hidden">
        <div class="brands-track flex animate-scroll hover:pause">
            {* Definición de datos para las marcas (Smarty 2/PS 1.7 compatible) *}
            {assign var='brand1' value=array('name' => 'Elite Professional', 'logo' => 'https://www.eliteprofessional.com.ar/assets/dist/frontend/images/elite-logo.png', 'url' => 'https://eliteprofessional.com.ar')}
            {assign var='brand2' value=array('name' => 'Casa Thames', 'logo' => 'https://www.casathames.com/images/logo.gif', 'url' => 'https://casathames.com')}
            {assign var='brand3' value=array('name' => 'Cahesa', 'logo' => 'https://cahesa.com.ar/images/logo-cahesa.png', 'url' => 'https://cahesa.com.ar')}
            {assign var='brand4' value=array('name' => 'Wassington', 'logo' => 'https://wassington.com.ar/wp-content/uploads/2024/03/Logo-Wassington-Corporativo_Black.png', 'url' => 'https://wassington.com.ar')}
            {assign var='brand5' value=array('name' => 'Vulcano', 'logo' => 'https://vulcano-sa.com.ar/wp-content/uploads/2024/01/logo-VULCANO-50-ANOS-e1709234751800-150x65.png', 'url' => 'https://vulcano-sa.com.ar')}
            {assign var='brand6' value=array('name' => 'Nataclor', 'logo' => 'https://www.nataclor.com.ar/cdn/shop/files/Nataclor_celeste.png?v=1724255942&width=280', 'url' => 'https://nataclor.com.ar')}
            {* Añadir más marcas aquí si es necesario, siguiendo el patrón $brandN y luego añadiéndolas al array $brands_data *}

            {assign var=brands_data value=array($brand1, $brand2, $brand3, $brand4, $brand5, $brand6)}

            {* Primera pasada de los logos *}
            {foreach from=$brands_data item=brand name=brandLoopPrimary}
                <div class="brand-slide-item flex-shrink-0 w-48 mx-4 md:mx-6">
                    <a href="{$brand.url|escape:'htmlall':'UTF-8'}"
                       target="_blank"
                       rel="noopener noreferrer"
                       class="brand-link block p-3 md:p-4 bg-gray-50 rounded-lg hover:shadow-lg transition-shadow duration-300 group">
                        <div class="brand-logo-wrapper flex items-center justify-center h-20">
                            <img src="{$brand.logo|escape:'htmlall':'UTF-8'}"
                                 alt="{$brand.name|escape:'htmlall':'UTF-8'}"
                                 class="brand-logo-img max-w-full max-h-full object-contain filter grayscale group-hover:grayscale-0 transition-all duration-300 lazyload"
                                 loading="lazy">
                        </div>
                    </a>
                </div>
            {/foreach}

            {* Segunda pasada (duplicado) para el efecto de scroll infinito con CSS *}
            {foreach from=$brands_data item=brand name=brandLoopSecondary}
                 <div class="brand-slide-item flex-shrink-0 w-48 mx-4 md:mx-6" aria-hidden="true">
                    <a href="{$brand.url|escape:'htmlall':'UTF-8'}"
                       target="_blank"
                       rel="noopener noreferrer"
                       class="brand-link block p-3 md:p-4 bg-gray-50 rounded-lg hover:shadow-lg transition-shadow duration-300 group">
                        <div class="brand-logo-wrapper flex items-center justify-center h-20">
                            <img src="{$brand.logo|escape:'htmlall':'UTF-8'}"
                                 alt="{$brand.name|escape:'htmlall':'UTF-8'}"
                                 class="brand-logo-img max-w-full max-h-full object-contain filter grayscale group-hover:grayscale-0 transition-all duration-300 lazyload"
                                 loading="lazy">
                        </div>
                    </a>
                </div>
            {/foreach}
        </div>
    </div>
</section>
