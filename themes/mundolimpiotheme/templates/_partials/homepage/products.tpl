{**
 * Products Section for Mundo Limpio Theme Homepage
 * Design based on React component.
 *}
<section class="homepage-section products-section" id="productos">
    <div class="section-header text-center mb-12 md:mb-16">
        <h2 class="font-montserrat font-bold text-3xl md:text-4xl text-corporate-blue mb-4">
            {l s='Nuestros Productos' d='Shop.Theme.Mundolimpio'}
        </h2>
        <p class="font-opensans text-lg md:text-xl text-gray-600 max-w-3xl mx-auto">
            {l s='Somos distribuidores especializados en productos de limpieza e higiene. Nos caracterizamos en la zona por brindar asistencia inmediata en la adquisición del producto correcto.' d='Shop.Theme.Mundolimpio'}
        </p>
    </div>

    {* --- Categorías Principales --- *}
    <div class="product-categories-slider mb-12 md:mb-16">
        <h3 class="font-montserrat font-semibold text-xl md:text-2xl text-corporate-blue mb-6 md:mb-8 text-center">
            {l s='Categorías Principales' d='Shop.Theme.Mundolimpio'}
        </h3>
        <div class="horizontal-scroll-wrapper">
            <div class="categories-scroll-content">
                {* Definición de datos para categorías *}
                {assign var='cat_limpieza_institucional_items' value=[
                    {l s="Desinfectantes industriales" d="Shop.Theme.Mundolimpio"},
                    {l s="Detergentes de alto rendimiento" d="Shop.Theme.Mundolimpio"},
                    {l s="Sistemas de limpieza profesional" d="Shop.Theme.Mundolimpio"},
                    {l s="Productos especializados por sector" d="Shop.Theme.Mundolimpio"}
                ]}
                {assign var='cat_higiene_institucional_items' value=[
                    {l s="Productos de higiene personal" d="Shop.Theme.Mundolimpio"},
                    {l s="Dispensadores y accesorios" d="Shop.Theme.Mundolimpio"},
                    {l s="Papel higiénico y toallas" d="Shop.Theme.Mundolimpio"},
                    {l s="Jabones y gel antibacterial" d="Shop.Theme.Mundolimpio"}
                ]}
                {assign var='cat_limpieza_hogarena_items' value=[
                    {l s="Detergentes para ropa" d="Shop.Theme.Mundolimpio"},
                    {l s="Productos multipropósito" d="Shop.Theme.Mundolimpio"},
                    {l s="Limpiadores especializados" d="Shop.Theme.Mundolimpio"},
                    {l s="Accesorios de limpieza" d="Shop.Theme.Mundolimpio"}
                ]}
                {assign var='cat_eco_friendly_items' value=[
                    {l s="Detergentes biodegradables" d="Shop.Theme.Mundolimpio"},
                    {l s="Limpiadores naturales" d="Shop.Theme.Mundolimpio"},
                    {l s="Productos sin químicos" d="Shop.Theme.Mundolimpio"},
                    {l s="Envases reciclables" d="Shop.Theme.Mundolimpio"}
                ]}
                {assign var='cat_equipos_accesorios_items' value=[
                    {l s="Máquinas de limpieza" d="Shop.Theme.Mundolimpio"},
                    {l s="Aspiradoras industriales" d="Shop.Theme.Mundolimpio"},
                    {l s="Herramientas de limpieza" d="Shop.Theme.Mundolimpio"},
                    {l s="Accesorios profesionales" d="Shop.Theme.Mundolimpio"}
                ]}
                {assign var='cat_servicios_especializados_items' value=[
                    {l s="Asesoramiento técnico" d="Shop.Theme.Mundolimpio"},
                    {l s="Capacitación en productos" d="Shop.Theme.Mundolimpio"},
                    {l s="Servicios de instalación" d="Shop.Theme.Mundolimpio"},
                    {l s="Mantenimiento preventivo" d="Shop.Theme.Mundolimpio"}
                ]}

                {assign var=product_categories value=[
                    ['title' => {l s="Limpieza Institucional" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Productos profesionales para empresas, instituciones y comercios" d="Shop.Theme.Mundolimpio"}, 'icon' => 'business', 'color_class' => 'bg-corporate-blue', 'items' => $cat_limpieza_institucional_items],
                    ['title' => {l s="Higiene Institucional" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Soluciones completas para mantener la higiene en espacios comerciales" d="Shop.Theme.Mundolimpio"}, 'icon' => 'opacity', 'color_class' => 'bg-corporate-green', 'items' => $cat_higiene_institucional_items],
                    ['title' => {l s="Limpieza Hogareña" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Todo lo que necesita para mantener su hogar impecable" d="Shop.Theme.Mundolimpio"}, 'icon' => 'home', 'color_class' => 'bg-blue-600', 'items' => $cat_limpieza_hogarena_items],
                    ['title' => {l s="Productos Eco-Friendly" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Línea sustentable para cuidar el medio ambiente" d="Shop.Theme.Mundolimpio"}, 'icon' => 'auto_awesome', 'color_class' => 'bg-green-600', 'items' => $cat_eco_friendly_items],
                    ['title' => {l s="Equipos y Accesorios" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Herramientas profesionales para limpieza" d="Shop.Theme.Mundolimpio"}, 'icon' => 'check_circle', 'color_class' => 'bg-gray-600', 'items' => $cat_equipos_accesorios_items],
                    ['title' => {l s="Servicios Especializados" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Asesoramiento y servicios personalizados" d="Shop.Theme.Mundolimpio"}, 'icon' => 'group', 'color_class' => 'bg-purple-600', 'items' => $cat_servicios_especializados_items]
                ]}

                {foreach from=$product_categories item=category name=catLoop}
                    <div class="category-slide-item">
                        <div class="category-card-product">
                            <div class="category-card-icon-header {$category.color_class|escape:'htmlall':'UTF-8'}">
                                <i class="material-icons">{$category.icon|escape:'htmlall':'UTF-8'}</i>
                                <h4 class="category-card-title">{$category.title|escape:'htmlall':'UTF-8'}</h4>
                            </div>
                            <div class="category-card-content">
                                <p class="category-card-description">{$category.description|escape:'htmlall':'UTF-8'}</p>
                                <ul class="category-card-items-list">
                                    {foreach from=$category.items item=item}
                                        <li>
                                            <span class="list-bullet"></span>
                                            {$item|escape:'htmlall':'UTF-8'}
                                        </li>
                                    {/foreach}
                                </ul>
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>

    {* --- Productos Destacados --- *}
    <div class="featured-products-slider mb-12 md:mb-12">
         <h3 class="font-montserrat font-semibold text-xl md:text-2xl text-corporate-blue mb-6 md:mb-8 text-center">
            {l s='Productos Destacados' d='Shop.Theme.Mundolimpio'}
        </h3>
        <div class="horizontal-scroll-wrapper">
            <div class="products-scroll-content">
                {* Definición de datos para productos destacados *}
                {assign var='prod1_features' value=[{l s="Uso profesional" d="Shop.Theme.Mundolimpio"}, {l s="Baja espuma" d="Shop.Theme.Mundolimpio"}, {l s="Limpieza profunda" d="Shop.Theme.Mundolimpio"}]}
                {assign var='prod2_features' value=[{l s="Acción rápida" d="Shop.Theme.Mundolimpio"}, {l s="Sin residuos" d="Shop.Theme.Mundolimpio"}, {l s="Eco-friendly" d="Shop.Theme.Mundolimpio"}]}
                {assign var='prod3_features' value=[{l s="Concentrado" d="Shop.Theme.Mundolimpio"}, {l s="Suave con las telas" d="Shop.Theme.Mundolimpio"}, {l s="Fragancia duradera" d="Shop.Theme.Mundolimpio"}]}
                {assign var='prod4_features' value=[{l s="100% natural" d="Shop.Theme.Mundolimpio"}, {l s="Biodegradable" d="Shop.Theme.Mundolimpio"}, {l s="Sin químicos" d="Shop.Theme.Mundolimpio"}]}
                {assign var='prod5_features' value=[{l s="Dispensadores incluidos" d="Shop.Theme.Mundolimpio"}, {l s="Refills económicos" d="Shop.Theme.Mundolimpio"}, {l s="Instalación gratis" d="Shop.Theme.Mundolimpio"}]}
                {assign var='prod6_features' value=[{l s="Alta potencia" d="Shop.Theme.Mundolimpio"}, {l s="Tanque grande" d="Shop.Theme.Mundolimpio"}, {l s="Filtro HEPA" d="Shop.Theme.Mundolimpio"}]}

                {assign var=featured_products_data value=[
                    ['name' => {l s="Jabón Líquido Baja Espuma" d="Shop.Theme.Mundolimpio"}, 'category' => {l s="Limpieza Profesional" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="FELIPRO - Aromas de Misiones" d="Shop.Theme.Mundolimpio"}, 'image' => "{$urls.theme_assets}img/placeholders/product-placeholder-300x300.png", 'features' => $prod1_features],
                    ['name' => {l s="Desinfectante Industrial" d="Shop.Theme.Mundolimpio"}, 'category' => {l s="Higiene" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Elimina 99.9% de virus y bacterias" d="Shop.Theme.Mundolimpio"}, 'image' => "{$urls.theme_assets}img/placeholders/product-placeholder-300x300.png", 'features' => $prod2_features],
                    ['name' => {l s="Detergente Concentrado" d="Shop.Theme.Mundolimpio"}, 'category' => {l s="Hogar" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Máxima eficacia en el lavado familiar" d="Shop.Theme.Mundolimpio"}, 'image' => "{$urls.theme_assets}img/placeholders/product-placeholder-300x300.png", 'features' => $prod3_features],
                    ['name' => {l s="Limpiador Multiusos Eco" d="Shop.Theme.Mundolimpio"}, 'category' => {l s="Sustentable" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Producto biodegradable para uso general" d="Shop.Theme.Mundolimpio"}, 'image' => "{$urls.theme_assets}img/placeholders/product-placeholder-300x300.png", 'features' => $prod4_features],
                    ['name' => {l s="Kit Higiene Completo" d="Shop.Theme.Mundolimpio"}, 'category' => {l s="Institucional" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Solución integral para baños comerciales" d="Shop.Theme.Mundolimpio"}, 'image' => "{$urls.theme_assets}img/placeholders/product-placeholder-300x300.png", 'features' => $prod5_features],
                    ['name' => {l s="Aspiradora Industrial" d="Shop.Theme.Mundolimpio"}, 'category' => {l s="Equipos" d="Shop.Theme.Mundolimpio"}, 'description' => {l s="Para limpieza profunda en espacios grandes" d="Shop.Theme.Mundolimpio"}, 'image' => "{$urls.theme_assets}img/placeholders/product-placeholder-300x300.png", 'features' => $prod6_features]
                ]}

                {foreach from=$featured_products_data item=product name=prodLoop}
                     <div class="product-slide-item">
                        <div class="product-card-featured">
                            <div class="product-card-image-container">
                                <img src="{$product.image|escape:'htmlall':'UTF-8'}" alt="{$product.name|escape:'htmlall':'UTF-8'}" class="product-card-image lazyload">
                            </div>
                            <div class="product-card-content">
                                <span class="product-card-category">{$product.category|escape:'htmlall':'UTF-8'}</span>
                                <h4 class="product-card-name">{$product.name|escape:'htmlall':'UTF-8'}</h4>
                                <p class="product-card-description">{$product.description|escape:'htmlall':'UTF-8'}</p>
                                <div class="product-card-features">
                                    {foreach from=$product.features item=feature}
                                        <span class="product-card-feature-tag">{$feature|escape:'htmlall':'UTF-8'}</span>
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>

    {* Call to action final de la sección de productos *}
    <div class="container">
        <div class="products-section-cta">
            <i class="material-icons cta-icon">auto_awesome</i> {* Sparkles icon *}
            <h3 class="cta-title">{l s='¿Necesita un producto específico?' d='Shop.Theme.Mundolimpio'}</h3>
            <p class="cta-description">
                {l s='Nuestro equipo de expertos le ayudará a encontrar exactamente lo que necesita. Brindamos asesoramiento general en el rubro y el negocio.' d='Shop.Theme.Mundolimpio'}
            </p>
            <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}" class="btn btn-primary cta-btn">
                {l s='Consultar Producto' d='Shop.Theme.Actions'}
            </a>
        </div>
    </div>
</section>
