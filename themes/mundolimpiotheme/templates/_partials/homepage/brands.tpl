{**
 * Brands Slider Section for Mundo Limpio Theme Homepage
 * Design based on React component.
 *}
<section class="homepage-section brands-section" id="marcas"> {* id="marcas" for anchor linking. *}
    <div class="section-header text-center mb-10 md:mb-12">
        <h2 class="font-montserrat font-bold text-2xl md:text-3xl text-corporate-blue mb-3 md:mb-4">
            {l s='Principales Marcas' d='Shop.Theme.Mundolimpio'}
        </h2>
        <p class="font-opensans text-md md:text-lg text-gray-600">
            {l s='Distribuimos las mejores marcas del mercado' d='Shop.Theme.Mundolimpio'}
        </p>
    </div>

    <div class="brands-slider-container relative overflow-hidden">
        {* Para el efecto de scroll infinito con CSS puro, necesitamos duplicar el contenido.
           Si se usa JS para el slider, el JS podría manejar la duplicación o el bucle.
           Aquí se asume una animación CSS, por lo que duplicamos.
        *}
        <div class="brands-track flex animate-scroll hover:pause">
            {assign var=brands_data value=[
                ['name' => 'Elite Professional', 'url' => 'https://eliteprofessional.com.ar', 'logo' => 'https://www.eliteprofessional.com.ar/assets/dist/frontend/images/elite-logo.png'],
                ['name' => 'Casa Thames', 'url' => 'https://casathames.com', 'logo' => 'https://www.casathames.com/images/logo.gif'],
                ['name' => 'Cahesa', 'url' => 'https://cahesa.com.ar', 'logo' => 'https://cahesa.com.ar/images/logo-cahesa.png'],
                ['name' => 'Wassington', 'url' => 'https://wassington.com.ar', 'logo' => 'https://wassington.com.ar/wp-content/uploads/2024/03/Logo-Wassington-Corporativo_Black.png'],
                ['name' => 'Vulcano', 'url' => 'https://vulcano-sa.com.ar', 'logo' => 'https://vulcano-sa.com.ar/wp-content/uploads/2024/01/logo-VULCANO-50-ANOS-e1709234751800-150x65.png'],
                ['name' => 'Nataclor', 'url' => 'https://nataclor.com.ar', 'logo' => 'https://www.nataclor.com.ar/cdn/shop/files/Nataclor_celeste.png?v=1724255942&width=280']
                {* Añadir más marcas si es necesario para llenar el espacio y que el scroll se vea bien *}
            ]}

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
                 <div class="brand-slide-item flex-shrink-0 w-48 mx-4 md:mx-6" aria-hidden="true"> {* aria-hidden para los duplicados *}
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
