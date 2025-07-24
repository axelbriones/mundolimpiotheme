{**
 * Header - Mundo Limpio Theme
 * Header sticky profesional con navegación responsive
 *}

<header id="mundo-header" class="mundo-header fixed top-0 left-0 right-0 z-50 bg-white shadow-md transition-all duration-300">
  <div class="container mx-auto px-4 lg:px-6">
    <nav class="flex items-center justify-between h-20">
      
      {* === LOGO SECTION === *}
      <div class="logo-section flex-shrink-0">
        <a href="{if isset($urls.base_url)}{$urls.base_url}{else}/{/if}" class="flex items-center logo-link">
          {if isset($shop.logo_details) && $shop.logo_details}
            <img 
              src="{$shop.logo_details.src}" 
              alt="{if isset($shop.name)}{$shop.name|escape:'html':'UTF-8'}{else}Mundo Limpio{/if}"
              class="h-12 w-auto hover:scale-105 transition-transform duration-300"
              {if isset($shop.logo_details.width)}width="{$shop.logo_details.width}"{/if}
              {if isset($shop.logo_details.height)}height="{$shop.logo_details.height}"{/if}
            >
          {else}
            <span class="text-2xl font-bold text-green-600 hover:text-green-700 transition-colors">
              {if isset($shop.name)}{$shop.name|escape:'html':'UTF-8'}{else}Mundo Limpio{/if}
            </span>
          {/if}
        </a>
      </div>

      {* === DESKTOP NAVIGATION === *}
      <div class="desktop-nav hidden lg:flex items-center space-x-8">
        <div class="nav-links flex items-center space-x-6">
          <a href="{if isset($urls.pages.index)}{$urls.pages.index}{else}/{/if}" 
             class="nav-link text-gray-700 hover:text-green-600 font-medium transition-colors duration-200 relative">
            Inicio
          </a>
          <a href="{if isset($urls.pages.category)}{$urls.pages.category}{else}/categoria{/if}" 
             class="nav-link text-gray-700 hover:text-green-600 font-medium transition-colors duration-200 relative">
            Productos
          </a>
          <a href="#sustentabilidad" 
             class="nav-link text-gray-700 hover:text-green-600 font-medium transition-colors duration-200 relative">
            Sustentabilidad
          </a>
          <a href="{if isset($urls.pages.contact)}{$urls.pages.contact}{else}/contacto{/if}" 
             class="nav-link text-gray-700 hover:text-green-600 font-medium transition-colors duration-200 relative">
            Contacto
          </a>
        </div>
      </div>

      {* === SEARCH BAR DESKTOP === *}
      <div class="search-section hidden md:flex items-center flex-1 max-w-md mx-6">
        <form action="{if isset($urls.pages.search)}{$urls.pages.search}{else}/buscar{/if}" 
              method="get" class="w-full relative">
          <input 
            type="text" 
            name="{if isset($search_param_name)}{$search_param_name}{else}s{/if}"
            placeholder="Buscar productos..." 
            class="w-full pl-4 pr-12 py-3 border border-gray-200 rounded-full focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-200"
            value="{if isset($search_string)}{$search_string|escape:'html':'UTF-8'}{/if}"
          >
          <button type="submit" 
                  class="absolute right-2 top-1/2 transform -translate-y-1/2 p-2 text-gray-400 hover:text-green-600 transition-colors">
            <i class="material-icons text-xl">search</i>
          </button>
        </form>
      </div>

      {* === USER ACTIONS === *}
      <div class="user-actions flex items-center space-x-4">
        
        {* Account - Desktop *}
        <div class="account-section hidden md:block">
          {if isset($customer.is_logged) && $customer.is_logged}
            <a href="{if isset($urls.pages.my_account)}{$urls.pages.my_account}{else}/mi-cuenta{/if}" 
               class="account-link flex items-center text-gray-700 hover:text-green-600 transition-colors">
              <i class="material-icons mr-1">account_circle</i>
              <span class="hidden lg:inline">Mi Cuenta</span>
            </a>
          {else}
            <a href="{if isset($urls.pages.authentication)}{$urls.pages.authentication}{else}/login{/if}" 
               class="account-link flex items-center text-gray-700 hover:text-green-600 transition-colors">
              <i class="material-icons mr-1">login</i>
              <span class="hidden lg:inline">Ingresar</span>
            </a>
          {/if}
        </div>

        {* Cart *}
        <div class="cart-section">
          <a href="{if isset($urls.pages.cart)}{$urls.pages.cart}{else}/carrito{/if}" 
             class="cart-link flex items-center bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-full transition-all duration-200 group">
            <i class="material-icons mr-2">shopping_cart</i>
            <span class="cart-count bg-white text-green-600 text-xs font-bold px-2 py-1 rounded-full ml-2 group-hover:bg-gray-100">
              {if isset($cart.products_count)}{$cart.products_count}{else}0{/if}
            </span>
          </a>
        </div>

        {* Mobile Menu Toggle *}
        <button id="mobile-menu-toggle" 
                class="mobile-menu-btn lg:hidden p-2 text-gray-700 hover:text-green-600 transition-colors">
          <i class="material-icons text-2xl">menu</i>
        </button>
      </div>
    </nav>
  </div>

  {* === MOBILE MENU === *}
  <div id="mobile-menu" 
       class="mobile-menu lg:hidden absolute top-full left-0 right-0 bg-white shadow-lg transform -translate-y-full opacity-0 invisible transition-all duration-300 ease-in-out">
    <div class="container mx-auto px-4 py-6">
      
      {* Mobile Search *}
      <div class="mobile-search mb-6">
        <form action="{if isset($urls.pages.search)}{$urls.pages.search}{else}/buscar{/if}" 
              method="get" class="relative">
          <input 
            type="text" 
            name="{if isset($search_param_name)}{$search_param_name}{else}s{/if}"
            placeholder="Buscar productos..." 
            class="w-full pl-4 pr-12 py-3 border border-gray-200 rounded-full focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent"
            value="{if isset($search_string)}{$search_string|escape:'html':'UTF-8'}{/if}"
          >
          <button type="submit" 
                  class="absolute right-2 top-1/2 transform -translate-y-1/2 p-2 text-gray-400 hover:text-green-600">
            <i class="material-icons text-xl">search</i>
          </button>
        </form>
      </div>

      {* Mobile Navigation Links *}
      <nav class="mobile-nav space-y-4">
        <a href="{if isset($urls.pages.index)}{$urls.pages.index}{else}/{/if}" 
           class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-green-600 hover:bg-green-50 rounded-lg transition-all duration-200">
          <i class="material-icons mr-3">home</i>
          Inicio
        </a>
        <a href="{if isset($urls.pages.category)}{$urls.pages.category}{else}/categoria{/if}" 
           class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-green-600 hover:bg-green-50 rounded-lg transition-all duration-200">
          <i class="material-icons mr-3">inventory_2</i>
          Productos
        </a>
        <a href="#sustentabilidad" 
           class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-green-600 hover:bg-green-50 rounded-lg transition-all duration-200">
          <i class="material-icons mr-3">eco</i>
          Sustentabilidad
        </a>
        <a href="{if isset($urls.pages.contact)}{$urls.pages.contact}{else}/contacto{/if}" 
           class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-green-600 hover:bg-green-50 rounded-lg transition-all duration-200">
          <i class="material-icons mr-3">contact_mail</i>
          Contacto
        </a>
        
        {* Mobile Account Section *}
        <div class="border-t border-gray-200 pt-4 mt-4">
          {if isset($customer.is_logged) && $customer.is_logged}
            <a href="{if isset($urls.pages.my_account)}{$urls.pages.my_account}{else}/mi-cuenta{/if}" 
               class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-green-600 hover:bg-green-50 rounded-lg transition-all duration-200">
              <i class="material-icons mr-3">account_circle</i>
              Mi Cuenta
            </a>
            <a href="{if isset($urls.actions.logout)}{$urls.actions.logout}{else}/?logout=1{/if}" 
               class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-red-600 hover:bg-red-50 rounded-lg transition-all duration-200">
              <i class="material-icons mr-3">logout</i>
              Cerrar Sesión
            </a>
          {else}
            <a href="{if isset($urls.pages.authentication)}{$urls.pages.authentication}{else}/login{/if}" 
               class="mobile-nav-link block py-3 px-4 text-gray-700 hover:text-green-600 hover:bg-green-50 rounded-lg transition-all duration-200">
              <i class="material-icons mr-3">login</i>
              Ingresar / Registrarse
            </a>
          {/if}
        </div>
      </nav>
    </div>
  </div>
</header>

{* Header Spacer para compensar el header fijo *}
<div class="header-spacer" style="height: 80px;"></div>