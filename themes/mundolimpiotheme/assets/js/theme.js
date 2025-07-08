/**
 * Mundo Limpio Theme - Main JavaScript (theme.js)
 */
'use strict';

(function($) { // Ensure jQuery is passed if PrestaShop's core.js provides it, or use vanilla JS.
             // For PrestaShop 1.7+, jQuery is usually available via `prestashop.jquery` or globally.

    const MundoLimpioTheme = {
        config: {
            selectors: {
                mobileMenuToggle: '.js-ml-menu-toggle',
                mobileNav: '.js-ml-mobile-nav',
                stickyHeader: 'header.ml-main-header',
                scrollToTopButton: '.ml-scroll-to-top',
                animatedElements: '.ml-animate-on-scroll',
                lazyLoadImages: 'img.lazyload',
                rippleEffectButtons: '.btn.ml-ripple-effect',
                brandsSlider: '.brands-section .brands-slider',
                brandsSliderTrack: '.brands-section .brands-track',
                contactForms: 'form.js-contact-form' // Used in contact.tpl for the homepage contact form
            },
            stickyHeaderOffset: 100, // Pixels from top to make header sticky
            scrollToTopOffset: 400,  // Pixels from top to show scroll-to-top button
            animationOffset: '100px', // How early to trigger animation (pixels from bottom of viewport)
            lazyLoadRootMargin: '0px 0px 200px 0px', // For IntersectionObserver
            throttleDelay: 150,      // ms
            debounceDelay: 300,      // ms
            brandsSlider: {
                pauseOnHover: true
            },
            contactForm: {
                // ajaxUrl is now expected to be set via prestashop.modules.mlthemebuilder.ajaxUrl (from header.tpl)
                clearFormAfterSuccess: true
            }
        },

        init: function() {
            this.initPrestashopDependencies();
            this.initSmoothScroll();
            this.initScrollAnimations();
            this.initLazyLoading();
            this.initMobileMenu();
            this.initStickyHeader();
            this.initScrollToTop();
            this.initRippleEffects();
            this.initBrandsSlider();
            this.initContactForms();

            // Use jQuery for window events if $ is jQuery
            $(window).on('scroll', this.utils.throttle(this.onScroll.bind(this), this.config.throttleDelay));
            $(window).on('resize', this.utils.debounce(this.onResize.bind(this), this.config.debounceDelay));

            this.onScroll();
            this.onResize();
            // console.log('Mundo Limpio Theme JS Initialized');
        },

        initPrestashopDependencies: function() {
            // Ensure translations and AJAX URL are loaded (should be done via Media::addJsDef in header.tpl)
            window.prestashop = window.prestashop || {};
            prestashop.modules = prestashop.modules || {};
            prestashop.modules.mlthemebuilder = prestashop.modules.mlthemebuilder || {};
            prestashop.modules.mlthemebuilder.translations = prestashop.modules.mlthemebuilder.translations || {
                sending: 'Enviando...',
                messageSent: '¡Mensaje enviado!',
                errorSendingMessage: 'Error al enviar. Intente de nuevo.',
                fillRequiredFields: 'Por favor, complete los campos requeridos.'
            };
            if (typeof prestashop.modules.mlthemebuilder.ajaxUrl !== 'undefined') {
                this.config.contactForm.ajaxUrl = prestashop.modules.mlthemebuilder.ajaxUrl;
            } else {
                 // Fallback if not set by header.tpl - this path is a guess.
                 // The module ajax handler is at modules/mlthemebuilder/ajax/ajax-mlthemebuilder.php
                 // The theme context is themes/mundolimpiotheme/
                 // So, the path from webroot would be modules/mlthemebuilder/ajax-mlthemebuilder.php
                 let baseUrl = (prestashop.urls && prestashop.urls.base_url) ? prestashop.urls.base_url : '/';
                 if (!baseUrl.endsWith('/')) baseUrl += '/';
                 this.config.contactForm.ajaxUrl = baseUrl + 'modules/mlthemebuilder/ajax-mlthemebuilder.php';
                 // console.warn('MundoLimpioTheme: AJAX URL for contact form not found, using fallback: ' + this.config.contactForm.ajaxUrl);
            }
        },

        onScroll: function() {
            this.handleStickyHeader();
            this.handleScrollToTopButton();
            this.triggerAnimationsOnScroll();
            if (!('IntersectionObserver' in window)) {
                this.checkLazyLoadFallback();
            }
        },

        onResize: function() {
            if (window.innerWidth > 991) {
                const $toggle = $(this.config.selectors.mobileMenuToggle);
                const $nav = $(this.config.selectors.mobileNav);
                if ($nav.hasClass('active') || $nav.hasClass('open')) { // Check for 'open' too
                    $toggle.removeClass('active open');
                    $nav.removeClass('active open');
                    $('body').removeClass('mobile-menu-open');
                }
            }
        },

        initSmoothScroll: function() {
            $('a[href^="#"]').not('[href="#"]').not('[href="#!"]').not('[data-toggle="tab"]').not('[data-toggle="collapse"]').on('click', function(e) {
                const targetSelector = $(this).attr('href');
                try {
                    const $target = $(targetSelector);
                    if ($target.length) {
                        e.preventDefault();
                        let offsetTop = $target.offset().top;
                        const $stickyHeader = $(MundoLimpioTheme.config.selectors.stickyHeader);
                        if ($stickyHeader.length && $stickyHeader.hasClass('is-sticky')) {
                            offsetTop -= $stickyHeader.outerHeight();
                        }
                        offsetTop -= 20;

                        $('html, body').animate({ scrollTop: offsetTop }, 800, 'swing');
                    }
                } catch (error) {
                    // If targetSelector is not a valid jQuery selector (e.g. contains invalid characters after #)
                    // console.warn('SmoothScroll: Invalid target selector:', targetSelector);
                }
            });
        },

        initScrollAnimations: function() {
            this.$animatedElements = $(this.config.selectors.animatedElements);
            if (!this.$animatedElements.length) return;

            if ('IntersectionObserver' in window) {
                const observer = new IntersectionObserver((entries, obs) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const $el = $(entry.target);
                            const animationType = $el.data('animation') || 'fadeInUp';
                            const animationDelay = parseInt($el.data('delay')) || 0;

                            setTimeout(() => {
                                $el.addClass('animate-' + animationType).addClass('is-visible');
                            }, animationDelay);

                            obs.unobserve(entry.target);
                        }
                    });
                }, {
                    rootMargin: `0px 0px -${this.config.animationOffset} 0px`,
                    threshold: 0.01
                });
                this.$animatedElements.each((i, el) => observer.observe(el));
            } else {
                this.triggerAnimationsOnScroll();
            }
        },
        triggerAnimationsOnScroll: function() {
             if ('IntersectionObserver' in window || !this.$animatedElements || !this.$animatedElements.length) return;
            this.$animatedElements.each((i, el) => {
                const $el = $(el);
                if (this.utils.isElementInView($el[0], this.config.animationOffset) && !$el.hasClass('is-visible')) {
                    const animationType = $el.data('animation') || 'fadeInUp';
                    const animationDelay = parseInt($el.data('delay')) || 0;
                    setTimeout(() => {
                        $el.addClass('animate-' + animationType).addClass('is-visible');
                    }, animationDelay);
                }
            });
        },

        initLazyLoading: function() {
            this.$lazyImages = $(this.config.selectors.lazyLoadImages);
            if (!this.$lazyImages.length) return;

            if ('IntersectionObserver' in window) {
                const observer = new IntersectionObserver((entries, obs) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const img = entry.target;
                            this.loadLazyImage(img);
                            obs.unobserve(img);
                        }
                    });
                }, { rootMargin: this.config.lazyLoadRootMargin });
                this.$lazyImages.each((i, img) => observer.observe(img));
            } else {
                this.checkLazyLoadFallback();
            }
        },
        loadLazyImage: function(img) {
            const $img = $(img);
            if ($img.data('src')) $img.attr('src', $img.data('src'));
            if ($img.data('srcset')) $img.attr('srcset', $img.data('srcset'));
            $img.removeClass('lazyload').addClass('lazyloaded').removeAttr('data-src data-srcset');
        },
        checkLazyLoadFallback: function() {
            if ('IntersectionObserver' in window || !this.$lazyImages || !this.$lazyImages.length) return;
            this.$lazyImages.each((i, img) => {
                if ($(img).hasClass('lazyload') && this.utils.isElementInView(img, this.config.lazyLoadRootMargin)) {
                    this.loadLazyImage(img);
                }
            });
            this.$lazyImages = $(this.config.selectors.lazyLoadImages);
        },

        initMobileMenu: function() {
            // This needs to match the HTML structure of your mobile menu toggle and navigation
            // Assuming standard PrestaShop `classic` theme structure or similar overrides
            // The `js-ml-menu-toggle` and `js-ml-mobile-nav` are placeholders.
            // You might need to target PrestaShop's default classes if you haven't overridden the header tpl significantly.
            // e.g., '#menu-icon' and '#mobile_top_menu_wrapper' or similar.
            const $toggle = $(this.config.selectors.mobileMenuToggle); // Or PrestaShop's default: $('#menu-icon')
            const $menu = $(this.config.selectors.mobileNav);     // Or PrestaShop's default: prestashop.responsive.mobile_menu_selector

            if ($toggle.length && $menu.length) {
                $toggle.on('click', function() {
                    $menu.toggleClass('open'); // Add/remove 'open' class to the menu
                    $(this).toggleClass('open'); // Add/remove 'open' class to the toggle icon
                    $('body').toggleClass('mobile-menu-open'); // For overflow:hidden etc.
                });
            } else {
                // console.warn('Mobile menu toggle or nav not found with selectors:', this.config.selectors.mobileMenuToggle, this.config.selectors.mobileNav);
            }
        },

        initStickyHeader: function() {
            this.$stickyHeader = $(this.config.selectors.stickyHeader);
            if (!this.$stickyHeader.length) return;
            this.stickyOffset = this.$stickyHeader.data('sticky-offset') || this.config.stickyHeaderOffset;
            this.handleStickyHeader();
        },
        handleStickyHeader: function() {
            if (!this.$stickyHeader || !this.$stickyHeader.length) return;
            if ($(window).scrollTop() > this.stickyOffset) {
                this.$stickyHeader.addClass('is-sticky');
            } else {
                this.$stickyHeader.removeClass('is-sticky');
            }
        },

        initScrollToTop: function() {
            this.$scrollToTopButton = $(this.config.selectors.scrollToTopButton);
            if (!this.$scrollToTopButton.length) {
                // Create it if it doesn't exist and a placeholder div is there
                if ($('#ml-scroll-to-top-placeholder').length && !this.$scrollToTopButton.length) {
                    $('body').append('<a href="#" class="ml-scroll-to-top"><i class="material-icons">keyboard_arrow_up</i></a>');
                    this.$scrollToTopButton = $(this.config.selectors.scrollToTopButton);
                } else {
                    return;
                }
            }
            this.$scrollToTopButton.on('click', (e) => {
                e.preventDefault();
                $('html, body').animate({ scrollTop: 0 }, 500);
            });
            this.handleScrollToTopButton();
        },
        handleScrollToTopButton: function() {
            if (!this.$scrollToTopButton || !this.$scrollToTopButton.length) return;
            if ($(window).scrollTop() > this.config.scrollToTopOffset) {
                this.$scrollToTopButton.addClass('visible');
            } else {
                this.$scrollToTopButton.removeClass('visible');
            }
        },

        initRippleEffects: function() {
            $(this.config.selectors.rippleEffectButtons).on('click', function(e) {
                const $button = $(this);
                $button.find(".ripple-effect-span").remove();
                const $ripple = $('<span class="ripple-effect-span"></span>');
                const diameter = Math.max($button.outerWidth(), $button.outerHeight());
                const radius = diameter / 2;
                $ripple.css({
                    width: diameter, height: diameter,
                    left: e.pageX - $button.offset().left - radius,
                    top: e.pageY - $button.offset().top - radius
                }).appendTo($button);
                setTimeout(() => $ripple.remove(), 700);
            });
        },

        initBrandsSlider: function() {
            const $sliderContainers = $(this.config.selectors.brandsSlider);
            if (!$sliderContainers.length) return;

            $sliderContainers.each(function() {
                const $thisSlider = $(this);
                const $track = $thisSlider.find('.brands-track'); // Changed selector
                if (!$track.length) return;

                const $items = $track.children('.brand-item');
                if ($items.length <= 3) { // Don't animate if few items that likely fit
                    $track.css('justify-content', 'center'); // Center items if they fit
                    return;
                }

                const sliderWidth = $thisSlider.width();
                let trackWidth = 0;
                $items.each(function() { trackWidth += $(this).outerWidth(true); });

                if (trackWidth > sliderWidth) {
                    $items.clone().appendTo($track); // Clone for infinite loop
                    $track.css('width', trackWidth * 2);

                    const duration = $thisSlider.data('duration') || "30s"; // Get from data-attribute or default
                    $track.css({
                        'animation-duration': duration,
                        'animation-name': 'ml-scroll-brands' // Make sure this keyframe is in CSS
                    });
                    $track.addClass('css-animated');

                    if (MundoLimpioTheme.config.brandsSlider.pauseOnHover) {
                        $thisSlider.on('mouseenter', () => $track.css('animation-play-state', 'paused'));
                        $thisSlider.on('mouseleave', () => $track.css('animation-play-state', 'running'));
                    }
                } else {
                    $track.css('justify-content', 'center');
                }
            });
        },

        initContactForms: function() {
            const self = this;
            $(this.config.selectors.contactForms).each(function() {
                const $form = $(this);
                $form.on('submit', function(e) {
                    e.preventDefault();
                    const $submitButton = $form.find('button[type="submit"]');
                    let $responseDiv = $form.find('.contact-form-response');
                    if (!$responseDiv.length) {
                        $responseDiv = $('<div class="contact-form-response" style="display:none; margin-top:15px;"></div>').insertAfter($submitButton);
                    }

                    let isValid = true;
                    $form.find('[required]').each(function(){
                        if(!$(this).val().trim()){ isValid = false; $(this).addClass('form-error'); }
                        else { $(this).removeClass('form-error'); }
                    });

                    if (!isValid) {
                        $responseDiv.html(`<p class="error-message">${prestashop.modules.mlthemebuilder.translations.fillRequiredFields}</p>`).show();
                        return;
                    }

                    const formData = new FormData(this);
                    // If this form is the main PrestaShop contact form, its action should already point to ContactController.
                    // If it's a custom form handled by our module's AJAX:
                    // formData.append('action', 'submitContactForm'); // Ensure this matches a case in ajax-mlthemebuilder.php
                    // formData.append('ajax', '1');
                    // if (prestashop && prestashop.static_token) { formData.append('token', prestashop.static_token); }


                    const originalButtonText = $submitButton.html();
                    $submitButton.html(prestashop.modules.mlthemebuilder.translations.sending).prop('disabled', true);
                    $responseDiv.hide().removeClass('success-message error-message').empty();

                    let ajaxUrl = $form.attr('action');
                    let isNativeContactForm = ajaxUrl.includes('controller=contact');

                    if (!isNativeContactForm && (!ajaxUrl || ajaxUrl === '#')) {
                        ajaxUrl = self.config.contactForm.ajaxUrl;
                        if (!formData.has('action')) formData.append('action', 'submitContactForm');
                        if (!formData.has('ajax')) formData.append('ajax', '1');
                    }


                    $.ajax({
                        url: ajaxUrl,
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        dataType: 'json', // Expect JSON from our custom AJAX
                        success: function(response) {
                            // This success/error handling is for OUR custom AJAX handler.
                            // If submitting to PrestaShop's ContactController, the response might be different (e.g. HTML with messages).
                            if (response.success || (response.sent && !response.error) || (response.message && response.message.includes('successfully'))) {
                                $responseDiv.html(`<p class="success-message">${response.message || prestashop.modules.mlthemebuilder.translations.messageSent}</p>`).addClass('success-message').show();
                                if (self.config.contactForm.clearFormAfterSuccess) $form[0].reset();
                            } else {
                                let errors = response.errors || (response.message ? [response.message] : [prestashop.modules.mlthemebuilder.translations.errorSendingMessage]);
                                $responseDiv.html(`<p class="error-message">${errors.join('<br>')}</p>`).addClass('error-message').show();
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            // Handle PrestaShop's ContactController HTML response if that's the case
                            if (isNativeContactForm && jqXHR.responseText) {
                                // Try to parse for success/error messages in HTML response
                                if (jqXHR.responseText.includes('alert-success') || jqXHR.responseText.includes('alert alert-success')) {
                                     $responseDiv.html(`<p class="success-message">${prestashop.modules.mlthemebuilder.translations.messageSent}</p>`).addClass('success-message').show();
                                     if (self.config.contactForm.clearFormAfterSuccess) $form[0].reset();
                                } else if (jqXHR.responseText.includes('alert-danger') || jqXHR.responseText.includes('alert alert-danger')) {
                                     // Extract error message if possible, or show generic
                                     let $errorHtml = $(jqXHR.responseText);
                                     let errorMsg = $errorHtml.find('.alert.alert-danger ul li').first().text() || prestashop.modules.mlthemebuilder.translations.errorSendingMessage;
                                     $responseDiv.html(`<p class="error-message">${errorMsg}</p>`).addClass('error-message').show();
                                } else {
                                     $responseDiv.html(`<p class="error-message">${prestashop.modules.mlthemebuilder.translations.errorSendingMessage} (Unknown response)</p>`).addClass('error-message').show();
                                }
                            } else {
                                // console.error("Contact form AJAX error:", textStatus, errorThrown, jqXHR.responseText);
                                $responseDiv.html(`<p class="error-message">${prestashop.modules.mlthemebuilder.translations.errorSendingMessage}</p>`).addClass('error-message').show();
                            }
                        },
                        complete: function() {
                            $submitButton.html(originalButtonText).prop('disabled', false);
                            setTimeout(() => $responseDiv.fadeOut(() => $responseDiv.empty().removeClass('success-message error-message')), 7000);
                        }
                    });
                });
            });
        },

        utils: {
            isElementInView: function(el, offsetOption = '0px') {
                const rect = el.getBoundingClientRect();
                const viewHeight = Math.max(document.documentElement.clientHeight, window.innerHeight);
                let offsetValue = 0;
                if (typeof offsetOption === 'string') {
                    if (offsetOption.includes('%')) {
                        offsetValue = (parseFloat(offsetOption) / 100) * viewHeight;
                    } else {
                        offsetValue = parseInt(offsetOption) || 0;
                    }
                }
                return rect.top < (viewHeight - offsetValue) && rect.bottom > offsetValue;
            },
            throttle: function(func, limit) {
                let inThrottle;
                return function() {
                    const args = arguments;
                    const context = this;
                    if (!inThrottle) {
                        func.apply(context, args);
                        inThrottle = true;
                        setTimeout(() => inThrottle = false, limit);
                    }
                };
            },
            debounce: function(func, delay) {
                let timeout;
                return function() {
                    const context = this;
                    const args = arguments;
                    clearTimeout(timeout);
                    timeout = setTimeout(() => func.apply(context, args), delay);
                };
            }
        }
    };

    $(document).ready(function() {
        MundoLimpioTheme.init();
    });

})(jQuery);
>>>>>>> REPLACE
