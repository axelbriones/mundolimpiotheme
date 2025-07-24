{**
 * Header Template - Mundo Limpio Theme
 * Elegant sticky header with scroll behavior
 *}

<header id="header" class="header-container fixed top-0 left-0 right-0 z-50 transition-transform duration-300 ease-in-out bg-white shadow-lg">
  <div class="header-nav bg-white border-b border-gray-100">
    <div class="container mx-auto px-4 lg:px-6">
      <nav class="flex items-center justify-between h-20">
        
        {* Logo Section *}
        <div class="logo-section flex-shrink-0">
          <a href="{$urls.base_url}" class="logo-link flex items-center">
            {if $shop.logo_details}
              <img 
                class="logo h-12 w-auto transition-all duration-300 hover:scale-105" 
                src="{$shop.logo_details.src}" 
                alt="{$shop.name}" 
                width="{$shop.logo_details.width}" 
                height="{$shop.logo_details.height}"
              >
            {else}
              <span class="text-2xl font-bold text-green-600 hover:text-green-700 transition-colors">
                {$shop.name}
              </span>
            {/if}
          </a>
        </div>

        {* Desktop Navigation *}
        <div class="desktop-nav hidden lg:flex items-center space-x-8">
          {hook h='displayTop'}
          
          <div class="nav-links flex items-center space-x-6">
            <a href="{$urls.pages.index}" class="nav-link text-gray-700 hover:text-green-600 font-medium transition-colors duration-200">
              Inicio
            </a>
            <a href="{$urls.pages.category}" class="nav-link text-gray-700 hover:text-green-600 font-medium transition-colors duration-200">
              Productos
            </a>
            <a href="#" class="nav-link text-gray-700 hover:text-green-600 font-medium transition-colors duration-200">
              Sustentabilidad
            </a>
            <a href="{$urls.pages.contact}" class="nav-link text-gray-700 hover:text-green-600 font-medium transition-colors duration-200">
              Contacto
            </a>
          </div>
        </div>

        {* Search Bar - Desktop *}
        <div class="search-section hidden md:flex items-center flex-1 max-w-md mx-6">
          {hook h='displaySearch2'}
          <form action="{$urls.pages.search}" method="get" class="search-form relative w-full">
            <input 
              type="text" 
              name="s" 
              placeholder="Buscar productos..." 
              class="search-input w-full pl-4 pr-12 py-3 border border-gray-200 rounded-full focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-200"
              value="{$search_string|escape:'html':'UTF-8'}"
            >
            <button type="submit" class="search-btn absolute right-2 top-1/2 transform -translate-y-1/2 p-2 text-gray-400 hover:text-green-600 transition-colors">
              <i class="material-icons text-xl">search</i>
            </button>
          </form>
        </div>

        {* User Actions *}
        <div class="user-actions flex items-center space-x-4">
          
          {* Account *}
          <div class="account-section hidden md:block">
            {if $customer.is_logged}
              <a href="{$urls.pages.my_account}" class="account-link flex items-center text-gray-700 hover:text-green-600 transition-colors">
                <i class="material-icons mr-1">account_circle</i>
                <span class="hidden lg:inline">Mi Cuenta</span>
              </a>
            {else}
              <a href="{$urls.pages.authentication}" class="account-link flex items-center text-gray-700 hover:text-green-600 transition-colors">
                <i class="material-icons mr-1">login</i>
                <span class="hidden lg:inline">Ingresar</span>
              </a>
            {/if}
          </div>

          {* Cart *}
          <div class="cart-section">
            {hook h='displayTop'}
            <a href="{$urls.pages.cart}" class="cart-link flex items-center bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-full transition-all duration-200 group">
              <i class="material-icons mr-2">shopping_cart</i>
              <span class="cart-count bg-white text-green-600 text-xs font-bold px-2 py-1 rounded-full ml-2 group-hover:bg-gray-100">
                {$cart.products_count}
              </span>
            </a>
          </div>

          {* Mobile Menu Toggle *}
          <button id="mobile-menu-toggle" class="mobile-menu-btn lg:hidden p-2 text-gray-700 hover:text-green-600 transition-colors">
            <i class="material-icons text-2xl">menu</i>
          </button>
        </div>
      </nav>
    </div>
  </div>

  {* Mobile Navigation *}
  <div id="mobile-menu" class="mobile-menu lg:hidden absolute top-full left-0 right-0 bg-white shadow-lg transform -translate-y-full opacity-0 invisible transition-all duration-300 ease-in-out">
    <div class="container mx-auto px-4 py-6">
      
      {* Mobile Search *}
      <div class="mobile-search mb-6">
        <form action="{$urls.pages.search}" method="get" class="search-form relative">
          <input 
            type="text" 
            name="s" 
            placeholder="Buscar productos..." 
            class="search-input w-full pl-4 pr-12 py-3 border border-gray-200 rounded-full focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent"
            value="{$search_string|escape:'html':'UTF-8'}"
          >
          <button type="submit" class="search-btn absolute right-2 top-1/2 transform -translate-y-1/2 p-2 text-gray-400 hover:text-green-600">
            <i class="material-icons text-xl">search</i>
          </button>
        </form>
      </div>

      {* Mobile Navigation Links *}
      <nav class="mobile-nav space-y-4">
        <a href="{$urls.pages.index}" class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-green-600 hover:bg-green-50 rounded-lg transition-all duration-200">
          <i class="material-icons mr-3">home</i>
          Inicio
        </a>
        <a href="{$urls.pages.category}" class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-green-600 hover:bg-green-50 rounded-lg transition-all duration-200">
          <i class="material-icons mr-3">inventory_2</i>
          Productos
        </a>
        <a href="#" class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-green-600 hover:bg-green-50 rounded-lg transition-all duration-200">
          <i class="material-icons mr-3">eco</i>
          Sustentabilidad
        </a>
        <a href="{$urls.pages.contact}" class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-green-600 hover:bg-green-50 rounded-lg transition-all duration-200">
          <i class="material-icons mr-3">contact_mail</i>
          Contacto
        </a>
        
        {* Mobile Account *}
        <div class="border-t border-gray-200 pt-4 mt-4">
          {if $customer.is_logged}
            <a href="{$urls.pages.my_account}" class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-green-600 hover:bg-green-50 rounded-lg transition-all duration-200">
              <i class="material-icons mr-3">account_circle</i>
              Mi Cuenta
            </a>
            <a href="{$urls.actions.logout}" class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-red-600 hover:bg-red-50 rounded-lg transition-all duration-200">
              <i class="material-icons mr-3">logout</i>
              Cerrar Sesión
            </a>
          {else}
            <a href="{$urls.pages.authentication}" class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-green-600 hover:bg-green-50 rounded-lg transition-all duration-200">
              <i class="material-icons mr-3">login</i>
              Ingresar / Registrarse
            </a>
          {/if}
        </div>
      </nav>
    </div>
  </div>
</header>

{* Header Spacer to prevent content overlap *}
<div class="header-spacer h-20"></div>