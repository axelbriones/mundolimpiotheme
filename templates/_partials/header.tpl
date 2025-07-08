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
          {if !empty($shop.logo_details.desktop.url)} {* PS 1.7.8+ usa logo_details *}
            <img class="logo img-responsive"
                 src="{$shop.logo_details.desktop.url}"
                 alt="{$shop.name|escape:'htmlall':'UTF-8'}"
                 {if !empty($shop.logo_details.desktop.width)}width="{$shop.logo_details.desktop.width|escape:'htmlall':'UTF-8'}"{/if}
                 {if !empty($shop.logo_details.desktop.height)}height="{$shop.logo_details.desktop.height|escape:'htmlall':'UTF-8'}"{/if}>
          {elseif !empty($shop.logo.url)} {* Fallback para PS < 1.7.8 o si logo_details no está completo *}
            <img class="logo img-responsive"
                 src="{$shop.logo.url}"
                 alt="{$shop.name|escape:'htmlall':'UTF-8'}"
                 {if !empty($shop.logo.width)}width="{$shop.logo.width|escape:'htmlall':'UTF-8'}"{/if}
                 {if !empty($shop.logo.height)}height="{$shop.logo.height|escape:'htmlall':'UTF-8'}"{/if}>
          {elseif !empty($shop.logo)} {* Fallback si $shop.logo es solo la URL directa *}
             <img class="logo img-responsive"
                 src="{$shop.logo|escape:'htmlall':'UTF-8'}"
                 alt="{$shop.name|escape:'htmlall':'UTF-8'}">
          {else}
            <span class="text-logo">{$shop.name|escape:'htmlall':'UTF-8'}</span> {* Fallback a texto si no hay logo *}
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
      <div class="mobile-menu-container hidden-lg-up"> {* hidden-lg-up para mostrar solo en móvil/tablet *}
        <button class="btn-icon js-ml-menu-toggle" id="menu-icon" aria-label="{l s='Toggle navigation' d='Shop.Theme.Actions'}">
          <i class="material-icons">menu</i> {* Icono de hamburguesa *}
        </button>

        {* Carrito e info de usuario para móvil (podemos usar los hooks de Classic aquí si es necesario) *}
        <div class="mobile-header-right-icons">
            {hook h='displayMobileTopSiteMap'} {* Para el carrito e info de usuario en móvil como en Classic *}
        </div>
      </div>

    </div>
  </div>

  {* Panel del menú móvil que se mostrará/ocultará con JS *}
  <div class="ml-mobile-nav hidden-lg-up" id="js-ml-mobile-nav">
    <div class="container">
        {* El contenido del menú móvil. Podría ser el mismo hook 'displayTop' o uno específico si el módulo de menú lo soporta.
           También se puede construir un menú simple aquí si se prefiere. *}
        {hook h='displayTop'}

        <div class="mobile-nav-cta">
             <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}" class="btn btn-primary btn-block">
                {l s='Contactar Ahora' d='Shop.Theme.Actions'}
            </a>
        </div>

        {* Opcional: Enlaces adicionales para móvil como los de header_nav de Classic *}
        <div class="mobile-nav-bottom-links">
            {hook h='displayNavMobile'} {* Un nuevo hook si queremos contenido diferente al displayNav1/2 *}
            {* O replicar displayNav1 y displayNav2 si es necesario *}
            {* {hook h='displayNav1'} *}
            {* {hook h='displayNav2'} *}
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
