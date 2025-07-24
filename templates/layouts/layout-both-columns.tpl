{**
 * Layout Both Columns - Mundo Limpio Theme
 * Main layout template extending Classic theme
 *}

{extends file='layouts/layout-both-columns.tpl'}

{block name='head_charset'}
  <meta charset="utf-8">
{/block}

{block name='head_ie_compatibility'}
  <meta http-equiv="x-ua-compatible" content="ie=edge">
{/block}

{block name='head_seo'}
  {include file='_partials/head/_seo.tpl'}
{/block}

{block name='head_viewport'}
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
{/block}

{block name='head_icons'}
  {include file='_partials/head/_icons.tpl'}
{/block}

{block name='stylesheets'}
  {include file='_partials/head/_stylesheets.tpl'}
  
  {* Custom Theme Styles *}
  <link rel="stylesheet" href="{$theme_assets}css/theme.css" type="text/css" media="all">
  
  {* Google Fonts *}
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
  
  {* Material Icons *}
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  
  {* Font Awesome for social icons *}
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
{/block}

{block name='javascript_head'}
  {include file='_partials/head/_javascript.tpl'}
  
  {* Preload critical resources *}
  <link rel="preload" href="{$theme_assets}js/theme.js" as="script">
  <link rel="preload" href="{$theme_assets}img/hero-bg.jpg" as="image">
{/block}

{block name='hook_header'}
  {include file='partials/header.tpl'}
{/block}

{block name='product_activation'}
  {include file='catalog/_partials/product-activation.tpl'}
{/block}

{block name='body_classes'}
  {if $page.page_name}page-{$page.page_name|regex_replace:'/[^a-zA-Z0-9\-_]/' : ''}{/if} 
  {if $page.body_classes}{foreach $page.body_classes as $class} {$class}{/foreach}{/if}
  mundo-limpio-theme
{/block}

{block name='hook_body_opening'}
  {hook h='displayAfterBodyOpeningTag'}
{/block}

{block name='page_header_container'}
  {* Custom header is included in hook_header block *}
{/block}

