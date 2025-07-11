{**
 * Mundo Limpio Theme - Custom Header
 * Based on React design and PrestaShop Classic structure.
 *}

{block name='header_banner'}
  {hook h='displayBanner'} {* Mantenemos el hook de banner por si se usa *}
{/block}

{* Nuevo header principal que envuelve la navegación y el logo según el diseño React *}
<header id="header" class="ml-main-header {if Configuration::get('MLTHEME_HEADER_STICKY', null, null, $shop.id)}js-sticky-header{/if}"> {* La clase js-sticky-header la usará nuestro theme.js *}
  <div class="container">
    <div class="header-inner-wrapper"> {* Equivalente al flex items-center justify-between *}

      <div class="header-logo-container">
        <a href="{$urls.base_url}">
            {assign var=logo_url value=''}
            {assign var=logo_width value=''}
            {assign var=logo_height value=''}

            {if isset($shop.logo_details.desktop.url) && $shop.logo_details.desktop.url != ''}
                {assign var=logo_url value=$shop.logo_details.desktop.url}
                {if isset($shop.logo_details.desktop.width)}{assign var=logo_width value=$shop.logo_details.desktop.width}{/if}
                {if isset($shop.logo_details.desktop.height)}{assign var=logo_height value=$shop.logo_details.desktop.height}{/if}
            {elseif isset($shop.logo.url) && $shop.logo.url != ''} {* PS < 1.7.8 o fallback *}
                {assign var=logo_url value=$shop.logo.url}
                {if isset($shop.logo.width)}{assign var=logo_width value=$shop.logo.width}{/if}
                {if isset($shop.logo.height)}{assign var=logo_height value=$shop.logo.height}{/if}
            {elseif is_string($shop.logo) && $shop.logo != ''} {* Si $shop.logo es solo una URL string *}
                {assign var=logo_url value=$shop.logo}
            {/if}

            {if $logo_url != ''}
                <img class="logo img-responsive"
                     src="{$logo_url|escape:'htmlall':'UTF-8'}"
                     alt="{$shop.name|escape:'htmlall':'UTF-8'}"
                     {if $logo_width != ''}width="{$logo_width|escape:'htmlall':'UTF-8'}"{/if}
                     {if $logo_height != ''}height="{$logo_height|escape:'htmlall':'UTF-8'}"{/if}>
            {else}
                {* Fallback si no hay logo configurado en la tienda *}
                {if isset($shop.logo_details) && isset($shop.logo_details.default_logo_url) && $shop.logo_details.default_logo_url != ''}
                     <img class="logo img-responsive"
                         src="{$shop.logo_details.default_logo_url|escape:'htmlall':'UTF-8'}"
                         alt="{$shop.name|escape:'htmlall':'UTF-8'}">
                {else}
                    <span class="text-logo">{$shop.name|escape:'htmlall':'UTF-8'}</span>
                {/if}
            {/if}
        </a>
      </div>

      <nav class="header-main-nav hidden-md-down">
        {hook h='displayTop'} {* ps_mainmenu hook *}
      </nav>

      <div class="header-right-column hidden-md-down">
        <div class="header-top-right-icons">
          {hook h='displaySearch'}
          {hook h='displayCustomerAccountLink'}
          {hook h='displayShoppingCartButton'}
        </div>
        <div class="header-cta-button">
          <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}" class="btn btn-primary ml-contact-btn">
            {l s='Contactar Ahora' d='Shop.Theme.Actions'}
          </a>
        </div>
      </div>

      {* --- Mobile Menu Structure --- *}
      <div class="mobile-menu-container hidden-lg-up">
        <button class="btn-icon js-ml-menu-toggle" id="ml-menu-icon-toggle" aria-label="{l s='Toggle navigation' d='Shop.Theme.Actions'}">
          <i class="material-icons">menu</i>
        </button>

        <div class="mobile-header-right-icons">
            {* It's common for cart and user info to be visible directly on mobile header too, not just in panel *}
            {hook h='displayMobileTopSiteMap'} {* This hook from Classic often includes cart & user login *}
        </div>
      </div>

    </div>
  </div>

  {* Mobile Navigation Panel - Off-canvas *}
  <div class="ml-mobile-nav hidden-lg-up js-ml-mobile-nav" id="js-ml-mobile-nav-panel">
    <div class="ml-mobile-nav-header">
        <span class="ml-mobile-nav-title">{l s='Menu' d='Shop.Theme.Global'}</span>
        <button class="btn-icon js-ml-menu-toggle" aria-label="{l s='Close menu' d='Shop.Theme.Actions'}">
            <i class="material-icons">close</i>
        </button>
    </div>
    <div class="ml-mobile-nav-content container">
        <nav class="ml-mobile-main-nav">
            {hook h='displayTop'} {* Main menu items *}
        </nav>

        <div class="mobile-nav-search">
            {hook h='displaySearch'} {* Search bar for mobile panel *}
        </div>

        <div class="mobile-nav-cta">
             <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}" class="btn btn-primary btn-block">
                {l s='Contactar Ahora' d='Shop.Theme.Actions'}
            </a>
        </div>

        <div class="mobile-nav-bottom-links">
            {hook h='displayNavMobile'} {* For other links like currency, language, if not handled by displayMobileTopSiteMap or other specific hooks *}
            {* Example of how Classic theme includes these, if you want to replicate and ps_themecusto is not used *}
            {* <div id="_mobile_language_selector"></div> *}
            {* <div id="_mobile_currency_selector"></div> *}
            {* {if Context::getContext()->customer->isLogged()}
              <a class="account-link" href="{$urls.pages.my_account|escape:'htmlall':'UTF-8'}" title="{l s='My account' d='Shop.Theme.Customeraccount'}" rel="nofollow">
                <i class="material-icons">person</i>
                <span>{$customer.firstname|escape:'htmlall':'UTF-8'} {$customer.lastname|escape:'htmlall':'UTF-8'}</span>
              </a>
            {else}
              <a class="user-info-login" href="{$urls.pages.authentication|escape:'htmlall':'UTF-8'}" title="{l s='Log in to your customer account' d='Shop.Theme.Customeraccount'}" rel="nofollow">
                <i class="material-icons">person_outline</i>
                <span>{l s='Sign in' d='Shop.Theme.Actions'}</span>
              </a>
            {/if} *}
        </div>
    </div>
  </div>

  {* displayNavFullWidth is often used for full-width menu bars below the main header *}
  {* El hook displayNavFullWidth se suele usar para menús que ocupan todo el ancho debajo del header principal,
     como a veces se ve en el tema Classic. Lo mantenemos aquí por compatibilidad,
     aunque nuestro menú principal ahora está en displayTop dentro del header. *}
    {block name='header_nav_full_width_hook'}
      <div class="nav-full-width-container">
          {hook h='displayNavFullWidth'}
      </div>
    {/block}
</header>

{* Los bloques header_nav y header_top originales de Classic se han omitido intencionalmente
   en esta nueva estructura para lograr el diseño deseado.
   Los hooks importantes como displayBanner, displayTop y displayNavFullWidth se han conservado.
   Si se necesita displayNav1 o displayNav2, se pueden añadir en una nueva ubicación o dentro de displayNavMobile.
*}
