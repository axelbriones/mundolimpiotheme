{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
{extends file='page.tpl'}

    {block name='page_content_container'}
      <!-- Tema Mundo Limpio Hijo Activo -->
      <section id="content" class="page-home">
        {block name='page_content_top'}{/block}

        {block name='page_content'}
          {* Este es el bloque principal donde se mostrarán las secciones personalizadas.
             El hook_home original se puede mantener si algunos módulos estándar aún lo usan,
             o se puede reemplazar completamente con nuestra estructura de secciones.
             Por ahora, lo comentaremos para reemplazarlo con nuestra propia lógica de secciones.
          *}
          {* {$HOOK_HOME nofilter} *}

          {* Hero Section - Rendered directly to be full-width by default *}
          {include file="./_partials/homepage/hero.tpl"}

          {* Services Section - Assuming this section's background is NOT full-width, so its content is wrapped in a container. *}
          <div class="container">
            {include file="./_partials/homepage/services.tpl"}
          </div>

          {* Products Section - Assuming this section's background is NOT full-width. *}
          <div class="container">
            {include file="./_partials/homepage/products.tpl"}
          </div>

          {* Brands Section - Assuming this section's background is NOT full-width. *}
          <div class="container">
            {include file="./_partials/homepage/brands.tpl"}
          </div>

          {* Banner Section - Assuming this section's background is NOT full-width for now. *}
          {* If banner needs full-width BG, move include out of this container and handle container internally in banner.tpl *}
          <div class="container">
            {include file="./_partials/homepage/banner.tpl"}
          </div>

          {* Ecology Section - Assuming this section's background is NOT full-width. *}
          <div class="container">
            {include file="./_partials/homepage/ecology.tpl"}
          </div>

          {* Contact Section - Assuming this section's background is NOT full-width. *}
          <div class="container">
            {include file="./_partials/homepage/contact.tpl"}
          </div>

        {/block}
      </section>
    {/block}
