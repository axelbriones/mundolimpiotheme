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

      <nav class="header-main-nav hidden-md-down"> {* hidden-md-down para ocultar en móvil *}
        {hook h='displayTop'} {* Aquí se enganchará ps_mainmenu u otro módulo de menú *}
      </nav>

      <div class="header-cta-button hidden-md-down">
        <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}" class="btn btn-primary ml-contact-btn"> {* Clase específica para estilizar si es necesario *}
          {l s='Contactar Ahora' d='Shop.Theme.Actions'}
        </a>
      </div>

      {* --- Menú Móvil --- *}
      <div class="mobile-menu-container hidden-lg-up">
        {* El id="menu-icon" es usado por el JS de Classic para el menú, podríamos mantenerlo o usar solo nuestra clase js-ml-menu-toggle *}
        <button class="btn-icon js-ml-menu-toggle" id="ml-menu-icon-toggle" aria-label="{l s='Toggle navigation' d='Shop.Theme.Actions'}">
          <i class="material-icons">menu</i>
        </button>

        <div class="mobile-header-right-icons">
            {hook h='displayMobileTopSiteMap'}
        </div>
      </div>

    </div>
  </div>

  {* Panel del menú móvil que se mostrará/ocultará con JS. Se mueve fuera del <header> principal para un mejor control de z-index y posicionamiento si es un off-canvas. *}
  <div class="ml-mobile-nav hidden-lg-up js-ml-mobile-nav" id="js-ml-mobile-nav-panel">
    <div class="ml-mobile-nav-close-container">
        <button class="btn-icon js-ml-menu-toggle" aria-label="{l s='Close menu' d='Shop.Theme.Actions'}">
            <i class="material-icons">close</i>
        </button>
    </div>
    <div class="container">
        <nav class="ml-mobile-main-nav">
            {hook h='displayTop'} {* Reutilizamos el mismo menú de escritorio *}
        </nav>

        <div class="mobile-nav-cta">
             <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}" class="btn btn-primary btn-block">
                {l s='Contactar Ahora' d='Shop.Theme.Actions'}
            </a>
        </div>

        <div class="mobile-nav-bottom-links">
            {hook h='displayNavMobile'}
            {* Considerar añadir aquí enlaces de cuenta, idioma, moneda si no están en displayMobileTopSiteMap *}
            {* Por ejemplo, el contenido de .js-top-menu-bottom del header.tpl de Classic *}
            <div id="_mobile_currency_selector_ml"></div>
            <div id="_mobile_language_selector_ml"></div>
            <div id="_mobile_contact_link_ml"></div>
            <div id="_mobile_user_info_ml"></div>
        </div>
    </div>
  </div>

  {* Mantener el displayNavFullWidth por si algún módulo lo usa extensivamente, aunque el menú principal ya está en displayTop *}
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
