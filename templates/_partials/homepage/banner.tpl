{**
 * Banner Section for Mundo Limpio Theme Homepage
 * Design based on React component: "Clorotec vs. Cloro líquido"
 *}
<section class="homepage-section banner-details-section" id="banner-clorotec">
    <div class="section-header text-center mb-12 md:mb-16">
        <h2 class="font-montserrat font-bold text-3xl md:text-4xl text-corporate-blue mb-4">
            {l s='Clorotec vs. Cloro líquido' d='Shop.Theme.Mundolimpio'}
        </h2>
        <p class="font-opensans text-lg md:text-xl text-gray-600 max-w-2xl mx-auto">
            {l s='Te contamos los beneficios sobre el cloro sólido y por qué tenés que elegirlo a la hora de cuidar el agua de tu pileta.' d='Shop.Theme.Mundolimpio'}
        </p>
    </div>

    {assign var=banner_features value=[
        ['icon' => 'opacity', 'title' => {l s="NO MANCHA" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Cuida tu pileta sin dañar las prendas" d="Shop.Theme.Mundolimpio"}, 'icon_bg_color_class' => 'bg-blue-100', 'icon_text_color_class' => 'text-corporate-blue'],
        ['icon' => 'wb_sunny', 'title' => {l s="MÁS RESISTENTE" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Al sol y a las altas temperaturas" d="Shop.Theme.Mundolimpio"}, 'icon_bg_color_class' => 'bg-yellow-100', 'icon_text_color_class' => 'text-yellow-600'],
        ['icon' => 'shield', 'title' => {l s="MÁS SEGURO" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="De transportar y almacenar" d="Shop.Theme.Mundolimpio"}, 'icon_bg_color_class' => 'bg-green-100', 'icon_text_color_class' => 'text-corporate-green'],
        ['icon' => 'add_circle_outline', 'title' => {l s="MÁS DURADERO" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="2 años de validez" d="Shop.Theme.Mundolimpio"}, 'icon_bg_color_class' => 'bg-purple-100', 'icon_text_color_class' => 'text-purple-600']
    ]}

    <div class="banner-features-grid grid md:grid-cols-4 gap-8 mb-12 md:mb-16">
        {foreach from=$banner_features item=feature}
            <div class="feature-item text-center ml-animate-on-scroll anim-fadeInUp">
                <div class="feature-icon-wrapper {$feature.icon_bg_color_class|escape:'htmlall':'UTF-8'}">
                    <i class="material-icons {$feature.icon_text_color_class|escape:'htmlall':'UTF-8'}">{$feature.icon|escape:'htmlall':'UTF-8'}</i>
                </div>
                <h3 class="feature-title font-montserrat font-semibold text-lg text-corporate-blue mb-2">
                    {$feature.title|escape:'htmlall':'UTF-8'}
                </h3>
                <p class="feature-description font-opensans text-gray-600 text-sm">
                    {$feature.description|escape:'htmlall':'UTF-8'}
                </p>
            </div>
        {/foreach}
    </div>

    <div class="banner-cta-highlight">
        <h3 class="cta-highlight-title font-montserrat font-bold text-xl md:text-2xl mb-4">
            {l s='Mantener el agua de tu pile siempre limpia y sana es:' d='Shop.Theme.Mundolimpio'}
        </h3>
        {assign var=highlight_points value=[
            {l s="Más simple" d="Shop.Theme.Mundolimpio"},
            {l s="Más económico" d="Shop.Theme.Mundolimpio"},
            {l s="Más sustentable" d="Shop.Theme.Mundolimpio"}
        ]}
        <div class="highlight-points-grid grid md:grid-cols-3 gap-4 md:gap-6 mb-6 md:mb-8">
            {foreach from=$highlight_points item=point}
                <div class="highlight-point flex items-center justify-center space-x-2">
                    <div class="highlight-bullet">
                        <span class="bullet-checkmark">✓</span>
                    </div>
                    <span class="font-montserrat font-medium">{$point|escape:'htmlall':'UTF-8'}</span>
                </div>
            {/foreach}
        </div>
        <a href="#" class="btn btn-primary banner-cta-button ml-ripple-effect">
            {l s='Ver Productos para Piscinas' d='Shop.Theme.Actions'}
        </a>
    </div>
</section>
