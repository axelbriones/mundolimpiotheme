{**
 * Ecology Section for Mundo Limpio Theme Homepage
 * Content is semi-static for now.
 *}
<section class="homepage-section ecology-section" id="ecology">
    <div class="container">
        <div class="ecology-content"> {* Default: text-left, image-right. Add class 'image-left' for reverse *}
            <div class="ecology-text">
                <h2 class="ecology-title">{l s='Nuestro Pacto con el Planeta' d='Shop.Theme.Mundolimpio'}</h2>
                <p class="ecology-description">{l s='En Mundo Limpio, cada producto es un paso hacia un futuro más verde. Creemos en la transparencia, la responsabilidad y el poder de las elecciones conscientes.' d='Shop.Theme.Mundolimpio'}</p>
                <div class="ecology-items">
                    {assign var=ecology_points value=[
                        ['icon' => 'forest', 'text' => {l s='Ingredientes de Origen Sostenible' d='Shop.Theme.Mundolimpio'}],
                        ['icon' => 'recycling', 'text' => {l s='Empaques Eco-Amigables y Minimizados' d='Shop.Theme.Mundolimpio'}],
                        ['icon' => 'local_florist', 'text' => {l s='Libre de Crueldad Animal (Cruelty-Free)' d='Shop.Theme.Mundolimpio'}],
                        ['icon' => 'handshake', 'text' => {l s='Apoyo a Comunidades y Comercio Justo' d='Shop.Theme.Mundolimpio'}]
                    ]}
                    {foreach from=$ecology_points item=point name=ecologyLoop}
                        {* Assign the calculated delay to a variable first to ensure it's treated as a number before being outputted *}
                        {assign var="animation_delay" value=$smarty.foreach.ecologyLoop.iteration * 100}
                        <div class="ecology-item ml-animate-on-scroll anim-fadeInLeft" data-delay="{$animation_delay|escape:'htmlall':'UTF-8'}">
                            <i class="material-icons">{$point.icon|escape:'htmlall':'UTF-8'}</i>
                            <span>{$point.text|escape:'htmlall':'UTF-8'}</span>
                        </div>
                    {/foreach}
                </div>
                 <div class="ecology-button" style="margin-top: 25px;">
                    <a href="#" class="btn btn-primary ml-ripple-effect">{* TODO: Link to a page about sustainability efforts *}
                        {l s='Conoce Más Sobre Nuestro Impacto' d='Shop.Theme.Actions'}
                    </a>
                </div>
            </div>
            <div class="ecology-image ml-animate-on-scroll anim-fadeInRight">
                {* Placeholder - Reemplazar con una imagen real o configurable *}
                <img src="{$urls.theme_assets}img/placeholders/ecology-image-600x500.png" alt="{l s='Compromiso ecológico de Mundo Limpio' d='Shop.Theme.Mundolimpio'}" class="ecology-img lazyload">
            </div>
        </div>
    </div>
</section>
