{**
 * Hero Section for Mundo Limpio Theme Homepage
 * Updated with new design from Hero.tsx.
 *}
<section id="inicio" class="relative min-h-screen flex items-center overflow-hidden">
  <!-- Gradient background -->
  <div class="absolute inset-0 bg-gradient-to-br from-corporate-blue via-blue-700 to-cyan-500"></div>

  <!-- Geometric shapes -->
  <div class="absolute inset-0">
    <div class="absolute top-20 left-10 w-32 h-32 bg-white/10 rounded-full blur-xl"></div>
    <div class="absolute bottom-20 right-10 w-48 h-48 bg-corporate-green/20 rounded-full blur-2xl"></div>
    <div class="absolute top-1/2 left-1/3 w-20 h-20 bg-white/5 transform rotate-45"></div>
  </div>

  <!-- Content -->
  <div class="container mx-auto px-4 relative z-10">
    <div class="grid lg:grid-cols-2 gap-12 items-center">
      <div class="text-white">
        <div class="animate-fade-in">
          <span class="inline-block bg-corporate-green/20 text-corporate-green px-4 py-2 rounded-full text-sm font-montserrat font-medium mb-6">
            {l s='Nueva Línea de Productos' d='Shop.Theme.Mundolimpio'}
          </span>

          <h1 class="font-montserrat font-bold text-5xl lg:text-6xl mb-6 leading-tight">
            {l s='Soluciones' d='Shop.Theme.Mundolimpio'}
            <span class="block text-corporate-green">{l s='Sustentables' d='Shop.Theme.Mundolimpio'}</span>
            {l s='para Limpieza' d='Shop.Theme.Mundolimpio'}
          </h1>

          <p class="font-opensans text-xl mb-8 text-blue-100 leading-relaxed max-w-2xl">
            {l s='Desde 2008 brindamos productos de limpieza e higiene con responsabilidad ecológica. Protegemos la selva misionera con soluciones sustentables y asesoramiento experto.' d='Shop.Theme.Mundolimpio'}
          </p>

          <div class="flex flex-col sm:flex-row gap-4">
            <a href="#productos" class="btn btn-primary bg-corporate-green hover:bg-green-600 text-white font-montserrat font-medium px-8 py-4">
              {l s='Ver Más' d='Shop.Theme.Actions'}
            </a>
            <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}" class="btn btn-secondary border-white hover:bg-white hover:text-corporate-blue font-montserrat font-medium px-8 py-4 text-white">
              {l s='Contactar Ahora' d='Shop.Theme.Actions'}
            </a>
          </div>
        </div>
      </div>

      <div class="relative flex justify-center items-center">
        <div class="relative">
          <!-- Product showcase -->
          <div class="bg-white/10 backdrop-blur-sm rounded-3xl p-8 border border-white/20">
            <img src="{$urls.img_url}lovable-uploads/a0c967e0-4070-4214-a8ac-86b3702c6c80.png" alt="{l s='Productos de limpieza sustentables' d='Shop.Theme.Mundolimpio'}" class="w-80 h-80 object-contain mx-auto" />
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
