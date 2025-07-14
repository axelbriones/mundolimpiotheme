{*
  Mundo Limpio Iguazú - Footer
*}
<footer class="footer-ml bg-gradient-to-br from-gray-900 via-gray-800 to-slate-900 text-white">
  {* Main Footer Content *}
  <div class="py-16">
    <div class="container mx-auto px-4">
      <div class="grid lg:grid-cols-4 md:grid-cols-2 gap-12">
        {* Company Info *}
        <div class="lg:col-span-2">
          <div class="flex items-center space-x-4 mb-8">
            <img
              src="{$urls.theme_assets}img/lovable-uploads/85cbc0aa-d6b6-43f8-9c23-8f2d9e642a5a.png"
              alt="{l s='Mundo Limpio Iguazú - Logo' d='Shop.Theme.Global'}"
              class="h-16 w-auto footer-logo"
            />
          </div>
          <p class="font-opensans text-gray-300 mb-8 max-w-lg text-lg leading-relaxed footer-description">
            {l s='Desde 2008 distribuyendo productos de limpieza e higiene con responsabilidad ecológica en el corazón de la selva misionera. Comprometidos con las generaciones futuras y el cuidado del medio ambiente.' d='Shop.Theme.Global'}
          </p>

          {* Key Features *}
          <div class="grid grid-cols-2 gap-4 mb-8 footer-key-features">
            <div class="flex items-center space-x-3">
              <div class="w-10 h-10 bg-corporate-blue rounded-lg flex items-center justify-center feature-icon-bg">
                {* <Award className="w-5 h-5 text-white" /> *}
                <span class="icon-placeholder">{l s='[Award]' d='Shop.Theme.Global'}</span>
              </div>
              <div>
                <div class="font-montserrat font-semibold text-white feature-title">{l s='+15 Años' d='Shop.Theme.Global'}</div>
                <div class="font-opensans text-sm text-gray-400 feature-subtitle">{l s='de Experiencia' d='Shop.Theme.Global'}</div>
              </div>
            </div>
            <div class="flex items-center space-x-3">
              <div class="w-10 h-10 bg-corporate-green rounded-lg flex items-center justify-center feature-icon-bg">
                {* <Users className="w-5 h-5 text-white" /> *}
                <span class="icon-placeholder">{l s='[Users]' d='Shop.Theme.Global'}</span>
              </div>
              <div>
                <div class="font-montserrat font-semibold text-white feature-title">{l s='500+' d='Shop.Theme.Global'}</div>
                <div class="font-opensans text-sm text-gray-400 feature-subtitle">{l s='Clientes Satisfechos' d='Shop.Theme.Global'}</div>
              </div>
            </div>
            <div class="flex items-center space-x-3">
              <div class="w-10 h-10 bg-corporate-green rounded-lg flex items-center justify-center feature-icon-bg">
                {* <Leaf className="w-5 h-5 text-white" /> *}
                <span class="icon-placeholder">{l s='[Leaf]' d='Shop.Theme.Global'}</span>
              </div>
              <div>
                <div class="font-montserrat font-semibold text-white feature-title">{l s='100%' d='Shop.Theme.Global'}</div>
                <div class="font-opensans text-sm text-gray-400 feature-subtitle">{l s='Eco-Responsable' d='Shop.Theme.Global'}</div>
              </div>
            </div>
            <div class="flex items-center space-x-3">
              <div class="w-10 h-10 bg-corporate-blue rounded-lg flex items-center justify-center feature-icon-bg">
                {* <Clock className="w-5 h-5 text-white" /> *}
                <span class="icon-placeholder">{l s='[Clock]' d='Shop.Theme.Global'}</span>
              </div>
              <div>
                <div class="font-montserrat font-semibold text-white feature-title">{l s='24/7' d='Shop.Theme.Global'}</div>
                <div class="font-opensans text-sm text-gray-400 feature-subtitle">{l s='Atención Rápida' d='Shop.Theme.Global'}</div>
              </div>
            </div>
          </div>
        </div>

        {* Services *}
        <div class="footer-services">
          <h3 class="font-montserrat font-bold text-xl mb-6 text-white footer-heading">{l s='Nuestros Servicios' d='Shop.Theme.Global'}</h3>
          <ul class="space-y-4 font-opensans text-gray-300">
            <li class="flex items-start">
              <div class="w-2 h-2 bg-corporate-green rounded-full mt-2 mr-3 flex-shrink-0 list-bullet"></div>
              <span class="hover:text-white transition-colors duration-300 cursor-pointer">{l s='Asesoramiento experto' d='Shop.Theme.Global'}</span>
            </li>
            <li class="flex items-start">
              <div class="w-2 h-2 bg-corporate-green rounded-full mt-2 mr-3 flex-shrink-0 list-bullet"></div>
              <span class="hover:text-white transition-colors duration-300 cursor-pointer">{l s='Entregas inmediatas' d='Shop.Theme.Global'}</span>
            </li>
            <li class="flex items-start">
              <div class="w-2 h-2 bg-corporate-green rounded-full mt-2 mr-3 flex-shrink-0 list-bullet"></div>
              <span class="hover:text-white transition-colors duration-300 cursor-pointer">{l s='Productos sustentables' d='Shop.Theme.Global'}</span>
            </li>
            <li class="flex items-start">
              <div class="w-2 h-2 bg-corporate-green rounded-full mt-2 mr-3 flex-shrink-0 list-bullet"></div>
              <span class="hover:text-white transition-colors duration-300 cursor-pointer">{l s='Limpieza profesional' d='Shop.Theme.Global'}</span>
            </li>
            <li class="flex items-start">
              <div class="w-2 h-2 bg-corporate-green rounded-full mt-2 mr-3 flex-shrink-0 list-bullet"></div>
              <span class="hover:text-white transition-colors duration-300 cursor-pointer">{l s='Higiene institucional' d='Shop.Theme.Global'}</span>
            </li>
            <li class="flex items-start">
              <div class="w-2 h-2 bg-corporate-green rounded-full mt-2 mr-3 flex-shrink-0 list-bullet"></div>
              <span class="hover:text-white transition-colors duration-300 cursor-pointer">{l s='Soluciones hogareñas' d='Shop.Theme.Global'}</span>
            </li>
          </ul>
        </div>

        {* Contact Info *}
        <div class="footer-contact-info">
          <h3 class="font-montserrat font-bold text-xl mb-6 text-white footer-heading">{l s='Información de Contacto' d='Shop.Theme.Global'}</h3>
          <div class="space-y-6 font-opensans text-gray-300">
            <div class="flex items-start space-x-3 contact-item">
              <div class="w-6 h-6 bg-corporate-green rounded flex items-center justify-center mt-1 contact-icon-bg">
                {* <Phone className="w-3 h-3 text-white" /> *}
                <span class="icon-placeholder-small">{l s='[Ph]' d='Shop.Theme.Global'}</span>
              </div>
              <div>
                <div class="font-semibold text-white contact-value">{l s='+54 3757 XXX-XXX' d='Shop.Theme.Global'}</div>
                <div class="text-sm contact-label">{l s='Atención inmediata' d='Shop.Theme.Global'}</div>
              </div>
            </div>
            <div class="flex items-start space-x-3 contact-item">
              <div class="w-6 h-6 bg-corporate-green rounded flex items-center justify-center mt-1 contact-icon-bg">
                {* <Mail className="w-3 h-3 text-white" /> *}
                <span class="icon-placeholder-small">{l s='[Mail]' d='Shop.Theme.Global'}</span>
              </div>
              <div>
                <div class="font-semibold text-white contact-value">{l s='info@mundolimpioiguazu.com' d='Shop.Theme.Global'}</div>
                <div class="text-sm contact-label">{l s='Consultas generales' d='Shop.Theme.Global'}</div>
              </div>
            </div>
            <div class="flex items-start space-x-3 contact-item">
              <div class="w-6 h-6 bg-corporate-green rounded flex items-center justify-center mt-1 contact-icon-bg">
                {* <MapPin className="w-3 h-3 text-white" /> *}
                <span class="icon-placeholder-small">{l s='[Pin]' d='Shop.Theme.Global'}</span>
              </div>
              <div>
                <div class="font-semibold text-white contact-value">{l s='Puerto Iguazú, Misiones' d='Shop.Theme.Global'}</div>
                <div class="text-sm contact-label">{l s='Argentina' d='Shop.Theme.Global'}</div>
              </div>
            </div>
            <div class="flex items-start space-x-3 contact-item">
              <div class="w-6 h-6 bg-corporate-green rounded flex items-center justify-center mt-1 contact-icon-bg">
                {* <Clock className="w-3 h-3 text-white" /> *}
                <span class="icon-placeholder-small">{l s='[Clk]' d='Shop.Theme.Global'}</span>
              </div>
              <div>
                <div class="font-semibold text-white contact-value">{l s='Lun-Vie: 8:00-18:00' d='Shop.Theme.Global'}</div>
                <div class="text-sm contact-label">{l s='Sáb: 8:00-12:00' d='Shop.Theme.Global'}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  {* Bottom Bar *}
  <div class="border-t border-gray-700 py-8 footer-bottom-bar">
    <div class="container mx-auto px-4">
      <div class="flex flex-col lg:flex-row justify-between items-center space-y-4 lg:space-y-0">
        <p class="font-opensans text-gray-400 text-center lg:text-left copyright">
          {l s='© 2024 Mundo Limpio Iguazú. Todos los derechos reservados.' d='Shop.Theme.Global'}
        </p>
        <div class="flex items-center space-x-8 footer-bottom-right">
          <p class="font-opensans text-gray-400 text-sm text-center lg:text-right tagline">
            {l s='Cuidando la selva misionera desde 2008' d='Shop.Theme.Global'}
          </p>
          <div class="flex items-center space-x-2 commitment">
            {* <Leaf className="w-4 h-4 text-corporate-green" /> *}
             <span class="icon-placeholder-leaf text-corporate-green">{l s='[Leaf]' d='Shop.Theme.Global'}</span>
            <span class="font-montserrat text-corporate-green font-medium text-sm">
              {l s='Comprometidos con las generaciones futuras' d='Shop.Theme.Global'}
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>
</footer>
