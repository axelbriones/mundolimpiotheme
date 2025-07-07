<!-- Products Section Template -->
<section class="products-section" id="products-{$section.section_id|escape:'htmlall':'UTF-8'}">
    <div class="container">
        <div class="section-header">
            {if isset($section.title) && $section.title}
                <h2 class="section-title">{$section.title|escape:'htmlall':'UTF-8'}</h2>
            {elseif isset($section.products_list_title) && $section.products_list_title}
                 <h2 class="section-title">{$section.products_list_title|escape:'htmlall':'UTF-8'}</h2>
            {else}
                <h2 class="section-title">{l s='Our Products' d='Modules.Customthemebuilder.Shop'}</h2>
            {/if}

            {if isset($section.content) && $section.content}
                <p class="section-subtitle">{$section.content|escape:'htmlall':'UTF-8'}</p>
            {else}
                 <p class="section-subtitle">{l s='Explore our categories or featured products' d='Modules.Customthemebuilder.Shop'}</p>
            {/if}
        </div>

        {* Option to display categories or products based on config *}
        {if isset($section.config.display_type_products) && $section.config.display_type_products == 'categories' && isset($section.categories_list) && $section.categories_list}
            <div class="categories-grid columns-{$section.config.columns_categories|default:3|escape:'htmlall':'UTF-8'}">
                {foreach from=$section.categories_list item=category_item}
                    {if $category_item.active}
                    <div class="category-card">
                        <div class="category-image">
                            {assign var=categoryImage value=$link->getCatImageLink($category_item.link_rewrite, $category_item.id_category, 'category_default')}
                            <a href="{$link->getCategoryLink($category_item.id_category, $category_item.link_rewrite)|escape:'htmlall':'UTF-8'}">
                                <img src="{$categoryImage|escape:'htmlall':'UTF-8'}" alt="{$category_item.name|escape:'htmlall':'UTF-8'}" class="category-img lazyload" loading="lazy">
                            </a>
                        </div>
                        <div class="category-content">
                            <h3 class="category-title">
                                <a href="{$link->getCategoryLink($category_item.id_category, $category_item.link_rewrite)|escape:'htmlall':'UTF-8'}">
                                    {$category_item.name|escape:'htmlall':'UTF-8'}
                                </a>
                            </h3>

                            {if isset($section.config.show_subcategories_products) && $section.config.show_subcategories_products && isset($category_item.children) && $category_item.children}
                                <div class="subcategories">
                                    {foreach from=$category_item.children item=subcategory_item name=subcatloop}
                                        {if $smarty.foreach.subcatloop.iteration <= ($section.config.max_subcategories_products|default:3)}
                                        <a href="{$link->getCategoryLink($subcategory_item.id_category, $subcategory_item.link_rewrite)|escape:'htmlall':'UTF-8'}" class="subcategory-link">
                                            {$subcategory_item.name|escape:'htmlall':'UTF-8'}
                                        </a>
                                        {/if}
                                    {/foreach}
                                </div>
                            {/if}
                            <a href="{$link->getCategoryLink($category_item.id_category, $category_item.link_rewrite)|escape:'htmlall':'UTF-8'}" class="btn btn-outline category-btn">
                                {l s='View Category' d='Modules.Customthemebuilder.Shop'}
                            </a>
                        </div>
                    </div>
                    {/if}
                {/foreach}
            </div>
        {elseif isset($section.products_list) && $section.products_list}
            {* Display products in a grid - This requires product_item.tpl or similar *}
            <div class="products-grid">
                {include file='module:customthemebuilder/views/templates/hook/_partials/product_grid.tpl' products=$section.products_list}
            </div>
             {if isset($section.button_text) && $section.button_text && isset($section.button_link) && $section.button_link}
                <div class="text-center section-footer-link">
                    <a href="{$section.button_link|escape:'htmlall':'UTF-8'}" class="btn btn-primary">
                        {$section.button_text|escape:'htmlall':'UTF-8'}
                    </a>
                </div>
            {/if}
        {else}
            <p class="text-center">{l s='No products or categories to display at the moment.' d='Modules.Customthemebuilder.Shop'}</p>
        {/if}
    </div>
</section>