{block name='page_content_container'}
  <main class="page-content" id="content-wrapper">
    
    {* Hero Section - Only on homepage *}
    {if $page.page_name == 'index'}
      {include file='partials/hero.tpl'}
    {/if}

    {* Page Content *}
    <div class="content-wrapper {if $page.page_name != 'index'}pt-8{/if}">
      <div class="container mx-auto px-4 lg:px-6">
        
        {block name='breadcrumb'}
          {if $page.page_name != 'index'}
            <nav class="breadcrumb-nav mb-8" aria-label="Breadcrumb">
              <ol class="flex items-center space-x-2 text-sm text-gray-600">
                <li>
                  <a href="{$urls.base_url}" class="hover:text-green-600 transition-colors">
                    <i class="material-icons text-sm mr-1">home</i>
                    Inicio
                  </a>
                </li>
                {foreach $breadcrumb.links as $path}
                  <li class="flex items-center">
                    <i class="material-icons text-xs mx-2 text-gray-400">chevron_right</i>
                    <a href="{$path.url}" class="hover:text-green-600 transition-colors">
                      {$path.title}
                    </a>
                  </li>
                {/foreach}
                {if $breadcrumb.current}
                  <li class="flex items-center">
                    <i class="material-icons text-xs mx-2 text-gray-400">chevron_right</i>
                    <span class="text-gray-800 font-medium">{$breadcrumb.current}</span>
                  </li>
                {/if}
              </ol>
            </nav>
          {/if}
        {/block}

        {block name='notifications'}
          {include file='_partials/notifications.tpl'}
        {/block}

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
          
          {* Left Column *}
          {block name='left_column'}
            {if $layout.left_column}
              <div class="left-column lg:col-span-3" id="left-column">
                <div class="space-y-6">
                  {hook h='displayLeftColumn'}
                </div>
              </div>
            {/if}
          {/block}

          {* Content Column *}
          {block name='content_wrapper'}
            <div class="content-column {if $layout.left_column && $layout.right_column}lg:col-span-6{elseif $layout.left_column || $layout.right_column}lg:col-span-9{else}lg:col-span-12{/if}">
              
              {block name='page_header'}
                {if $page.page_name != 'index' && isset($page.meta.title)}
                  <div class="page-header mb-8">
                    <h1 class="page-title text-3xl md:text-4xl font-bold text-gray-900 mb-4">
                      {$page.meta.title}
                    </h1>
                    {if isset($page.meta.description) && $page.meta.description}
                      <p class="page-description text-lg text-gray-600 leading-relaxed">
                        {$page.meta.description}
                      </p>
                    {/if}
                  </div>
                {/if}
              {/block}

              {block name='page_content_top'}
                {hook h='displayContentWrapperTop'}
              {/block}

              {block name='page_content'}
                <!-- Page content goes here -->
              {/block}

              {block name='page_content_bottom'}
                {hook h='displayContentWrapperBottom'}
              {/block}
            </div>
          {/block}

          {* Right Column *}
          {block name='right_column'}
            {if $layout.right_column}
              <div class="right-column lg:col-span-3" id="right-column">
                <div class="space-y-6">
                  {hook h='displayRightColumn'}
                </div>
              </div>
            {/if}
          {/block}
        </div>
      </div>
    </div>

    {* Additional Sections - Only on homepage *}
    {if $page.page_name == 'index'}
      
      {* Featured Products Section *}
      <section class="featured-products py-16 bg-gray-50" data-scroll-animation>
        <div class="container mx-auto px-4 lg:px-6">
          <div class="text-center mb-12">
            <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              Productos Destacados
            </h2>
            <p class="text-lg text-gray-600 max-w-2xl mx-auto">
              Descubre nuestra selección de productos de limpieza eco-friendly
            </p>
          </div>
          
          <div class="featured-products-grid">
            {hook h='displayHome'}
          </div>
        </div>
      </section>

      {* About Section *}
      <section class="about-section py-16" data-scroll-animation>
        <div class="container mx-auto px-4 lg:px-6">
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div class="about-content">
              <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-6">
                Comprometidos con el Medio Ambiente
              </h2>
              <p class="text-lg text-gray-600 mb-6 leading-relaxed">
                Desde 2008, hemos estado a la vanguardia de la limpieza sustentable, 
                ofreciendo productos que no solo mantienen tu hogar impecable, sino que 
                también protegen nuestro planeta.
              </p>
              <div class="about-features space-y-4">
                <div class="feature-item flex items-center">
                  <div class="feature-icon w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mr-4">
                    <i class="material-icons text-green-600">eco</i>
                  </div>
                  <div>
                    <h3 class="font-semibold text-gray-900">100% Biodegradables</h3>
                    <p class="text-gray-600 text-sm">Productos que se descomponen naturalmente</p>
                  </div>
                </div>
                <div class="feature-item flex items-center">
                  <div class="feature-icon w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mr-4">
                    <i class="material-icons text-green-600">forest</i>
                  </div>
                  <div>
                    <h3 class="font-semibold text-gray-900">Protección de la Selva</h3>
                    <p class="text-gray-600 text-sm">Contribuimos a preservar la selva misionera</p>
                  </div>
                </div>
                <div class="feature-item flex items-center">
                  <div class="feature-icon w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mr-4">
                    <i class="material-icons text-green-600">verified</i>
                  </div>
                  <div>
                    <h3 class="font-semibold text-gray-900">Calidad Certificada</h3>
                    <p class="text-gray-600 text-sm">Productos con certificaciones internacionales</p>
                  </div>
                </div>
              </div>
              <div class="about-cta mt-8">
                <a href="#" class="btn btn-primary">
                  Conoce Más Sobre Nosotros
                  <i class="material-icons ml-2">arrow_forward</i>
                </a>
              </div>
            </div>
            <div class="about-image">
              <div class="image-container relative">
                <img 
                  src="{$theme_assets}img/about-image.jpg" 
                  alt="Sobre Mundo Limpio" 
                  class="rounded-lg shadow-xl w-full h-auto"
                >
                <div class="image-overlay absolute inset-0 bg-gradient-to-t from-green-900/20 to-transparent rounded-lg"></div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {* Testimonials Section *}
      <section class="testimonials-section py-16 bg-green-50" data-scroll-animation>
        <div class="container mx-auto px-4 lg:px-6">
          <div class="text-center mb-12">
            <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              Lo que Dicen Nuestros Clientes
            </h2>
            <p class="text-lg text-gray-600 max-w-2xl mx-auto">
              La confianza de nuestros clientes es nuestro mayor logro
            </p>
          </div>
          
          <div class="testimonials-grid grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {* Sample testimonials - replace with dynamic content *}
            <div class="testimonial-card bg-white p-6 rounded-lg shadow-md">
              <div class="stars flex mb-4">
                {for $i=1 to 5}
                  <i class="material-icons text-yellow-400">star</i>
                {/for}
              </div>
              <p class="text-gray-600 mb-4 italic">
                "Excelente calidad y realmente notamos la diferencia en el cuidado del medio ambiente."
              </p>
              <div class="testimonial-author">
                <h4 class="font-semibold text-gray-900">María González</h4>
                <p class="text-sm text-gray-500">Cliente desde 2019</p>
              </div>
            </div>
          </div>
        </div>
      </section>
    {/if}
  </main>
{/block}

{block name='page_footer_container'}
  {include file='partials/footer.tpl'}
{/block}

{block name='javascript_bottom'}
  {include file='_partials/javascript.tpl'}
  
  {* Custom Theme JavaScript *}
  <script src="{$theme_assets}js/theme.js" defer></script>
  
  {* Schema.org structured data *}
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "{$shop.name}",
    "url": "{$urls.base_url}",
    "logo": "{if $shop.logo_details}{$shop.logo_details.src}{/if}",
    "description": "Soluciones sustentables para limpieza desde 2008. Productos eco-friendly que protegen el medio ambiente.",
    "foundingDate": "2008",
    "address": {
      "@type": "PostalAddress",
      "addressLocality": "Posadas",
      "addressRegion": "Misiones",
      "addressCountry": "AR"
    },
    "contactPoint": {
      "@type": "ContactPoint",
      "telephone": "+54-3764-123456",
      "contactType": "customer service",
      "availableLanguage": "Spanish"
    },
    "sameAs": [
      "https://facebook.com/mundolimpio",
      "https://instagram.com/mundolimpio"
    ]
  }
  </script>
{/block}

{block name='hook_before_body_closing_tag'}
  {hook h='displayBeforeBodyClosingTag'}
{/block}