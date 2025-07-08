{**
 * Contact Section for Mundo Limpio Theme Homepage
 * Content is semi-static for now.
 *}
<section class="homepage-section contact-section" id="contact"> {* Esta sección se incluye dentro de un .container en index.tpl *}
    {* Ya no necesitamos un <div class="container"> aquí si la sección entera está contenida desde index.tpl *}
    <div class="section-header">
        <h2 class="section-title">{l s='¿Hablamos? Estamos Aquí para Ayudarte' d='Shop.Theme.Mundolimpio'}</h2>
            <p class="section-subtitle">{l s='Si tienes preguntas, sugerencias o simplemente quieres saludar, no dudes en contactarnos.' d='Shop.Theme.Mundolimpio'}</p>
        </div>
        <div class="contact-content">
            <div class="contact-info">
                <div class="contact-item ml-animate-on-scroll anim-fadeInLeft">
                    <i class="material-icons">location_on</i>
                    <div>
                        <h4>{l s='Nuestra Tienda (Pick-up Point)' d='Shop.Theme.Mundolimpio'}</h4>
                        <p>{* TODO: Replace with actual address or use {$shop.addresses.address1} etc. if configured *}
                            Calle Falsa 123, Ciudad Verde<br>
                            Provincia Ejemplo, Argentina
                        </p>
                    </div>
                </div>
                <div class="contact-item ml-animate-on-scroll anim-fadeInLeft" data-delay="100">
                    <i class="material-icons">phone</i>
                    <div>
                        <h4>{l s='Llámanos' d='Shop.Theme.Mundolimpio'}</h4>
                        <p><a href="tel:+540111234567">{* TODO: Replace with actual phone or {$shop.phone} *} (+54) 011-1234-5678</a></p>
                    </div>
                </div>
                <div class="contact-item ml-animate-on-scroll anim-fadeInLeft" data-delay="200">
                    <i class="material-icons">email</i>
                    <div>
                        <h4>{l s='Escríbenos' d='Shop.Theme.Mundolimpio'}</h4>
                        <p><a href="mailto:{$shop.email|escape:'htmlall':'UTF-8'}">{$shop.email|escape:'htmlall':'UTF-8'}</a></p>
                    </div>
                </div>
                <div class="contact-item ml-animate-on-scroll anim-fadeInLeft" data-delay="300">
                    <i class="material-icons">schedule</i>
                    <div>
                        <h4>{l s='Horarios de Atención' d='Shop.Theme.Mundolimpio'}</h4>
                        <p>{* TODO: Replace with actual hours *}
                            Lunes a Viernes: 9:00 - 18:00 hs<br>
                            Sábados: 10:00 - 14:00 hs
                        </p>
                    </div>
                </div>
            </div>
            <div class="contact-form-wrapper ml-animate-on-scroll anim-fadeInRight">
                <h3 class="form-title">{l s='Envíanos un Mensaje Directo' d='Shop.Theme.Mundolimpio'}</h3>
                <form id="homepageContactForm" class="contact-form-inner js-contact-form" action="{$urls.pages.contact nofilter}" method="post">
                    {* Este es un formulario HTML básico. Para funcionalidad completa (envío de email, validación),
                       se necesitaría un módulo de contacto o lógica AJAX que envíe a un controlador.
                       Por ahora, es visual. El JS en theme.js intentará manejarlo vía AJAX si está configurado.
                    *}
                    <input type="hidden" name="from_page" value="homepage_contact_section">
                     <input type="hidden" name="id_contact" value="{$contact_form_id_contact|default:0}"> {* ID del contacto de la tienda para el controlador de contacto de PS *}
                    <input type="hidden" name="token" value="{$static_token}">


                    <div class="form-group">
                        <label for="hp-contact-name" class="sr-only">{l s='Tu Nombre' d='Shop.Forms.Labels'}</label>
                        <input type="text" id="hp-contact-name" name="from" class="form-control" placeholder="{l s='Tu Nombre' d='Shop.Forms.Labels'}" required>
                    </div>
                    <div class="form-group">
                         <label for="hp-contact-email" class="sr-only">{l s='Tu Correo Electrónico' d='Shop.Forms.Labels'}</label>
                        <input type="email" id="hp-contact-email" name="email" class="form-control" placeholder="{l s='Tu Correo Electrónico' d='Shop.Forms.Labels'}" required>
                    </div>
                     <div class="form-group">
                        <label for="hp-contact-subject" class="sr-only">{l s='Asunto' d='Shop.Forms.Labels'}</label>
                        <input type="text" id="hp-contact-subject" name="subject" class="form-control" placeholder="{l s='Asunto' d='Shop.Forms.Labels'}" required>
                    </div>
                    <div class="form-group">
                        <label for="hp-contact-message" class="sr-only">{l s='Tu Mensaje' d='Shop.Forms.Labels'}</label>
                        <textarea id="hp-contact-message" name="message" class="form-control" placeholder="{l s='Tu Mensaje' d='Shop.Forms.Labels'}" rows="5" required></textarea>
                    </div>
                    <button type="submit" name="submitMessage" class="btn btn-primary btn-block ml-ripple-effect">
                        {l s='Enviar Mensaje' d='Shop.Theme.Actions'}
                    </button>
                    <div class="contact-form-response" style="display:none; margin-top:15px;"></div>
                </form>
            </div>
        </div>

        {* Placeholder para un mapa si se desea. Se podría usar un iframe de Google Maps.
        <div class="contact-map" style="margin-top: 40px;">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d....YOUR_MAP_EMBED_CODE" width="100%" height="350" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
        </div>
        *}
    </div>
</section>
