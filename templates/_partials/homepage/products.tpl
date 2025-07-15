{**
 * Products Section for Mundo Limpio Theme Homepage
 * Based on Products.tsx.
 *}
<section id="productos" class="py-20 bg-corporate-gray">
  <div class="container mx-auto px-4">
    <div class="text-center mb-16">
      <h2 class="font-montserrat font-bold text-4xl text-corporate-blue mb-4">
        {l s='Nuestros Productos' d='Shop.Theme.Mundolimpio'}
      </h2>
      <p class="font-opensans text-xl text-gray-600 max-w-3xl mx-auto">
        {l s='Somos distribuidores especializados en productos de limpieza e higiene. Nos caracterizamos en la zona por brindar asistencia inmediata en la adquisición del producto correcto.' d='Shop.Theme.Mundolimpio'}
      </p>
    </div>

    <!-- Categorías principales en slider - 6 categorías -->
    <div class="mb-16">
      <h3 class="font-montserrat font-semibold text-2xl text-corporate-blue mb-8 text-center">
        {l s='Categorías Principales' d='Shop.Theme.Mundolimpio'}
      </h3>
      <div class="carousel">
        <div class="carousel-inner">
          {assign var=productCategories value=[
            ['title' => {l s='Limpieza Institucional' d='Shop.Theme.Mundolimpio'}, 'description' => {l s='Productos profesionales para empresas, instituciones y comercios' d='Shop.Theme.Mundolimpio'}, 'icon' => 'business', 'color' => 'bg-corporate-blue', 'items' => [{l s='Desinfectantes industriales' d='Shop.Theme.Mundolimpio'}, {l s='Detergentes de alto rendimiento' d='Shop.Theme.Mundolimpio'}, {l s='Sistemas de limpieza profesional' d='Shop.Theme.Mundolimpio'}, {l s='Productos especializados por sector' d='Shop.Theme.Mundolimpio'}]],
            ['title' => {l s='Higiene Institucional' d='Shop.Theme.Mundolimpio'}, 'description' => {l s='Soluciones completas para mantener la higiene en espacios comerciales' d='Shop.Theme.Mundolimpio'}, 'icon' => 'opacity', 'color' => 'bg-corporate-green', 'items' => [{l s='Productos de higiene personal' d='Shop.Theme.Mundolimpio'}, {l s='Dispensadores y accesorios' d='Shop.Theme.Mundolimpio'}, {l s='Papel higiénico y toallas' d='Shop.Theme.Mundolimpio'}, {l s='Jabones y gel antibacterial' d='Shop.Theme.Mundolimpio'}]],
            ['title' => {l s='Limpieza Hogareña' d='Shop.Theme.Mundolimpio'}, 'description' => {l s='Todo lo que necesita para mantener su hogar impecable' d='Shop.Theme.Mundolimpio'}, 'icon' => 'home', 'color' => 'bg-blue-600', 'items' => [{l s='Detergentes para ropa' d='Shop.Theme.Mundolimpio'}, {l s='Productos multipropósito' d='Shop.Theme.Mundolimpio'}, {l s='Limpiadores especializados' d='Shop.Theme.Mundolimpio'}, {l s='Accesorios de limpieza' d='Shop.Theme.Mundolimpio'}]],
            ['title' => {l s='Productos Eco-Friendly' d='Shop.Theme.Mundolimpio'}, 'description' => {l s='Línea sustentable para cuidar el medio ambiente' d='Shop.Theme.Mundolimpio'}, 'icon' => 'auto_awesome', 'color' => 'bg-green-600', 'items' => [{l s='Detergentes biodegradables' d='Shop.Theme.Mundolimpio'}, {l s='Limpiadores naturales' d='Shop.Theme.Mundolimpio'}, {l s='Productos sin químicos' d='Shop.Theme.Mundolimpio'}, {l s='Envases reciclables' d='Shop.Theme.Mundolimpio'}]],
            ['title' => {l s='Equipos y Accesorios' d='Shop.Theme.Mundolimpio'}, 'description' => {l s='Herramientas profesionales para limpieza' d='Shop.Theme.Mundolimpio'}, 'icon' => 'check_circle', 'color' => 'bg-gray-600', 'items' => [{l s='Máquinas de limpieza' d='Shop.Theme.Mundolimpio'}, {l s='Aspiradoras industriales' d='Shop.Theme.Mundolimpio'}, {l s='Herramientas de limpieza' d='Shop.Theme.Mundolimpio'}, {l s='Accesorios profesionales' d='Shop.Theme.Mundolimpio'}]],
            ['title' => {l s='Servicios Especializados' d='Shop.Theme.Mundolimpio'}, 'description' => {l s='Asesoramiento y servicios personalizados' d='Shop.Theme.Mundolimpio'}, 'icon' => 'group', 'color' => 'bg-purple-600', 'items' => [{l s='Asesoramiento técnico' d='Shop.Theme.Mundolimpio'}, {l s='Capacitación en productos' d='Shop.Theme.Mundolimpio'}, {l s='Servicios de instalación' d='Shop.Theme.Mundolimpio'}, {l s='Mantenimiento preventivo' d='Shop.Theme.Mundolimpio'}]]
          ]}
          {foreach from=$productCategories item=category}
            <div class="carousel-item">
              <div class="card border-0 shadow-lg hover:shadow-xl transition-all duration-300 overflow-hidden group h-full">
                <div class="{$category.color} p-6 text-white text-center">
                  <i class="material-icons w-12 h-12 mx-auto mb-2">{$category.icon}</i>
                  <h4 class="font-montserrat font-semibold text-lg">{$category.title}</h4>
                </div>
                <div class="card-body p-6">
                  <p class="font-opensans text-gray-600 mb-4 text-sm">
                    {$category.description}
                  </p>
                  <ul class="space-y-2">
                    {foreach from=$category.items item=item}
                      <li class="flex items-start">
                        <div class="w-2 h-2 bg-corporate-green rounded-full mt-2 mr-3 flex-shrink-0"></div>
                        <span class="font-opensans text-gray-700 text-sm">{$item}</span>
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

    <!-- Productos destacados en slider - 6 productos -->
    <div class="mb-12">
      <h3 class="font-montserrat font-semibold text-2xl text-corporate-blue mb-8 text-center">
        {l s='Productos Destacados' d='Shop.Theme.Mundolimpio'}
      </h3>
      <div class="carousel">
        <div class="carousel-inner">
          {assign var=featuredProducts value=[
            ['name' => {l s='Jabón Líquido Baja Espuma' d='Shop.Theme.Mundolimpio'}, 'category' => {l s='Limpieza Profesional' d='Shop.Theme.Mundolimpio'}, 'description' => {l s='FELIPRO - Aromas de Misiones' d='Shop.Theme.Mundolimpio'}, 'image' => '{$urls.img_url}lovable-uploads/a0c967e0-4070-4214-a8ac-86b3702c6c80.png', 'features' => [{l s='Uso profesional' d='Shop.Theme.Mundolimpio'}, {l s='Baja espuma' d='Shop.Theme.Mundolimpio'}, {l s='Limpieza profunda' d='Shop.Theme.Mundolimpio'}]],
            ['name' => {l s='Desinfectante Industrial' d='Shop.Theme.Mundolimpio'}, 'category' => {l s='Higiene' d='Shop.Theme.Mundolimpio'}, 'description' => {l s='Elimina 99.9% de virus y bacterias' d='Shop.Theme.Mundolimpio'}, 'image' => '{$urls.img_url}lovable-uploads/a0c967e0-4070-4214-a8ac-86b3702c6c80.png', 'features' => [{l s='Acción rápida' d='Shop.Theme.Mundolimpio'}, {l s='Sin residuos' d='Shop.Theme.Mundolimpio'}, {l s='Eco-friendly' d='Shop.Theme.Mundolimpio'}]],
            ['name' => {l s='Detergente Concentrado' d='Shop.Theme.Mundolimpio'}, 'category' => {l s='Hogar' d='Shop.Theme.Mundolimpio'}, 'description' => {l s='Máxima eficacia en el lavado familiar' d='Shop.Theme.Mundolimpio'}, 'image' => '{$urls.img_url}lovable-uploads/a0c967e0-4070-4214-a8ac-86b3702c6c80.png', 'features' => [{l s='Concentrado' d='Shop.Theme.Mundolimpio'}, {l s='Suave con las telas' d='Shop.Theme.Mundolimpio'}, {l s='Fragancia duradera' d='Shop.Theme.Mundolimpio'}]],
            ['name' => {l s='Limpiador Multiusos Eco' d='Shop.Theme.Mundolimpio'}, 'category' => {l s='Sustentable' d='Shop.Theme.Mundolimpio'}, 'description' => {l s='Producto biodegradable para uso general' d='Shop.Theme.Mundolimpio'}, 'image' => '{$urls.img_url}lovable-uploads/a0c967e0-4070-4214-a8ac-86b3702c6c80.png', 'features' => [{l s='100% natural' d='Shop.Theme.Mundolimpio'}, {l s='Biodegradable' d='Shop.Theme.Mundolimpio'}, {l s='Sin químicos' d='Shop.Theme.Mundolimpio'}]],
            ['name' => {l s='Kit Higiene Completo' d='Shop.Theme.Mundolimpio'}, 'category' => {l s='Institucional' d='Shop.Theme.Mundolimpio'}, 'description' => {l s='Solución integral para baños comerciales' d='Shop.Theme.Mundolimpio'}, 'image' => '{$urls.img_url}lovable-uploads/a0c967e0-4070-4214-a8ac-86b3702c6c80.png', 'features' => [{l s='Dispensadores incluidos' d='Shop.Theme.Mundolimpio'}, {l s='Refills económicos' d='Shop.Theme.Mundolimpio'}, {l s='Instalación gratis' d='Shop.Theme.Mundolimpio'}]],
            ['name' => {l s='Aspiradora Industrial' d='Shop.Theme.Mundolimpio'}, 'category' => {l s='Equipos' d='Shop.Theme.Mundolimpio'}, 'description' => {l s='Para limpieza profunda en espacios grandes' d='Shop.Theme.Mundolimpio'}, 'image' => '{$urls.img_url}lovable-uploads/a0c967e0-4070-4214-a8ac-86b3702c6c80.png', 'features' => [{l s='Alta potencia' d='Shop.Theme.Mundolimpio'}, {l s='Tanque grande' d='Shop.Theme.Mundolimpio'}, {l s='Filtro HEPA' d='Shop.Theme.Mundolimpio'}]]
          ]}
          {foreach from=$featuredProducts item=product}
            <div class="carousel-item">
              <div class="bg-white rounded-xl p-6 hover:shadow-lg transition-shadow h-full">
                <div class="w-full h-48 bg-gray-100 rounded-lg mb-4 overflow-hidden">
                  <img src="{$product.image}" alt="{$product.name}" class="w-full h-full object-contain" />
                </div>
                <span class="inline-block bg-corporate-green text-white text-xs px-2 py-1 rounded mb-2">
                  {$product.category}
                </span>
                <h4 class="font-montserrat font-medium text-lg text-corporate-blue mb-2">
                  {$product.name}
                </h4>
                <p class="font-opensans text-gray-600 text-sm mb-3">
                  {$product.description}
                </p>
                <div class="flex flex-wrap gap-1">
                  {foreach from=$product.features item=feature}
                    <span class="bg-blue-100 text-corporate-blue text-xs px-2 py-1 rounded">
                      {$feature}
                    </span>
                  {/foreach}
                </div>
              </div>
            </div>
          {/foreach}
        </div>
      </div>
    </div>

    <!-- Call to action -->
    <div class="bg-corporate-blue rounded-2xl p-8 text-center text-white">
      <i class="material-icons w-12 h-12 mx-auto mb-4 text-corporate-green">auto_awesome</i>
      <h3 class="font-montserrat font-semibold text-2xl mb-4">
        {l s='¿Necesita un producto específico?' d='Shop.Theme.Mundolimpio'}
      </h3>
      <p class="font-opensans mb-6 max-w-2xl mx-auto">
        {l s='Nuestro equipo de expertos le ayudará a encontrar exactamente lo que necesita. Brindamos asesoramiento general en el rubro y el negocio.' d='Shop.Theme.Mundolimpio'}
      </p>
      <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}" class="btn btn-primary bg-corporate-green hover:bg-green-600 text-white font-opensans font-medium px-8 py-3">
        {l s='Consultar Producto' d='Shop.Theme.Actions'}
      </a>
    </div>
  </div>
</section>
