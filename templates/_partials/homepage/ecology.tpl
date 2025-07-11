{**
 * Ecology Section for Mundo Limpio Theme Homepage
 * Design based on React component.
 *}
<section class="homepage-section ecology-section-alt" id="sustentabilidad"> {* id="sustentabilidad" y nueva clase para evitar conflicto con la anterior .ecology-section si aún existe *}
    <div class="container">
        <div class="section-header text-center mb-12 md:mb-16">
            <h2 class="font-montserrat font-bold text-3xl md:text-4xl text-corporate-blue mb-4">
                {l s='Responsabilidad Ecológica' d='Shop.Theme.Mundolimpio'}
            </h2>
            <p class="font-opensans text-lg md:text-xl text-gray-600 max-w-3xl mx-auto">
                {l s='Desde 2008 distribuimos productos sustentables comprometidos con el cuidado del medio ambiente y las generaciones futuras.' d='Shop.Theme.Mundolimpio'}
            </p>
        </div>

        {assign var=ecology_points_alt value=[
            ['icon' => 'eco', 'title' => {l s="Sustentables" d="Shop.Theme.Mundolimpio"}],
            ['icon' => 'recycling', 'title' => {l s="Biodegradables" d="Shop.Theme.Mundolimpio"}],
            ['icon' => 'favorite_border', 'title' => {l s="Eco-Responsables" d="Shop.Theme.Mundolimpio"}]
        ]}
        {* PS 1.7 Smarty compatible array assignment *}
        {assign var='point1' value=array('icon' => 'eco', 'title' => {l s="Sustentables" d="Shop.Theme.Mundolimpio"})}
        {assign var='point2' value=array('icon' => 'recycling', 'title' => {l s="Biodegradables" d="Shop.Theme.Mundolimpio"})}
        {assign var='point3' value=array('icon' => 'favorite_border', 'title' => {l s="Eco-Responsables" d="Shop.Theme.Mundolimpio"})}
        {assign var='ecology_points_alt_corrected' value=array($point1, $point2, $point3)}

        <div class="ecology-points-grid grid md:grid-cols-3 gap-8 max-w-4xl mx-auto">
            {foreach from=$ecology_points_alt_corrected item=point name=ecoPointLoop}
                {assign var="animation_delay" value=$smarty.foreach.ecoPointLoop.iteration * 100}
                <div class="ecology-point-item flex items-center space-x-3 md:space-x-4 ml-animate-on-scroll anim-fadeInUp" data-delay="{$animation_delay|escape:'htmlall':'UTF-8'}">
                    <div class="ecology-point-icon-wrapper">
                        <i class="material-icons">{$point.icon|escape:'htmlall':'UTF-8'}</i>
                    </div>
                    <div>
                        <h3 class="ecology-point-title font-montserrat font-semibold text-lg text-corporate-blue">
                            {$point.title|escape:'htmlall':'UTF-8'}
                        </h3>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</section>
