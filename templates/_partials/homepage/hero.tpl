{**
 * Hero Section - Mundo Limpio Theme
 * Sección hero principal con el texto solicitado
 *}

<section class="hero-section relative min-h-screen flex items-center justify-center overflow-hidden">
  
  {* === BACKGROUND IMAGE WITH OVERLAY === *}
  <div class="hero-background absolute inset-0 z-0">
    <div class="hero-image absolute inset-0 bg-cover bg-center bg-no-repeat" 
         style="background-image: url('{if isset($theme_assets) && $theme_assets}{$theme_assets}{else}/themes/mundolimpiotheme/assets/{/if}img/hero-bg.jpg');">
    </div>
    
    {* Gradient Overlay *}
    <div class="hero-overlay absolute inset-0 bg-gradient-to-r from-green-900/80 via-green-800/70 to-green-700/60"></div>
    
    {* Animated Particles Background *}
    <div class="hero-particles absolute inset-0 opacity-20 pointer-events-none">
      <div class="particle absolute w-2 h-2 bg-white rounded-full animate-float-1"></div>
      <div class="particle absolute w-1 h-1 bg-white rounded-full animate-float-2"></div>
      <div class="particle absolute w-3 h-3 bg-white rounded-full animate-float-3"></div>
      <div class="particle absolute w-1 h-1 bg-white rounded-full animate-float-4"></div>
      <div class="particle absolute w-2 h-2 bg-white rounded-full animate-float-5"></div>
    </div>
  </div>

  {* === HERO CONTENT === *}
  <div class="hero-content relative z-10 container mx-auto px-4 lg:px-6 text-center">
    <div class="max-w-4xl mx-auto">
      
      {* Main Title - TEXTO SOLICITADO *}
      <h1 class="hero-title text-4xl md:text-5xl lg:text-6xl xl:text-7xl font-bold text-white mb-6 leading-tight">
        <span class="block opacity-0 transform translate-y-8 animate-fade-in-up">
          <span class="text-green-300">Soluciones</span>
        </span>
        <span class="block opacity-0 transform translate-y-8 animate-fade-in-up animation-delay-200">
          <span class="text-green-200">Sustentables</span>
        </span>
        <span class="block opacity-0 transform translate-y-8 animate-fade-in-up animation-delay-400">
          para <span class="text-white">Limpieza</span>
        </span>
      </h1>

      {* Description - TEXTO SOLICITADO *}
      <p class="hero-description text-lg md:text-xl lg:text-2xl text-gray-200 mb-8 max-w-3xl mx-auto leading-relaxed opacity-0 transform translate-y-8 animate-fade-in-up animation-delay-600">
        Desde 2008 brindamos productos de limpieza e higiene con responsabilidad ecológica. 
        Protegemos la selva misionera con soluciones sustentables y asesoramiento experto.
      </p>

      {* Call to Action Button - TEXTO SOLICITADO *}
      <div class="hero-cta opacity-0 transform translate-y-8 animate-fade-in-up animation-delay-800">
        <a href="{if isset($urls.pages.contact)}{$urls.pages.contact}{else}/contacto{/if}" 
           class="cta-button inline-flex items-center px-8 py-4 bg-green-500 hover:bg-green-400 text-white font-semibold text-lg rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300 group">
          <span class="mr-3">Contáctanos Ahora</span>
          <i class="material-icons text-xl group-hover:translate-x-1 transition-transform duration-300">arrow_forward</i>
        </a>
      </div>

      {* === FEATURES PREVIEW === *}
      <div class="hero-features mt-16 opacity-0 animate-fade-in-up animation-delay-1000">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-3xl mx-auto">
          
          <div class="feature-item text-center group">
            <div class="feature-icon w-16 h-16 bg-white/20 backdrop-blur-sm rounded-full flex items-center justify-center mx-auto mb-4 group-hover:bg-white/30 transition-all duration-300">
              <i class="material-icons text-2xl text-white">eco</i>
            </div>
            <h3 class="feature-title text-white font-semibold mb-2">Eco-Friendly</h3>
            <p class="feature-text text-gray-300 text-sm">Productos biodegradables y sustentables</p>
          </div>

          <div class="feature-item text-center group">
            <div class="feature-icon w-16 h-16 bg-white/20 backdrop-blur-sm rounded-full flex items-center justify-center mx-auto mb-4 group-hover:bg-white/30 transition-all duration-300">
              <i class="material-icons text-2xl text-white">verified</i>
            </div>
            <h3 class="feature-title text-white font-semibold mb-2">15+ Años</h3>
            <p class="feature-text text-gray-300 text-sm">Experiencia y confianza comprobada</p>
          </div>

          <div class="feature-item text-center group">
            <div class="feature-icon w-16 h-16 bg-white/20 backdrop-blur-sm rounded-full flex items-center justify-center mx-auto mb-4 group-hover:bg-white/30 transition-all duration-300">
              <i class="material-icons text-2xl text-white">support_agent</i>
            </div>
            <h3 class="feature-title text-white font-semibold mb-2">Asesoría</h3>
            <p class="feature-text text-gray-300 text-sm">Soporte especializado personalizado</p>
          </div>
        </div>
      </div>
    </div>

    {* === SCROLL INDICATOR === *}
    <div class="scroll-indicator absolute bottom-8 left-1/2 transform -translate-x-1/2 opacity-0 animate-fade-in-up animation-delay-1200">
      <div class="scroll-mouse w-6 h-10 border-2 border-white/50 rounded-full flex justify-center">
        <div class="scroll-wheel w-1 h-3 bg-white/70 rounded-full mt-2 animate-bounce"></div>
      </div>
      <p class="text-white/70 text-sm mt-2">Desliza para explorar</p>
    </div>
  </div>

  {* === DECORATIVE ELEMENTS === *}
  <div class="hero-decorations absolute inset-0 pointer-events-none">
    {* Left Decoration *}
    <div class="absolute left-0 top-1/2 transform -translate-y-1/2 -translate-x-1/2 w-64 h-64 bg-gradient-to-r from-green-400/20 to-transparent rounded-full blur-3xl"></div>
    
    {* Right Decoration *}
    <div class="absolute right-0 top-1/3 transform -translate-y-1/2 translate-x-1/2 w-48 h-48 bg-gradient-to-l from-green-300/20 to-transparent rounded-full blur-3xl"></div>
  </div>
</section>