{**
 * Index Template - Mundo Limpio Theme
 * Homepage completa con todas las secciones
 *}

{extends file='parent:index.tpl'}

{* Incluir Hero Section al inicio *}
{block name='page_content_top'}
  {include file='_partials/hero.tpl'}
{/block}

{* Contenido principal de la homepage *}
{block name='page_content'}
  {$smarty.block.parent}
  
  {* === CATEGORIES SECTION === *}
  <section class="categories-section py-16 bg-white" id="categorias">
    <div class="container mx-auto px-4 lg:px-6">
      <div class="text-center mb-12">
        <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
          Nuestras Categorías
        </h2>
        <p class="text-lg text-gray-600 max-w-2xl mx-auto">
          Encuentra la solución perfecta para cada necesidad de limpieza
        </p>
      </div>
      
      <div class="categories-grid grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        
        {* Limpieza del Hogar *}
        <div class="category-card group cursor-pointer">
          <div class="card bg-white rounded-2xl shadow-md hover:shadow-xl transition-all duration-300 overflow-hidden group-hover:scale-105">
            <div class="card-image relative h-48 bg-gradient-to-br from-green-400 to-green-600 flex items-center justify-center">
              <i class="material-icons text-6xl text-white">cleaning_services</i>
              <div class="absolute inset-0 bg-black opacity-0 group-hover:opacity-20 transition-opacity duration-300"></div>
            </div>
            <div class="card-body p-6">
              <h3 class="text-xl font-semibold text-gray-900 mb-2 group-hover:text-green-600 transition-colors">
                Limpieza del Hogar
              </h3>
              <p class="text-gray-600 mb-4">
                Productos especializados para mantener tu hogar impecable y libre de gérmenes.
              </p>
              <div class="flex items-center text-green-600 font-medium group-hover:translate-x-2 transition-transform">
                Ver productos
                <i class="material-icons ml-2">arrow_forward</i>
              </div>
            </div>
          </div>
        </div>

        {* Limpieza Industrial *}
        <div class="category-card group cursor-pointer">
          <div class="card bg-white rounded-2xl shadow-md hover:shadow-xl transition-all duration-300 overflow-hidden group-hover:scale-105">
            <div class="card-image relative h-48 bg-gradient-to-br from-blue-400 to-blue-600 flex items-center justify-center">
              <i class="material-icons text-6xl text-white">business</i>
              <div class="absolute inset-0 bg-black opacity-0 group-hover:opacity-20 transition-opacity duration-300"></div>
            </div>
            <div class="card-body p-6">
              <h3 class="text-xl font-semibold text-gray-900 mb-2 group-hover:text-blue-600 transition-colors">
                Limpieza Industrial
              </h3>
              <p class="text-gray-600 mb-4">
                Soluciones profesionales para empresas y espacios comerciales.
              </p>
              <div class="flex items-center text-blue-600 font-medium group-hover:translate-x-2 transition-transform">
                Ver productos
                <i class="material-icons ml-2">arrow_forward</i>
              </div>
            </div>
          </div>
        </div>

        {* Productos Eco-Friendly *}
        <div class="category-card group cursor-pointer">
          <div class="card bg-white rounded-2xl shadow-md hover:shadow-xl transition-all duration-300 overflow-hidden group-hover:scale-105">
            <div class="card-image relative h-48 bg-gradient-to-br from-purple-400 to-purple-600 flex items-center justify-center">
              <i class="material-icons text-6xl text-white">eco</i>
              <div class="absolute inset-0 bg-black opacity-0 group-hover:opacity-20 transition-opacity duration-300"></div>
            </div>
            <div class="card-body p-6">
              <h3 class="text-xl font-semibold text-gray-900 mb-2 group-hover:text-purple-600 transition-colors">
                Productos Eco-Friendly
              </h3>
              <p class="text-gray-600 mb-4">
                Limpieza responsable que cuida el medio ambiente y tu familia.
              </p>
              <div class="flex items-center text-purple-600 font-medium group-hover:translate-x-2 transition-transform">
                Ver productos
                <i class="material-icons ml-2">arrow_forward</i>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  {* === FEATURED PRODUCTS SECTION === *}
  <section class="featured-products py-16 bg-gray-50" id="productos-destacados">
    <div class="container mx-auto px-4 lg:px-6">
      <div class="text-center mb-12">
        <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
          Productos Destacados
        </h2>
        <p class="text-lg text-gray-600 max-w-2xl mx-auto">
          Descubre nuestra selección de productos más populares y efectivos
        </p>
      </div>
      
      <div class="products-grid">
        {* Hook para productos destacados de PrestaShop *}
        {hook h='displayHome'}
        
        {* Productos de ejemplo si no hay productos del hook *}
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {for $i=1 to 4}
            <div class="product-card group">
              <div class="card bg-white rounded-xl shadow-md hover:shadow-lg transition-all duration-300 overflow-hidden">
                <div class="product-image relative">
                  <div class="aspect-square bg-gray-200 flex items-center justify-center">
                    <i class="material-icons text-4xl text-gray-400">inventory_2</i>
                  </div>
                  <div class="product-badge absolute top-3 left-3 bg-green-500 text-white text-xs font-bold px-2 py-1 rounded-full">
                    ECO
                  </div>
                  <div class="product-actions absolute top-3 right-3 opacity-0 group-hover:opacity-100 transition-opacity">
                    <button class="action-btn w-8 h-8 bg-white rounded-full shadow-md flex items-center justify-center hover:bg-green-500 hover:text-white transition-colors mb-2">
                      <i class="material-icons text-sm">favorite_border</i>
                    </button>
                    <button class="action-btn w-8 h-8 bg-white rounded-full shadow-md flex items-center justify-center hover:bg-green-500 hover:text-white transition-colors">
                      <i class="material-icons text-sm">visibility</i>
                    </button>
                  </div>
                </div>
                <div class="product-info p-4">
                  <h3 class="product-name text-lg font-semibold text-gray-900 mb-2 group-hover:text-green-600 transition-colors">
                    Producto Eco-Friendly {$i}
                  </h3>
                  <p class="product-description text-gray-600 text-sm mb-3">
                    Descripción del producto sustentable para limpieza del hogar.
                  </p>
                  <div class="product-rating flex items-center mb-3">
                    {for $star=1 to 5}
                      <i class="material-icons text-yellow-400 text-sm">star</i>
                    {/for}
                    <span class="rating-count text-xs text-gray-500 ml-2">(24)</span>
                  </div>
                  <div class="product-price-cart flex items-center justify-between">
                    <div class="product-price">
                      <span class="current-price text-lg font-bold text-green-600">$1{$i}.99</span>
                      {if $i == 2}
                        <span class="old-price text-sm text-gray-400 line-through ml-2">$24.99</span>
                      {/if}
                    </div>
                    <button class="add-to-cart bg-green-600 hover:bg-green-700 text-white text-sm px-4 py-2 rounded-lg transition-colors">
                      <i class="material-icons text-sm mr-1">add_shopping_cart</i>
                      Agregar
                    </button>
                  </div>
                </div>
              </div>
            </div>
          {/for}
        </div>
      </div>
      
      <div class="text-center mt-12">
        <a href="{if isset($urls.pages.category)}{$urls.pages.category}{else}/categoria{/if}" 
           class="inline-flex items-center px-8 py-3 border-2 border-green-600 text-green-600 hover:bg-green-600 hover:text-white font-semibold rounded-full transition-all duration-200">
          Ver Todos los Productos
          <i class="material-icons ml-2">arrow_forward</i>
        </a>
      </div>
    </div>
  </section>

  {* === VALUES SECTION === *}
  <section class="values-section py-16 bg-white" id="valores">
    <div class="container mx-auto px-4 lg:px-6">
      <div class="text-center mb-12">
        <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
          Nuestros Valores
        </h2>
        <p class="text-lg text-gray-600 max-w-2xl mx-auto">
          Comprometidos con la excelencia, la sostenibilidad y la satisfacción del cliente
        </p>
      </div>
      
      <div class="values-grid grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
        <div class="value-item text-center group">
          <div class="value-icon w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4 group-hover:bg-green-500 group-hover:scale-110 transition-all duration-300">
            <i class="material-icons text-3xl text-green-600 group-hover:text-white transition-colors">eco</i>
          </div>
          <h3 class="value-title text-xl font-semibold text-gray-900 mb-2">
            Sustentabilidad
          </h3>
          <p class="value-description text-gray-600 text-sm">
            Productos 100% biodegradables que protegen el medio ambiente
          </p>
        </div>

        <div class="value-item text-center group">
          <div class="value-icon w-20 h-20 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4 group-hover:bg-blue-500 group-hover:scale-110 transition-all duration-300">
            <i class="material-icons text-3xl text-blue-600 group-hover:text-white transition-colors">high_quality</i>
          </div>
          <h3 class="value-title text-xl font-semibold text-gray-900 mb-2">
            Calidad Superior
          </h3>
          <p class="value-description text-gray-600 text-sm">
            Formulaciones avanzadas con ingredientes de primera calidad
          </p>
        </div>

        <div class="value-item text-center group">
          <div class="value-icon w-20 h-20 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-4 group-hover:bg-purple-500 group-hover:scale-110 transition-all duration-300">
            <i class="material-icons text-3xl text-purple-600 group-hover:text-white transition-colors">support_agent</i>
          </div>
          <h3 class="value-title text-xl font-semibold text-gray-900 mb-2">
            Asesoría Experta
          </h3>
          <p class="value-description text-gray-600 text-sm">
            Acompañamiento personalizado para encontrar la solución ideal
          </p>
        </div>

        <div class="value-item text-center group">
          <div class="value-icon w-20 h-20 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4 group-hover:bg-orange-500 group-hover:scale-110 transition-all duration-300">
            <i class="material-icons text-3xl text-orange-600 group-hover:text-white transition-colors">local_shipping</i>
          </div>
          <h3 class="value-title text-xl font-semibold text-gray-900 mb-2">
            Entrega Rápida
          </h3>
          <p class="value-description text-gray-600 text-sm">
            Envíos seguros y puntuales a toda la región
          </p>
        </div>
      </div>
    </div>
  </section>

  {* === STATISTICS SECTION === *}
  <section class="stats-section py-16 bg-gradient-to-r from-green-600 to-green-700 text-white" id="estadisticas">
    <div class="container mx-auto px-4 lg:px-6">
      <div class="stats-grid grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 text-center">
        <div class="stat-item">
          <div class="stat-number text-4xl md:text-5xl font-bold mb-2" data-counter="15">0</div>
          <div class="stat-label text-green-100 text-lg">Años de Experiencia</div>
        </div>
        
        <div class="stat-item">
          <div class="stat-number text-4xl md:text-5xl font-bold mb-2" data-counter="500">0</div>
          <div class="stat-label text-green-100 text-lg">Productos Eco-Friendly</div>
        </div>
        
        <div class="stat-item">
          <div class="stat-number text-4xl md:text-5xl font-bold mb-2" data-counter="10000">0</div>
          <div class="stat-label text-green-100 text-lg">Clientes Satisfechos</div>
        </div>
        
        <div class="stat-item">
          <div class="stat-number text-4xl md:text-5xl font-bold mb-2" data-counter="100">0</div>
          <div class="stat-label text-green-100 text-lg">% Biodegradable</div>
        </div>
      </div>
    </div>
  </section>

  {* === TESTIMONIALS SECTION === *}
  <section class="testimonials-section py-16 bg-green-50" id="testimonios">
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
        <div class="testimonial-card bg-white p-6 rounded-lg shadow-md hover:shadow-lg transition-shadow">
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

        <div class="testimonial-card bg-white p-6 rounded-lg shadow-md hover:shadow-lg transition-shadow">
          <div class="stars flex mb-4">
            {for $i=1 to 5}
              <i class="material-icons text-yellow-400">star</i>
            {/for}
          </div>
          <p class="text-gray-600 mb-4 italic">
            "Los productos son increíbles y el servicio al cliente es excepcional. Muy recomendado."
          </p>
          <div class="testimonial-author">
            <h4 class="font-semibold text-gray-900">Carlos Rodríguez</h4>
            <p class="text-sm text-gray-500">Cliente desde 2020</p>
          </div>
        </div>

        <div class="testimonial-card bg-white p-6 rounded-lg shadow-md hover:shadow-lg transition-shadow">
          <div class="stars flex mb-4">
            {for $i=1 to 5}
              <i class="material-icons text-yellow-400">star</i>
            {/for}
          </div>
          <p class="text-gray-600 mb-4 italic">
            "Perfecta combinación entre eficacia y respeto por el medio ambiente."
          </p>
          <div class="testimonial-author">
            <h4 class="font-semibold text-gray-900">Ana López</h4>
            <p class="text-sm text-gray-500">Cliente desde 2018</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  {* === CTA SECTION === *}
  <section class="cta-section py-16 bg-gray-50" id="cta">
    <div class="container mx-auto px-4 lg:px-6">
      <div class="cta-content bg-gradient-to-r from-green-500 to-green-600 rounded-2xl p-8 md:p-12 text-center text-white relative overflow-hidden">
        {* Background decoration *}
        <div class="absolute inset-0 opacity-10">
          <div class="absolute top-0 left-0 w-32 h-32 bg-white rounded-full -translate-x-1/2 -translate-y-1/2"></div>
          <div class="absolute bottom-0 right-0 w-24 h-24 bg-white rounded-full translate-x-1/2 translate-y-1/2"></div>
        </div>
        
        <div class="relative z-10">
          <h2 class="text-3xl md:text-4xl font-bold mb-4">
            ¿Listo para Cambiar a Productos Sustentables?
          </h2>
          <p class="text-xl text-green-100 mb-8 max-w-2xl mx-auto">
            Únete a miles de familias que ya eligieron cuidar su hogar y el planeta al mismo tiempo
          </p>
          <div class="cta-buttons flex flex-col sm:flex-row gap-4 justify-center">
            <a href="{if isset($urls.pages.category)}{$urls.pages.category}{else}/categoria{/if}" 
               class="inline-flex items-center px-8 py-3 bg-white text-green-600 hover:bg-gray-100 font-semibold rounded-full transition-all duration-200">
              <i class="material-icons mr-2">shopping_cart</i>
              Explorar Productos
            </a>
            <a href="{if isset($urls.pages.contact)}{$urls.pages.contact}{else}/contacto{/if}" 
               class="inline-flex items-center px-8 py-3 border-2 border-white text-white hover:bg-white hover:text-green-600 font-semibold rounded-full transition-all duration-200">
              <i class="material-icons mr-2">contact_support</i>
              Solicitar Asesoría
            </a>
          </div>
        </div>
      </div>
    </div>
  </section>
{/block}
