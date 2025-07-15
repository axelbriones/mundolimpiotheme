{**
 * Services Section for Mundo Limpio Theme Homepage
 * Based on Services.tsx.
 *}
<section id="servicios" class="py-24 bg-gradient-to-br from-corporate-gray via-gray-50 to-white relative overflow-hidden">
  <!-- Background decorative elements -->
  <div class="absolute inset-0">
    <div class="absolute top-20 left-10 w-40 h-40 bg-corporate-blue/5 rounded-full blur-3xl"></div>
    <div class="absolute bottom-20 right-10 w-60 h-60 bg-corporate-green/5 rounded-full blur-3xl"></div>
  </div>

  <div class="container mx-auto px-4 relative z-10">
    <div class="text-center mb-20">
      <div class="inline-block bg-corporate-blue/10 text-corporate-blue px-4 py-2 rounded-full text-sm font-montserrat font-medium mb-6">
        {l s='Nuestros Servicios' d='Shop.Theme.Mundolimpio'}
      </div>
      <h2 class="font-montserrat font-bold text-4xl lg:text-5xl text-corporate-blue mb-6 leading-tight">
        {l s='Soluciones Integrales' d='Shop.Theme.Mundolimpio'}
        <span class="block text-corporate-green">{l s='para su Negocio' d='Shop.Theme.Mundolimpio'}</span>
      </h2>
      <p class="font-opensans text-xl text-gray-600 max-w-4xl mx-auto leading-relaxed">
        {l s='Estamos capacitados para cubrir cualquier necesidad en productos y sistemas de limpieza institucional y hogareña, brindándole siempre una solución integral con compromiso ecológico desde 2008.' d='Shop.Theme.Mundolimpio'}
      </p>
    </div>

    <div class="grid md:grid-cols-3 gap-8 lg:gap-12">
      {assign var=services value=[
        [
          'icon' => 'group',
          'title' => {l s='Servicio Personalizado' d='Shop.Theme.Mundolimpio'},
          'description' => {l s='Asesoramiento experto y atención dedicada para encontrar la solución perfecta según sus necesidades específicas.' d='Shop.Theme.Mundolimpio'},
          'features' => [{l s='Consultoría personalizada' d='Shop.Theme.Mundolimpio'}, {l s='Análisis de necesidades' d='Shop.Theme.Mundolimpio'}, {l s='Soporte continuo' d='Shop.Theme.Mundolimpio'}]
        ],
        [
          'icon' => 'schedule',
          'title' => {l s='Soluciones Inmediatas' d='Shop.Theme.Mundolimpio'},
          'description' => {l s='Entregas rápidas y stock permanente para resolver sus problemas de limpieza e higiene sin demoras.' d='Shop.Theme.Mundolimpio'},
          'features' => [{l s='Entrega el mismo día' d='Shop.Theme.Mundolimpio'}, {l s='Stock permanente' d='Shop.Theme.Mundolimpio'}, {l s='Logística eficiente' d='Shop.Theme.Mundolimpio'}]
        ],
        [
          'icon' => 'check_circle',
          'title' => {l s='Responsabilidad Ecológica' d='Shop.Theme.Mundolimpio'},
          'description' => {l s='Priorizamos productos sustentables y amigables con el medio ambiente, cuidando la selva misionera.' d='Shop.Theme.Mundolimpio'},
          'features' => [{l s='Productos eco-friendly' d='Shop.Theme.Mundolimpio'}, {l s='Compromiso ambiental' d='Shop.Theme.Mundolimpio'}, {l s='Sustentabilidad' d='Shop.Theme.Mundolimpio'}]
        ]
      ]}

      {foreach from=$services item=service}
        <div class="card bg-white border-0 shadow-xl hover:shadow-2xl transition-all duration-500 group hover:-translate-y-2 relative overflow-hidden">
          <!-- Gradient overlay -->
          <div class="absolute inset-0 bg-gradient-to-br from-corporate-blue/5 to-corporate-green/5 opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>

          <div class="card-header text-center pb-6 relative z-10">
            <div class="w-20 h-20 bg-gradient-to-br from-corporate-blue to-blue-600 rounded-2xl flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform duration-300 shadow-lg">
              <i class="material-icons text-white" style="font-size: 40px;">{$service.icon}</i>
            </div>
            <h3 class="card-title font-montserrat font-bold text-2xl text-corporate-blue group-hover:text-corporate-green transition-colors duration-300">
              {$service.title}
            </h3>
          </div>
          <div class="card-body text-center px-8 pb-8 relative z-10">
            <p class="font-opensans text-gray-600 mb-8 text-lg leading-relaxed">
              {$service.description}
            </p>
            <div class="space-y-4">
              {foreach from=$service.features item=feature}
                <div class="flex items-center justify-center">
                  <i class="material-icons text-corporate-green mr-3 flex-shrink-0" style="font-size: 20px;">check_circle</i>
                  <span class="font-opensans text-gray-700 font-medium">{$feature}</span>
                </div>
              {/foreach}
            </div>
            <div class="mt-8 opacity-0 group-hover:opacity-100 transition-opacity duration-300">
              <a href="#" class="flex items-center justify-center text-corporate-blue font-montserrat font-semibold">
                {l s='Saber más' d='Shop.Theme.Actions'}
                <i class="material-icons ml-2 group-hover:translate-x-1 transition-transform duration-300" style="font-size: 16px;">arrow_forward</i>
              </a>
            </div>
          </div>
        </div>
      {/foreach}
    </div>

    <!-- Bottom CTA -->
    <div class="text-center mt-20">
      <p class="font-opensans text-lg text-gray-600 mb-6">
        {l s='¿Necesita una solución personalizada para su empresa?' d='Shop.Theme.Mundolimpio'}
      </p>
      <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}" class="inline-flex items-center text-corporate-blue font-montserrat font-semibold text-lg hover:text-corporate-green transition-colors duration-300 cursor-pointer">
        {l s='Contactar ahora mismo' d='Shop.Theme.Actions'}
        <i class="material-icons ml-2" style="font-size: 20px;">arrow_forward</i>
      </a>
    </div>
  </div>
</section>
