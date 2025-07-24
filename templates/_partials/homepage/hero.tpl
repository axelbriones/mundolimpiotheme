{**
 * Hero Section - Mundo Limpio Theme
 * Elegant hero with background image and content
 *}

<section class="hero-section relative min-h-screen flex items-center justify-center overflow-hidden">
  
  {* Background Image with Overlay *}
  <div class="hero-background absolute inset-0 z-0">
    <div class="hero-image absolute inset-0 bg-cover bg-center bg-no-repeat" 
         style="background-image: url('{$theme_assets}img/hero-bg.jpg');">
    </div>
    
    {* Gradient Overlay *}
    <div class="hero-overlay absolute inset-0 bg-gradient-to-r from-green-900/80 via-green-800/70 to-green-700/60"></div>
    
    {* Animated Particles Background *}
    <div class="hero-particles absolute inset-0 opacity-20">
      <div class="particle absolute w-2 h-2 bg-white rounded-full animate-float-1"></div>
      <div class="particle absolute w-1 h-1 bg-white rounded-full animate-float-2"></div>
      <div class="particle absolute w-3 h-3 bg-white rounded-full animate-float-3"></div>
      <div class="particle absolute w-1 h-1 bg-white rounded-full animate-float-4"></div>
      <div class="particle absolute w-2 h-2 bg-white rounded-full animate-float-5"></div>
    </div>
  </div>

  {* Hero Content *}
  <div class="hero-content relative z-10 container mx-auto px-4 lg:px-6 text-center">
    <div class="max-w-4xl mx-auto">
      
      {* Main Title *}
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

      {* Description *}
      <p class="hero-description text-lg md:text-xl lg:text-2xl text-gray-200 mb-8 max-w-3xl mx-auto leading-relaxed opacity-0 transform translate-y-8 animate-fade-in-up animation-delay-600">
        Desde 2008 brindamos productos de limpieza e higiene con responsabilidad ecológica. 
        Protegemos la selva misionera con soluciones sustentables y asesoramiento experto.
      </p>

      {* Call to Action Button *}
      <div class="hero-cta opacity-0 transform translate-y-8 animate-fade-in-up animation-delay-800">
        <a href="{$urls.pages.contact}" 
           class="cta-button inline-flex items-center px-8 py-4 bg-green-500 hover:bg-green-400 text-white font-semibold text-lg rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300 group">
          <span class="mr-3">Contáctanos Ahora</span>
          <i class="material-icons text-xl group-hover:translate-x-1 transition-transform duration-300">arrow_forward</i>
        </a>
      </div>

      {* Features Preview *}
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

    {* Scroll Indicator *}
    <div class="scroll-indicator absolute bottom-8 left-1/2 transform -translate-x-1/2 opacity-0 animate-fade-in-up animation-delay-1200">
      <div class="scroll-mouse w-6 h-10 border-2 border-white/50 rounded-full flex justify-center">
        <div class="scroll-wheel w-1 h-3 bg-white/70 rounded-full mt-2 animate-bounce"></div>
      </div>
      <p class="text-white/70 text-sm mt-2">Desliza para explorar</p>
    </div>
  </div>

  {* Decorative Elements *}
  <div class="hero-decorations absolute inset-0 pointer-events-none">
    {* Left Decoration *}
    <div class="absolute left-0 top-1/2 transform -translate-y-1/2 -translate-x-1/2 w-64 h-64 bg-gradient-to-r from-green-400/20 to-transparent rounded-full blur-3xl"></div>
    
    {* Right Decoration *}
    <div class="absolute right-0 top-1/3 transform -translate-y-1/2 translate-x-1/2 w-48 h-48 bg-gradient-to-l from-green-300/20 to-transparent rounded-full blur-3xl"></div>
  </div>
</section>

{* Custom Animations Styles *}
<style>
  @keyframes fadeInUp {
    from {
      opacity: 0;
      transform: translateY(2rem);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  @keyframes float1 {
    0%, 100% { transform: translateY(0px) translateX(0px); }
    25% { transform: translateY(-20px) translateX(10px); }
    50% { transform: translateY(-10px) translateX(-10px); }
    75% { transform: translateY(-30px) translateX(5px); }
  }

  @keyframes float2 {
    0%, 100% { transform: translateY(0px) translateX(0px); }
    33% { transform: translateY(-15px) translateX(-15px); }
    66% { transform: translateY(-25px) translateX(15px); }
  }

  @keyframes float3 {
    0%, 100% { transform: translateY(0px) translateX(0px) rotate(0deg); }
    25% { transform: translateY(-25px) translateX(20px) rotate(90deg); }
    50% { transform: translateY(-15px) translateX(-20px) rotate(180deg); }
    75% { transform: translateY(-35px) translateX(10px) rotate(270deg); }
  }

  @keyframes float4 {
    0%, 100% { transform: translateY(0px) translateX(0px); }
    50% { transform: translateY(-40px) translateX(-25px); }
  }

  @keyframes float5 {
    0%, 100% { transform: translateY(0px) translateX(0px); }
    20% { transform: translateY(-30px) translateX(15px); }
    40% { transform: translateY(-10px) translateX(-20px); }
    60% { transform: translateY(-45px) translateX(25px); }
    80% { transform: translateY(-20px) translateX(-10px); }
  }

  .animate-fade-in-up {
    animation: fadeInUp 0.8s ease-out forwards;
  }

  .animate-float-1 {
    animation: float1 8s ease-in-out infinite;
    top: 20%;
    left: 10%;
  }

  .animate-float-2 {
    animation: float2 6s ease-in-out infinite;
    top: 60%;
    left: 80%;
  }

  .animate-float-3 {
    animation: float3 10s ease-in-out infinite;
    top: 30%;
    right: 20%;  
  }

  .animate-float-4 {
    animation: float4 7s ease-in-out infinite;
    bottom: 30%;
    left: 15%;
  }

  .animate-float-5 {
    animation: float5 9s ease-in-out infinite;
    top: 70%;
    right: 30%;
  }

  .animation-delay-200 {
    animation-delay: 0.2s;
  }

  .animation-delay-400 {
    animation-delay: 0.4s;
  }

  .animation-delay-600 {
    animation-delay: 0.6s;
  }

  .animation-delay-800 {
    animation-delay: 0.8s;
  }

  .animation-delay-1000 {
    animation-delay: 1s;
  }

  .animation-delay-1200 {
    animation-delay: 1.2s;
  }
</style>