{**
 * Contact Section for Mundo Limpio Theme Homepage
 * Design based on React component, form adapted for PrestaShop ContactController.
 *}
<section class="homepage-section contact-section-alt" id="contacto">
        <div class="decor-shape shape-1"></div>
        <div class="decor-shape shape-2"></div>
        <div class="decor-shape shape-3"></div>
    </div>

    <div class="container relative z-10">
        <div class="section-header text-center mb-12 md:mb-20">
            <div class="inline-block bg-white-20 text-white px-4 py-2 rounded-full text-sm font-montserrat font-medium mb-4 md:mb-6">
                {l s='Contacto Directo' d='Shop.Theme.Mundolimpio'}
            </div>
            <h2 class="font-montserrat font-bold text-3xl md:text-4xl lg:text-5xl text-white mb-4 md:mb-6 leading-tight">
                {l s='Estamos Aquí' d='Shop.Theme.Mundolimpio'}
                <span class="block text-corporate-green">{l s='para Ayudarle' d='Shop.Theme.Mundolimpio'}</span>
            </h2>
            <p class="font-opensans text-lg md:text-xl text-blue-100 max-w-3xl mx-auto leading-relaxed">
                {l s='Brindamos soluciones prácticas e innovadoras con el mejor costo-beneficio. Su satisfacción es nuestra prioridad.' d='Shop.Theme.Mundolimpio'}
            </p>
        </div>

        {assign var='info_item1' value=array(
            'icon' => 'call',
            'title' => {l s="Atención Inmediata" d="Shop.Theme.Mundolimpio"},
            'description' => {l s="Contáctenos para asesoramiento experto y entregas rápidas" d="Shop.Theme.Mundolimpio"},
            'details' => {l s="+54 3757 XXX-XXX" d="Shop.Theme.Mundolimpio"},
            'action_text' => {l s="Llamar ahora" d="Shop.Theme.Actions"},
            'action_link' => "tel:+543757000000"
        )}
        {assign var='info_item2' value=array(
            'icon' => 'location_on',
            'title' => {l s="Ubicación Estratégica" d="Shop.Theme.Mundolimpio"},
            'description' => {l s="Servimos toda la zona de Iguazú con entregas inmediatas" d="Shop.Theme.Mundolimpio"},
            'details' => {l s="Puerto Iguazú, Misiones" d="Shop.Theme.Mundolimpio"},
            'action_text' => {l s="Ver ubicación" d="Shop.Theme.Actions"},
            'action_link' => "#"
        )}
        {assign var='info_item3' value=array(
            'icon' => 'schedule',
            'title' => {l s="Horarios Flexibles" d="Shop.Theme.Mundolimpio"},
            'description' => {l s="Atención personalizada para brindarle la mejor solución" d="Shop.Theme.Mundolimpio"},
            'details' => {l s="Lun-Vie: 8:00-18:00 | Sáb: 8:00-12:00" d="Shop.Theme.Mundolimpio"},
            'action_text' => {l s="Consultar disponibilidad" d="Shop.Theme.Actions"},
            'action_link' => $urls.pages.contact
        )}
        {assign var='contact_info_items_corrected' value=array($info_item1, $info_item2, $info_item3)}

        <div class="contact-info-grid grid md:grid-cols-3 gap-8 lg:gap-12 max-w-6xl mx-auto mb-12 md:mb-16">
            {foreach from=$contact_info_items_corrected item=info name=contactInfoLoop}
                {assign var="animation_delay" value=$smarty.foreach.contactInfoLoop.iteration * 100}
                <div class="contact-info-card ml-animate-on-scroll anim-scaleIn" data-delay="{$animation_delay|escape:'htmlall':'UTF-8'}">
                    <div class="contact-info-card-content">
                        <div class="contact-card-icon-wrapper">
                            <i class="material-icons">{$info.icon|escape:'htmlall':'UTF-8'}</i>
                        </div>
                        <h3 class="contact-card-title font-montserrat font-bold text-xl mb-3">{$info.title|escape:'htmlall':'UTF-8'}</h3>
                        <p class="contact-card-description font-opensans text-blue-100 mb-4 leading-relaxed">
                            {$info.description|escape:'htmlall':'UTF-8'}
                        </p>
                        <p class="contact-card-details font-opensans font-semibold text-lg mb-6">{$info.details|escape:'htmlall':'UTF-8'}</p>
                        <a href="{$info.action_link|escape:'htmlall':'UTF-8'}" class="contact-card-action text-corporate-green font-montserrat font-medium group-hover:text-white transition-colors duration-300">
                            {$info.action_text|escape:'htmlall':'UTF-8'}
                        </a>
                    </div>
                </div>
            {/foreach}
        </div>

        <div class="contact-form-enhanced-cta max-w-4xl mx-auto">
            <div class="contact-form-card">
                <div class="contact-form-card-content p-8 md:p-12 text-center">
                    <i class="material-icons contact-form-icon">chat_bubble_outline</i>
                    <h3 class="font-montserrat font-bold text-2xl md:text-3xl mb-4">
                        {l s='¿Listo para comenzar?' d='Shop.Theme.Mundolimpio'}
                    </h3>
                    <p class="font-opensans text-lg md:text-xl text-blue-100 mb-6 md:mb-8 max-w-2xl mx-auto">
                        {l s='Contáctenos hoy mismo y descubra cómo podemos ayudarle a mantener sus espacios impecables con productos de la más alta calidad.' d='Shop.Theme.Mundolimpio'}
                    </p>

                    <div class="flex flex-col sm:flex-row gap-4 justify-center">
                        <a href="tel:" class="btn btn-contact-action bg-corporate-green">
                            <i class="material-icons">call</i>
                            {l s='Llamar Ahora' d='Shop.Theme.Actions'}
                        </a>
                        <a href="mailto:{$shop.email|escape:'htmlall':'UTF-8'}" class="btn btn-contact-action btn-outline-white">
                             <i class="material-icons">email</i>
                            {l s='Enviar Email' d='Shop.Theme.Actions'}
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
