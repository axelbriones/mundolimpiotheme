{**
 * Hero Section for Mundo Limpio Theme Homepage
 * Content is semi-static for now.
 *}
<section class="homepage-section hero-section" id="hero">
    <div class="container hero-container">
        <div class="hero-content">
            <div class="hero-text">
                <h1 class="hero-title">{l s='Mundo Limpio: Frescura y Cuidado Natural' d='Shop.Theme.Mundolimpio'}</h1>
                <p class="hero-subtitle">{l s='Descubre nuestra gama de productos ecológicos para un hogar saludable y un planeta feliz.' d='Shop.Theme.Mundolimpio'}</p>
                <div class="hero-buttons">
                    <a href="{$urls.pages.category nofilter}{* TODO: Add category ID or link to all products *}" class="btn btn-primary hero-btn ml-ripple-effect">
                        {l s='Explorar Productos' d='Shop.Theme.Actions'}
                    </a>
                    {* <a href="#" class="btn btn-outline-light hero-btn-secondary">{l s='Más Sobre Nosotros' d='Shop.Theme.Actions'}</a> *}
                </div>
            </div>
            <div class="hero-image">
                {* Placeholder - Reemplazar con una imagen real o configurable *}
                <img src="{$urls.theme_assets}img/placeholders/hero-placeholder-800x600.png" alt="{l s='Productos ecológicos de Mundo Limpio' d='Shop.Theme.Mundolimpio'}" class="hero-img lazyload">
                {* Ejemplo con imagen del tema: <img src="{$urls.theme_assets}img/hero-main.jpg" alt="..." > *}
            </div>
        </div>
    </div>
</section>
