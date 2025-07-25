{**
 * Layout Both Columns - Mundo Limpio Theme
 * Layout principal que extiende el tema Classic de PrestaShop
 *}

{extends file='parent:layouts/layout-both-columns.tpl'}

{* Agregar nuestros estilos CSS *}
{block name='stylesheets'}
  {$smarty.block.parent}
  <link rel="stylesheet" href="{$theme_assets}css/theme.css" type="text/css" media="all">
{/block}

{* Reemplazar el header por defecto con nuestro header personalizado *}
{block name='header'}
  {include file='_partials/header.tpl'}
{/block}

{* Agregar nuestro JavaScript *}
{block name='javascript_bottom'}
  {$smarty.block.parent}
  <script src="{$theme_assets}js/theme.js" defer></script>
{/block}

{* Clases CSS personalizadas para el body *}
{block name='body_classes'}mundo-limpio-theme {if isset($page.page_name)}page-{$page.page_name|escape:'html':'UTF-8'}{/if}{/block}

{* Schema.org para SEO *}
{block name='head_microdata_special'}
  {$smarty.block.parent}
  <script type="application/ld+json">
  {literal}
  {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "{/literal}{if isset($shop.name)}{$shop.name|escape:'html':'UTF-8'}{else}Mundo Limpio{/if}{literal}",
    "description": "Productos de limpieza sustentables y eco-friendly desde 2008. Protegemos el medio ambiente con soluciones de calidad superior.",
    "foundingDate": "2008",
    "address": {
      "@type": "PostalAddress",
      "addressLocality": "Posadas",
      "addressRegion": "Misiones",
      "addressCountry": "AR"
    }
  }
  {/literal}
  </script>
{/block}