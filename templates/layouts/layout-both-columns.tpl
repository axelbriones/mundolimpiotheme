{**
 * Layout Both Columns - Mundo Limpio Theme
 * Layout principal que extiende el tema Classic de PrestaShop
 *}

{extends file='parent:layouts/layout-both-columns.tpl'}

{block name='stylesheets'}
  {$smarty.block.parent}
  {if isset($theme_assets)}
    <link rel="stylesheet" href="{$theme_assets}css/theme.css" type="text/css" media="all">
  {else}
    <link rel="stylesheet" href="{$urls.theme_assets}css/theme.css" type="text/css" media="all">
  {/if}
{/block}

{block name='header'}
  {include file='_partials/header.tpl'}
{/block}

{block name='javascript_bottom'}
  {$smarty.block.parent}
  {if isset($theme_assets)}
    <script src="{$theme_assets}js/theme.js" defer></script>
  {else}
    <script src="{$urls.theme_assets}js/theme.js" defer></script>
  {/if}
{/block}

{block name='body_classes'}mundo-limpio-theme {if isset($page.page_name)}page-{$page.page_name|escape:'html':'UTF-8'}{/if}{/block}

{block name='head_microdata_special'}
  {$smarty.block.parent}
  {if isset($shop.name)}
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "Organization",
      "name": "{$shop.name|escape:'html':'UTF-8'}",
      "description": "Productos de limpieza sustentables y eco-friendly desde 2008. Protegemos el medio ambiente con soluciones de calidad superior.",
      "foundingDate": "2008",
      "address": {
        "@type": "PostalAddress",
        "addressLocality": "Posadas",
        "addressRegion": "Misiones",
        "addressCountry": "AR"
      }
    }
    </script>
  {/if}
{/block}