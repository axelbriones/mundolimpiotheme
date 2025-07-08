{**
 * Banner CTA Section for Mundo Limpio Theme Homepage
 * Content is semi-static for now.
 *}
<section class="homepage-section banner-cta-section" id="cta-banner"> {* Esta sección se incluye dentro de un .container en index.tpl *}
    {* Ya no necesitamos un <div class="container banner-container"> aquí, el .container exterior lo maneja.
       Si se necesita un banner-container para estilos específicos, se puede mantener sin la clase 'container'. *}
    <div class="banner-content"> {* Default: text-left, image-right. Add class 'image-left' for reverse *}
            <div class="banner-text">
                <h2 class="banner-title">{l s='Únete a la Revolución Limpia' d='Shop.Theme.Mundolimpio'}</h2>
                <p class="banner-description">{l s='Suscríbete a nuestro boletín y obtén un 10% de descuento en tu primera compra, además de consejos para un estilo de vida más sostenible.' d='Shop.Theme.Mundolimpio'}</p>
                {* Ejemplo de un formulario de suscripción simple o un botón a una página de registro *}
                {* <form action="#" method="post" class="banner-form">
                    <input type="email" name="email" placeholder="{l s='Tu correo electrónico' d='Shop.Forms.Labels'}" required>
                    <button type="submit" class="btn btn-light banner-btn">{l s='Suscribirme' d='Shop.Theme.Actions'}</button>
                </form> *}
                 <a href="#" class="btn btn-light banner-btn ml-ripple-effect">{* TODO: Link to newsletter subscription or special offer page *}
                    {l s='Descubre Más y Ahorra' d='Shop.Theme.Actions'}
                </a>
            </div>
            <div class="banner-image">
                 {* Placeholder - Reemplazar con una imagen real o configurable *}
                <img src="{$urls.theme_assets}img/placeholders/banner-cta-600x400.png" alt="{l s='Promoción Mundo Limpio' d='Shop.Theme.Mundolimpio'}" class="banner-img lazyload">
            </div>
        </div>
    </div>
</section>
