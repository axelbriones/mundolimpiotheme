{**
 * Footer - Mundo Limpio Theme
 * Footer completo con información de la empresa, enlaces y contacto
 *}

<footer class="mundo-footer bg-gray-900 text-white relative overflow-hidden">
  
  {* Background Decoration *}
  <div class="footer-decoration absolute inset-0 opacity-5">
    <div class="absolute top-0 left-0 w-64 h-64 bg-gradient-to-br from-green-400 to-green-600 rounded-full blur-3xl transform -translate-x-1/2 -translate-y-1/2"></div>
    <div class="absolute bottom-0 right-0 w-48 h-48 bg-gradient-to-tl from-green-300 to-green-500 rounded-full blur-3xl transform translate-x-1/2 translate-y-1/2"></div>
  </div>

  {* Main Footer Content *}
  <div class="footer-main relative z-10 py-16">
    <div class="container mx-auto px-4 lg:px-6">
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 lg:gap-12">
        
        {* === COMPANY INFO === *}
        <div class="footer-column">
          <div class="footer-logo mb-6">
            {if isset($shop.logo_details) && $shop.logo_details}
              <img 
                src="{$shop.logo_details.src}" 
                alt="{if isset($shop.name)}{$shop.name|escape:'html':'UTF-8'}{else}Mundo Limpio{/if}"
                class="h-12 w-auto mb-4 filter brightness-0 invert"
              >
            {else}
              <h3 class="text-2xl font-bold text-green-400 mb-4">
                {if isset($shop.name)}{$shop.name|escape:'html':'UTF-8'}{else}Mundo Limpio{/if}
              </h3>
            {/if}
          </div>
          
          <p class="text-gray-300 mb-6 leading-relaxed">
            Desde 2008 brindamos soluciones sustentables de limpieza e higiene, 
            protegiendo el medio ambiente con productos ecológicos de calidad superior.
          </p>
          
          {* Social Media *}
          <div class="social-media">
            <h4 class="text-lg font-semibold mb-4 text-green-400">Síguenos</h4>
            <div class="social-links flex space-x-4">
              <a href="#" class="social-link w-10 h-10 bg-gray-800 hover:bg-green-600 rounded-full flex items-center justify-center transition-all duration-300 group" aria-label="Facebook">
                <i class="fab fa-facebook-f text-gray-300 group-hover:text-white transition-colors"></i>
              </a>
              <a href="#" class="social-link w-10 h-10 bg-gray-800 hover:bg-green-600 rounded-full flex items-center justify-center transition-all duration-300 group" aria-label="Instagram">
                <i class="fab fa-instagram text-gray-300 group-hover:text-white transition-colors"></i>
              </a>
              <a href="#" class="social-link w-10 h-10 bg-gray-800 hover:bg-green-600 rounded-full flex items-center justify-center transition-all duration-300 group" aria-label="WhatsApp">
                <i class="fab fa-whatsapp text-gray-300 group-hover:text-white transition-colors"></i>
              </a>
              <a href="#" class="social-link w-10 h-10 bg-gray-800 hover:bg-green-600 rounded-full flex items-center justify-center transition-all duration-300 group" aria-label="LinkedIn">
                <i class="fab fa-linkedin-in text-gray-300 group-hover:text-white transition-colors"></i>
              </a>
            </div>
          </div>
        </div>

        {* === QUICK LINKS === *}
        <div class="footer-column">
          <h4 class="footer-title text-lg font-semibold mb-6 text-green-400">Enlaces Rápidos</h4>
          <ul class="footer-links space-y-3">
            <li>
              <a href="{if isset($urls.pages.index)}{$urls.pages.index}{else}/{/if}" 
                 class="footer-link text-gray-300 hover:text-green-400 transition-colors duration-200 flex items-center group">
                <i class="material-icons text-sm mr-2 group-hover:translate-x-1 transition-transform">chevron_right</i>
                Inicio
              </a>
            </li>
            <li>
              <a href="{if isset($urls.pages.category)}{$urls.pages.category}{else}/categoria{/if}" 
                 class="footer-link text-gray-300 hover:text-green-400 transition-colors duration-200 flex items-center group">
                <i class="material-icons text-sm mr-2 group-hover:translate-x-1 transition-transform">chevron_right</i>
                Nuestros Productos
              </a>
            </li>
            <li>
              <a href="#sustentabilidad" 
                 class="footer-link text-gray-300 hover:text-green-400 transition-colors duration-200 flex items-center group">
                <i class="material-icons text-sm mr-2 group-hover:translate-x-1 transition-transform">chevron_right</i>
                Sustentabilidad
              </a>
            </li>
            <li>
              <a href="#" 
                 class="footer-link text-gray-300 hover:text-green-400 transition-colors duration-200 flex items-center group">
                <i class="material-icons text-sm mr-2 group-hover:translate-x-1 transition-transform">chevron_right</i>
                Sobre Nosotros
              </a>
            </li>
            <li>
              <a href="{if isset($urls.pages.contact)}{$urls.pages.contact}{else}/contacto{/if}" 
                 class="footer-link text-gray-300 hover:text-green-400 transition-colors duration-200 flex items-center group">
                <i class="material-icons text-sm mr-2 group-hover:translate-x-1 transition-transform">chevron_right</i>
                Contacto
              </a>
            </li>
            <li>
              <a href="#" 
                 class="footer-link text-gray-300 hover:text-green-400 transition-colors duration-200 flex items-center group">
                <i class="material-icons text-sm mr-2 group-hover:translate-x-1 transition-transform">chevron_right</i>
                Blog
              </a>
            </li>
          </ul>
        </div>

        {* === CUSTOMER SERVICE === *}
        <div class="footer-column">
          <h4 class="footer-title text-lg font-semibold mb-6 text-green-400">Atención al Cliente</h4>
          <ul class="footer-links space-y-3">
            <li>
              <a href="{if isset($urls.pages.my_account)}{$urls.pages.my_account}{else}/mi-cuenta{/if}" 
                 class="footer-link text-gray-300 hover:text-green-400 transition-colors duration-200 flex items-center group">
                <i class="material-icons text-sm mr-2 group-hover:translate-x-1 transition-transform">chevron_right</i>
                Mi Cuenta
              </a>
            </li>
            <li>
              <a href="{if isset($urls.pages.order)}{$urls.pages.order}{else}/pedidos{/if}" 
                 class="footer-link text-gray-300 hover:text-green-400 transition-colors duration-200 flex items-center group">
                <i class="material-icons text-sm mr-2 group-hover:translate-x-1 transition-transform">chevron_right</i>
                Seguir Pedido
              </a>
            </li>
            <li>
              <a href="#" 
                 class="footer-link text-gray-300 hover:text-green-400 transition-colors duration-200 flex items-center group">
                <i class="material-icons text-sm mr-2 group-hover:translate-x-1 transition-transform">chevron_right</i>
                Preguntas Frecuentes
              </a>
            </li>
            <li>
              <a href="#" 
                 class="footer-link text-gray-300 hover:text-green-400 transition-colors duration-200 flex items-center group">
                <i class="material-icons text-sm mr-2 group-hover:translate-x-1 transition-transform">chevron_right</i>
                Términos y Condiciones
              </a>
            </li>
            <li>
              <a href="#" 
                 class="footer-link text-gray-300 hover:text-green-400 transition-colors duration-200 flex items-center group">
                <i class="material-icons text-sm mr-2 group-hover:translate-x-1 transition-transform">chevron_right</i>
                Política de Privacidad
              </a>
            </li>
            <li>
              <a href="#" 
                 class="footer-link text-gray-300 hover:text-green-400 transition-colors duration-200 flex items-center group">
                <i class="material-icons text-sm mr-2 group-hover:translate-x-1 transition-transform">chevron_right</i>
                Devoluciones
              </a>
            </li>
          </ul>
        </div>

        {* === CONTACT INFO === *}
        <div class="footer-column">
          <h4 class="footer-title text-lg font-semibold mb-6 text-green-400">Contacto</h4>
          
          <div class="contact-info space-y-4">
            <div class="contact-item flex items-start">
              <i class="material-icons text-green-400 mr-3 mt-1">location_on</i>
              <div class="contact-text">
                <p class="text-gray-300 leading-relaxed">
                  Posadas, Misiones<br>
                  Argentina
                </p>
              </div>
            </div>
            
            <div class="contact-item flex items-center">
              <i class="material-icons text-green-400 mr-3">phone</i>
              <div class="contact-text">
                <a href="tel:+5493764123456" class="text-gray-300 hover:text-green-400 transition-colors">
                  +54 9 3764 12-3456
                </a>
              </div>
            </div>
            
            <div class="contact-item flex items-center">
              <i class="material-icons text-green-400 mr-3">email</i>
              <div class="contact-text">
                <a href="mailto:info@mundolimpio.com" class="text-gray-300 hover:text-green-400 transition-colors">
                  info@mundolimpio.com
                </a>
              </div>
            </div>
            
            <div class="contact-item flex items-start">
              <i class="material-icons text-green-400 mr-3 mt-1">schedule</i>
              <div class="contact-text">
                <p class="text-gray-300 leading-relaxed">
                  Lun - Vie: 8:00 - 18:00<br>
                  Sáb: 8:00 - 13:00
                </p>
              </div>
            </div>
          </div>

          {* Newsletter Signup *}
          <div class="newsletter-signup mt-8">
            <h5 class="text-md font-semibold mb-3 text-green-400">Newsletter</h5>
            <form class="newsletter-form" id="newsletter-form">
              <div class="flex">
                <input 
                  type="email" 
                  placeholder="Tu email..." 
                  class="flex-1 px-3 py-2 bg-gray-800 border border-gray-700 rounded-l-lg focus:outline-none focus:ring-2 focus:ring-green-500 text-white placeholder-gray-400"
                  required
                >
                <button 
                  type="submit" 
                  class="px-4 py-2 bg-green-600 hover:bg-green-700 rounded-r-lg transition-colors duration-200"
                >
                  <i class="material-icons text-sm">send</i>
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

  {* === FOOTER BOTTOM === *}
  <div class="footer-bottom relative z-10 border-t border-gray-800 py-6">
    <div class="container mx-auto px-4 lg:px-6">
      <div class="flex flex-col md:flex-row items-center justify-between">
        
        {* Copyright *}
        <div class="copyright text-center md:text-left mb-4 md:mb-0">
          <p class="text-gray-400 text-sm">
            © {$smarty.now|date_format:"%Y"} {if isset($shop.name)}{$shop.name|escape:'html':'UTF-8'}{else}Mundo Limpio{/if}. Todos los derechos reservados.
          </p>
        </div>

        {* Payment Methods *}
        <div class="payment-methods flex items-center space-x-4">
          <span class="text-gray-400 text-sm mr-2">Aceptamos:</span>
          <div class="payment-icons flex space-x-2">
            <div class="payment-icon w-8 h-6 bg-gray-800 rounded flex items-center justify-center">
              <i class="fab fa-cc-visa text-blue-400 text-sm"></i>
            </div>
            <div class="payment-icon w-8 h-6 bg-gray-800 rounded flex items-center justify-center">
              <i class="fab fa-cc-mastercard text-red-400 text-sm"></i>
            </div>
            <div class="payment-icon w-8 h-6 bg-gray-800 rounded flex items-center justify-center">
              <i class="fab fa-cc-amex text-green-400 text-sm"></i>
            </div>
            <div class="payment-icon w-8 h-6 bg-gray-800 rounded flex items-center justify-center">
              <span class="text-xs text-gray-300 font-bold">MP</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  {* === BACK TO TOP BUTTON === *}
  <button 
    id="back-to-top" 
    class="back-to-top fixed bottom-6 right-6 w-12 h-12 bg-green-600 hover:bg-green-700 text-white rounded-full shadow-lg hover:shadow-xl transition-all duration-300 transform translate-y-16 opacity-0 z-50"
    aria-label="Volver arriba"
  >
    <i class="material-icons">keyboard_arrow_up</i>
  </button>
</footer>