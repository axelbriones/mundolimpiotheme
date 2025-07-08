{**
 * Products Section for Mundo Limpio Theme Homepage
 * Content is semi-static for now. Could display featured products or categories.
 *}
<section class="homepage-section products-section" id="products">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">{l s='Productos Estrella para un Mundo Limpio' d='Shop.Theme.Mundolimpio'}</h2>
            <p class="section-subtitle">{l s='Descubre nuestras soluciones más populares y efectivas para un hogar sostenible.' d='Shop.Theme.Mundolimpio'}</p>
        </div>

        {* Aquí podríamos usar un hook para un módulo como "Productos Destacados" (ps_featuredproducts)
           o podríamos codificar una lista de categorías o productos específicos.
           Por ahora, mostraremos un placeholder o un ejemplo de cómo se verían las categorías.
        *}

        {* Ejemplo: Mostrar algunas categorías principales *}
        <div class="categories-grid">
            {assign var=category_example_1 value=['name' => {l s='Limpieza del Hogar' d='Shop.Theme.Mundolimpio'}, 'image' => '{$urls.theme_assets}img/placeholders/category-hogar-400x300.png', 'link' => '#link-categoria-hogar', 'subcategories' => [{name:'Cocina', link:'#'}, {name:'Baño', link:'#'}]]}
            {assign var=category_example_2 value=['name' => {l s='Cuidado Personal' d='Shop.Theme.Mundolimpio'}, 'image' => '{$urls.theme_assets}img/placeholders/category-personal-400x300.png', 'link' => '#link-categoria-personal', 'subcategories' => [{name:'Jabones', link:'#'}, {name:'Champús', link:'#'}]]}
            {assign var=category_example_3 value=['name' => {l s='Bebés y Niños' d='Shop.Theme.Mundolimpio'}, 'image' => '{$urls.theme_assets}img/placeholders/category-bebes-400x300.png', 'link' => '#link-categoria-bebes', 'subcategories' => []]}

            {foreach from=[$category_example_1, $category_example_2, $category_example_3] item=category_item}
                <div class="category-card ml-animate-on-scroll anim-scaleIn">
                    <div class="category-image">
                        <a href="{$category_item.link nofilter}">
                            <img src="{$category_item.image nofilter}" alt="{$category_item.name|escape:'htmlall':'UTF-8'}" class="category-img lazyload">
                        </a>
                    </div>
                    <div class="category-content">
                        <h3 class="category-title"><a href="{$category_item.link nofilter}">{$category_item.name|escape:'htmlall':'UTF-8'}</a></h3>
                        {if $category_item.subcategories}
                            <div class="subcategories">
                                {foreach from=$category_item.subcategories item=subcategory}
                                    <a href="{$subcategory.link nofilter}" class="subcategory-link">{$subcategory.name|escape:'htmlall':'UTF-8'}</a>
                                {/foreach}
                            </div>
                        {/if}
                        <a href="{$category_item.link nofilter}" class="btn btn-outline category-btn">{l s='Ver Productos' d='Shop.Theme.Actions'}</a>
                    </div>
                </div>
            {/foreach}
        </div>

        {* Alternativamente, si quisieras usar el hook de productos destacados:
           {hook h='displayHomeTabContent'}
           O directamente:
           {widget name="ps_featuredproducts" hook="displayHome"}
        *}

        <div class="text-center" style="margin-top: 40px;">
             <a href="{$urls.pages.category nofilter}{* TODO: Link to main products/categories page *}" class="btn btn-primary btn-lg">
                {l s='Ver Todos los Productos' d='Shop.Theme.Actions'}
            </a>
        </div>

    </div>
</section>
