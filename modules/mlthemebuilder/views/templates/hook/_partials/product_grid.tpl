{* Partial template for displaying a grid of products *}
{* Expects an array $products, where each product is an object/array from Product Presenter *}

{if isset($products) && $products|count > 0}
    <div class="row product_list grid"> {* Assuming Bootstrap grid, adjust if using custom grid *}
        {foreach from=$products item="product_item_data" name=productloop}
            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3"> {* Adjust column classes as needed *}
                <article class="product-miniature js-product-miniature" data-id-product="{$product_item_data.id_product|escape:'htmlall':'UTF-8'}" data-id-product-attribute="{$product_item_data.id_product_attribute|escape:'htmlall':'UTF-8'}">
                    <div class="thumbnail-container">
                        <a href="{$product_item_data.url|escape:'htmlall':'UTF-8'}" class="thumbnail product-thumbnail">
                            <img
                                src="{$product_item_data.cover.bySize.home_default.url|escape:'htmlall':'UTF-8'}"
                                alt="{$product_item_data.cover.legend|escape:'htmlall':'UTF-8'}"
                                data-full-size-image-url="{$product_item_data.cover.large.url|escape:'htmlall':'UTF-8'}"
                                class="lazyload"
                                loading="lazy"
                                width="{$product_item_data.cover.bySize.home_default.width|escape:'htmlall':'UTF-8'}"
                                height="{$product_item_data.cover.bySize.home_default.height|escape:'htmlall':'UTF-8'}"
                            >
                        </a>

                        {if $product_item_data.show_price}
                            {if $product_item_data.has_discount}
                                <ul class="product-flags">
                                    {foreach from=$product_item_data.flags item=flag}
                                        <li class="product-flag {$flag.type|escape:'htmlall':'UTF-8'}">{$flag.label|escape:'htmlall':'UTF-8'}</li>
                                    {/foreach}
                                </ul>
                            {/if}
                        {/if}
                    </div>

                    <div class="product-description">
                        <h5 class="h3 product-title" itemprop="name"><a href="{$product_item_data.url|escape:'htmlall':'UTF-8'}">{$product_item_data.name|truncate:30:'...'|escape:'htmlall':'UTF-8'}</a></h5>

                        {if $product_item_data.show_price}
                            <div class="product-price-and-shipping">
                                {if $product_item_data.has_discount}
                                    {hook h='displayProductPriceBlock' product=$product_item_data type="old_price"}
                                    <span class="regular-price">{$product_item_data.regular_price|escape:'htmlall':'UTF-8'}</span>
                                {/if}

                                {hook h='displayProductPriceBlock' product=$product_item_data type="before_price"}
                                <span class="price">{$product_item_data.price|escape:'htmlall':'UTF-8'}</span>
                                {hook h='displayProductPriceBlock' product=$product_item_data type='unit_price'}
                                {hook h='displayProductPriceBlock' product=$product_item_data type='weight'}
                            </div>
                        {/if}
                    </div>

                    {* Quick view, add to cart, etc. can be added here if needed, similar to PrestaShop's product-miniature.tpl *}
                    {* Example for Add to Cart (simplified) *}
                    {if $product_item_data.add_to_cart_url}
                        <div class="product-add-to-cart text-center">
                            <form action="{$urls.pages.cart|escape:'htmlall':'UTF-8'}" method="post">
                                <input type="hidden" name="token" value="{$static_token|escape:'htmlall':'UTF-8'}">
                                <input type="hidden" name="id_product" value="{$product_item_data.id_product|escape:'htmlall':'UTF-8'}">
                                <input type="number" name="qty" value="1" min="1" style="display:none;">
                                <button class="btn btn-primary add-to-cart-btn" data-button-action="add-to-cart" type="submit" {if !$product_item_data.available_for_order || $product_item_data.quantity <= 0}disabled{/if}>
                                    <i class="material-icons">shopping_cart</i> {l s='Add to cart' d='Shop.Theme.Actions'}
                                </button>
                            </form>
                        </div>
                    {/if}

                </article>
            </div>
        {/foreach}
    </div>
{else}
    <p class="alert alert-info">{l s='No products found for this selection.' d='Modules.Mlthemebuilder.Shop'}</p>
{/if}

<style type="text/css">
/* Basic styling for product grid items - can be expanded in front.css */
.product_list.grid .product-miniature {
    border: 1px solid #e0e0e0;
    border-radius: var(--ml-border-radius-cards, 8px);
    padding: 15px;
    margin-bottom: 20px;
    text-align: center;
    background-color: #fff;
    transition: box-shadow 0.3s ease;
}
.product_list.grid .product-miniature:hover {
    box-shadow: var(--ml-shadow, 0 5px 15px rgba(0,0,0,0.1));
}
.product_list.grid .thumbnail-container {
    margin-bottom: 10px;
    position: relative; /* For flags */
}
.product_list.grid .product-thumbnail img {
    max-width: 100%;
    height: auto;
    border-radius: 4px;
}
.product_list.grid .product-title {
    font-size: calc(var(--ml-base-font-size, 16px) * 1.1);
    font-weight: 600;
    margin-bottom: 8px;
    min-height: 2.4em; /* Ensure consistent height for titles */
}
.product_list.grid .product-title a {
    color: var(--ml-text-color, #333);
    text-decoration: none;
}
.product_list.grid .product-title a:hover {
    color: var(--ml-link-color, var(--ml-primary-color, #667eea));
}
.product_list.grid .product-price-and-shipping .price {
    font-weight: bold;
    color: var(--ml-primary-color, #667eea);
    font-size: calc(var(--ml-base-font-size, 16px) * 1.2);
}
.product_list.grid .regular-price {
    text-decoration: line-through;
    color: #999;
    font-size: calc(var(--ml-base-font-size, 16px) * 0.9);
    margin-right: 5px;
}
.product_list.grid .product-flags {
    position: absolute;
    top: 5px;
    left: 5px;
    list-style: none;
    padding: 0;
    margin: 0;
    z-index: 1;
}
.product_list.grid .product-flag {
    background-color: var(--ml-secondary-color, #ff6b6b);
    color: white;
    padding: 3px 8px;
    font-size: 0.8em;
    border-radius: 3px;
    margin-bottom: 3px;
    display: inline-block;
}
.product_list.grid .product-flag.on-sale { background-color: #28a745; } /* Green for sale */
.product_list.grid .product-flag.new { background-color: #17a2b8; } /* Blue for new */

.product_list.grid .product-add-to-cart {
    margin-top: 15px;
}
.product_list.grid .add-to-cart-btn {
    font-size: 0.9em;
    padding: 8px 15px;
}
.product_list.grid .add-to-cart-btn .material-icons {
    font-size: 1.2em;
    vertical-align: middle;
    margin-right: 5px;
}
</style>
