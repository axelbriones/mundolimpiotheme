{**
 * Mundo Limpio Theme - Custom Header
 * Based on React design and PrestaShop Classic structure.
 *}

{block name='header_banner'}
  {hook h='displayBanner'}
{/block}

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<header id="header" class="fixed top-0 left-0 right-0 z-50 transition-all duration-300">
  <div class="container mx-auto px-4 py-4">
    <div class="flex items-center justify-between">

      <div class="flex items-center">
        <a href="{$urls.base_url}">
            {assign var=logo_url value=''}
            {assign var=logo_width value=''}
            {assign var=logo_height value=''}

            {if isset($shop.logo_details.desktop.url) && $shop.logo_details.desktop.url != ''}
                {assign var=logo_url value=$shop.logo_details.desktop.url}
                {if isset($shop.logo_details.desktop.width)}{assign var=logo_width value=$shop.logo_details.desktop.width}{/if}
                {if isset($shop.logo_details.desktop.height)}{assign var=logo_height value=$shop.logo_details.desktop.height}{/if}
            {elseif isset($shop.logo.url) && $shop.logo.url != ''}
                {assign var=logo_url value=$shop.logo.url}
                {if isset($shop.logo.width)}{assign var=logo_width value=$shop.logo.width}{/if}
                {if isset($shop.logo.height)}{assign var=logo_height value=$shop.logo.height}{/if}
            {elseif is_string($shop.logo) && $shop.logo != ''}
                {assign var=logo_url value=$shop.logo}
            {/if}

            {if $logo_url != ''}
                <img class="h-12 w-auto"
                    src="{$logo_url|escape:'htmlall':'UTF-8'}"
                    alt="{$shop.name|escape:'htmlall':'UTF-8'}"
                    {if $logo_width != ''}width="{$logo_width|escape:'htmlall':'UTF-8'}"{/if}
                    {if $logo_height != ''}height="{$logo_height|escape:'htmlall':'UTF-8'}"{/if}>
            {else}
                {if isset($shop.logo_details) && isset($shop.logo_details.default_logo_url) && $shop.logo_details.default_logo_url != ''}
                    <img class="h-12 w-auto"
                        src="{$shop.logo_details.default_logo_url|escape:'htmlall':'UTF-8'}"
                        alt="{$shop.name|escape:'htmlall':'UTF-8'}">
                {else}
                    <span class="text-logo">{$shop.name|escape:'htmlall':'UTF-8'}</span>
                {/if}
            {/if}
        </a>
      </div>

      <nav class="hidden md:flex items-center space-x-6">
        {hook h='displayTop'}
      </nav>

      <div class="hidden md:flex items-center space-x-6">
          <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}" class="bg-corporate-green hover:bg-green-600 text-white font-montserrat btn btn-primary">
            {l s='Contactar Ahora' d='Shop.Theme.Actions'}
          </a>
      </div>

      <div class="md:hidden flex items-center">
        <button class="btn-icon js-ml-menu-toggle" id="ml-menu-icon-toggle" aria-label="{l s='Toggle navigation' d='Shop.Theme.Actions'}">
          <i class="material-icons text-white">menu</i>
        </button>
      </div>
    </div>
  </div>

  <div class="md:hidden mobile-menu js-ml-mobile-nav" id="js-ml-mobile-nav-panel">
    <div class="container mx-auto px-4 py-4">
        <nav>
            {hook h='displayTop'}
        </nav>
        <div class="mt-4">
            <a href="{$urls.pages.contact|escape:'htmlall':'UTF-8'}" class="bg-corporate-green hover:bg-green-600 text-white font-montserrat btn btn-primary btn-block">
                {l s='Contactar Ahora' d='Shop.Theme.Actions'}
            </a>
        </div>
    </div>
  </div>
</header>
