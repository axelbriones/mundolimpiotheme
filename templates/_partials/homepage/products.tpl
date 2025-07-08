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
        {* Smarty 3 syntax for associative arrays within assign is `foo=[bar=>'baz']` or more complexly, build step-by-step.
           For simplicity with complex structures directly in template, consider JSON and then `json_decode` if really needed,
           or better, prepare in PHP if this were a module.
           Here, we'll define them more simply for direct use.
        *}
        <div class="categories-grid">
            {$category_example_1_name = {l s='Limpieza del Hogar' d='Shop.Theme.Mundolimpio'}}
            {$category_example_1_image = "`$urls.theme_assets`img/placeholders/category-hogar-400x300.png"}
            {$category_example_1_link = "#link-categoria-hogar"}
            {$category_example_1_subcategories = [
                ['name' => {l s='Cocina' d='Shop.Theme.Mundolimpio'}, 'link' => '#'],
                ['name' => {l s='Baño' d='Shop.Theme.Mundolimpio'}, 'link' => '#']
            ]}

            {$category_example_2_name = {l s='Cuidado Personal' d='Shop.Theme.Mundolimpio'}}
            {$category_example_2_image = "`$urls.theme_assets`img/placeholders/category-personal-400x300.png"}
            {$category_example_2_link = "#link-categoria-personal"}
            {$category_example_2_subcategories = [
                ['name' => {l s='Jabones' d='Shop.Theme.Mundolimpio'}, 'link' => '#'],
                ['name' => {l s='Champús' d='Shop.Theme.Mundolimpio'}, 'link' => '#']
            ]}

            {$category_example_3_name = {l s='Bebés y Niños' d='Shop.Theme.Mundolimpio'}}
            {$category_example_3_image = "`$urls.theme_assets`img/placeholders/category-bebes-400x300.png"}
            {$category_example_3_link = "#link-categoria-bebes"}
            {$category_example_3_subcategories = []}

            {* Now create an array of these structures *}
            {assign var="category_examples" value=[
                [
                    'name' => $category_example_1_name,
                    'image' => $category_example_1_image,
                    'link' => $category_example_1_link,
                    'subcategories' => $category_example_1_subcategories
                ],
                [
                    'name' => $category_example_2_name,
                    'image' => $category_example_2_image,
                    'link' => $category_example_2_link,
                    'subcategories' => $category_example_2_subcategories
                ],
                [
                    'name' => $category_example_3_name,
                    'image' => $category_example_3_image,
                    'link' => $category_example_3_link,
                    'subcategories' => $category_example_3_subcategories
                ]
            ]}

            {foreach from=$category_examples item=category_item}
                <div class="category-card ml-animate-on-scroll anim-scaleIn">
                    <div class="category-image">
                        <a href="{$category_item.link|escape:'htmlall':'UTF-8'}">
                            <img src="{$category_item.image|escape:'htmlall':'UTF-8'}" alt="{$category_item.name|escape:'htmlall':'UTF-8'}" class="category-img lazyload">
                        </a>
                    </div>
                    <div class="category-content">
                        <h3 class="category-title"><a href="{$category_item.link|escape:'htmlall':'UTF-8'}">{$category_item.name|escape:'htmlall':'UTF-8'}</a></h3>
                        {if $category_item.subcategories}
                            <div class="subcategories">
                                {foreach from=$category_item.subcategories item=subcategory}
                                    <a href="{$subcategory.link|escape:'htmlall':'UTF-8'}" class="subcategory-link">{$subcategory.name|escape:'htmlall':'UTF-8'}</a>
                                {/foreach}
                            </div>
                        {/if}
                        <a href="{$category_item.link|escape:'htmlall':'UTF-8'}" class="btn btn-outline category-btn">{l s='Ver Productos' d='Shop.Theme.Actions'}</a>
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
