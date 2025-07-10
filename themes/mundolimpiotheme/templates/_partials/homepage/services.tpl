{**
 * Services Section for Mundo Limpio Theme Homepage
 * Updated with new design and content based on React example.
 *}
<section class="homepage-section services-section" id="servicios"> {* id="servicios" for anchor linking, as per React example. Class "services" already exists. *}
    {* Background decorative elements - to be implemented with CSS pseudo-elements or SVGs *}
    <div class="services-bg-decor absolute inset-0">
        <div class="decor-shape shape-1"></div>
        <div class="decor-shape shape-2"></div>
    </div>

    <div class="container relative z-10"> {* container class from theme.css, relative z-10 from React example *}
        <div class="section-header text-center mb-12 md:mb-20"> {* mb-20 from React example, adjust with clamp if needed *}
            <div class="inline-block bg-corporate-blue-light text-corporate-blue px-4 py-2 rounded-full text-sm font-montserrat font-medium mb-4 md:mb-6">
                {l s='Nuestros Servicios' d='Shop.Theme.Mundolimpio'}
            </div>
            <h2 class="font-montserrat font-bold text-3xl md:text-4xl lg:text-5xl text-corporate-blue mb-4 md:mb-6 leading-tight">
                {l s='Soluciones Integrales' d='Shop.Theme.Mundolimpio'}
                <span class="block text-corporate-green">{l s='para su Negocio' d='Shop.Theme.Mundolimpio'}</span>
            </h2>
            <p class="font-opensans text-lg md:text-xl text-gray-600 max-w-3xl lg:max-w-4xl mx-auto leading-relaxed">
                {l s='Estamos capacitados para cubrir cualquier necesidad en productos y sistemas de limpieza institucional y hogareña, brindándole siempre una solución integral con compromiso ecológico desde 2008.' d='Shop.Theme.Mundolimpio'}
            </p>
        </div>

        {assign var=services_data value=[
            [
                'icon' => 'group', {* Material Icon for Users *}
                'title' => {l s='Servicio Personalizado' d='Shop.Theme.Mundolimpio'},
                'description' => {l s='Asesoramiento experto y atención dedicada para encontrar la solución perfecta según sus necesidades específicas.' d='Shop.Theme.Mundolimpio'},
                'features' => [
                    {l s='Consultoría personalizada' d='Shop.Theme.Mundolimpio'},
                    {l s='Análisis de necesidades' d='Shop.Theme.Mundolimpio'},
                    {l s='Soporte continuo' d='Shop.Theme.Mundolimpio'}
                ]
            ],
            [
                'icon' => 'schedule', {* Material Icon for Clock *}
                'title' => {l s='Soluciones Inmediatas' d='Shop.Theme.Mundolimpio'},
                'description' => {l s='Entregas rápidas y stock permanente para resolver sus problemas de limpieza e higiene sin demoras.' d='Shop.Theme.Mundolimpio'},
                'features' => [
                    {l s='Entrega el mismo día' d='Shop.Theme.Mundolimpio'},
                    {l s='Stock permanente' d='Shop.Theme.Mundolimpio'},
                    {l s='Logística eficiente' d='Shop.Theme.Mundolimpio'}
                ]
            ],
            [
                'icon' => 'check_circle', {* Material Icon for CheckCircle *}
                'title' => {l s='Responsabilidad Ecológica' d='Shop.Theme.Mundolimpio'},
                'description' => {l s='Priorizamos productos sustentables y amigables con el medio ambiente, cuidando la selva misionera.' d='Shop.Theme.Mundolimpio'},
                'features' => [
                    {l s='Productos eco-friendly' d='Shop.Theme.Mundolimpio'},
                    {l s='Compromiso ambiental' d='Shop.Theme.Mundolimpio'},
                    {l s='Sustentabilidad' d='Shop.Theme.Mundolimpio'}
                ]
            ]
        ]}

        <div class="services-grid grid md:grid-cols-3 gap-8 lg:gap-12">
            {foreach from=$services_data item=service name=serviceLoop}
                <div class="service-card ml-animate-on-scroll anim-fadeInUp" data-delay="{$smarty.foreach.serviceLoop.iteration * 150}">
                    <div class="service-card-gradient-overlay"></div>
                    <div class="service-card-header text-center pb-6 relative z-10">
                        <div class="service-card-icon-wrapper">
                            <i class="material-icons">{$service.icon|escape:'htmlall':'UTF-8'}</i>
                        </div>
                        <h3 class="service-card-title font-montserrat font-bold text-2xl text-corporate-blue">
                            {$service.title|escape:'htmlall':'UTF-8'}
                        </h3>
                    </div>
                    <div class="service-card-content text-center px-6 md:px-8 pb-8 relative z-10">
                        <p class="font-opensans text-gray-600 mb-6 md:mb-8 text-base md:text-lg leading-relaxed">
                            {$service.description|escape:'htmlall':'UTF-8'}
                        </p>
                        <div class="service-features space-y-3 md:space-y-4">
                            {foreach from=$service.features item=feature}
                                <div class="feature-item flex items-center justify-center">
                                    <i class="material-icons feature-icon">check_circle</i>
                                    <span class="font-opensans text-gray-700 font-medium">{$feature|escape:'htmlall':'UTF-8'}</span>
                                </div>
                            {/foreach}
                        </div>
                        <div class="service-learn-more mt-8">
                            <a href="#" class="learn-more-link flex items-center justify-center text-corporate-blue font-montserrat font-semibold">
                                {l s='Saber más' d='Shop.Theme.Actions'}
                                <i class="material-icons learn-more-icon">arrow_forward</i>
                            </a>
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>

        <div class="services-bottom-cta text-center mt-12 md:mt-20">
            <p class="font-opensans text-lg text-gray-600 mb-4 md:mb-6">
                {l s='¿Necesita una solución personalizada para su empresa?' d='Shop.Theme.Mundolimpio'}
            </p>
            <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}" class="inline-flex items-center text-corporate-blue font-montserrat font-semibold text-lg hover:text-corporate-green transition-colors duration-300 cursor-pointer">
                {l s='Contactar ahora mismo' d='Shop.Theme.Actions'}
                <i class="material-icons ml-2">arrow_forward</i>
            </a>
        </div>
    </div>
</section>
