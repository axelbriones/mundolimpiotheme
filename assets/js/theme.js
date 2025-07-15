/**
 * Mundo Limpio Theme - Main JavaScript (theme.js)
 */
'use strict';

(function($) {
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
                contactForms: 'form.js-contact-form'
            },
            stickyHeaderOffset: 50, // Changed from 100 to 50 as per React example
            scrollToTopOffset: 400,
            animationOffset: '100px',
            lazyLoadRootMargin: '0px 0px 200px 0px',
            throttleDelay: 100,
            debounceDelay: 250,
            brandsSlider: {
                pauseOnHover: true
            },
            contactForm: {
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

            $(window).on('scroll', this.utils.throttle(this.onScroll.bind(this), this.config.throttleDelay));
            $(window).on('resize', this.utils.debounce(this.onResize.bind(this), this.config.debounceDelay));

            this.onScroll();
            this.onResize();
            // console.log('Mundo Limpio Theme JS Initialized');
        },

        initPrestashopDependencies: function() {
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
                 let baseUrl = (prestashop.urls && prestashop.urls.base_url) ? prestashop.urls.base_url : window.location.origin + '/';
                 if (!baseUrl.endsWith('/')) baseUrl += '/';
                 this.config.contactForm.ajaxUrl = baseUrl + 'index.php?fc=module&module=mlthemebuilder&controller=ajax';
                 // console.warn('MundoLimpioTheme: AJAX URL for contact form not found or misconfigured. Using fallback: ' + this.config.contactForm.ajaxUrl);
            }
        },

        onScroll: function() {
            this.handleStickyHeader(); // This will handle adding/removing 'is-scrolled'
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
                if ($nav.hasClass('open')) {
                    $toggle.removeClass('open');
                    $nav.removeClass('open');
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
                        // Use the SCROLLED height if header is sticky, otherwise 0 or initial height if always visible
                        if ($stickyHeader.length && $stickyHeader.hasClass('is-scrolled')) {
                             offsetTop -= MundoLimpioTheme.config.stickyHeaderOffsetScrolled || 70; // Use defined scrolled height
                        } else if ($stickyHeader.length && !$stickyHeader.hasClass('is-scrolled') && $stickyHeader.css('position') === 'fixed' && $stickyHeader.css('background-color') === 'transparent') {
                            // If header is fixed but transparent (initial state), still account for its height
                             offsetTop -= MundoLimpioTheme.config.stickyHeaderOffsetInitial || 80; // Use defined initial height
                        }

                        offsetTop -= 20;

                        $('html, body').animate({ scrollTop: offsetTop }, 800, 'swing');
                    }
                } catch (error) {
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
            const $toggle = $(this.config.selectors.mobileMenuToggle);
            const $menu = $(this.config.selectors.mobileNav);

            if ($toggle.length && $menu.length) {
                $toggle.on('click', function(e) {
                    e.preventDefault();
                    $menu.toggleClass('open');
                    $(this).toggleClass('open');
                    $('body').toggleClass('mobile-menu-open');
                });

                // Close menu if clicking on a link inside it (useful for one-page sites or anchor links)
                $menu.find('a').on('click', function() {
                    if ($menu.hasClass('open')) {
                        $toggle.removeClass('open');
                        $menu.removeClass('open');
                        $('body').removeClass('mobile-menu-open');
                    }
                });
            }
        },

        initStickyHeader: function() {
            this.$stickyHeader = $(this.config.selectors.stickyHeader);
            if (!this.$stickyHeader.length) return;
            // Use the specific offset from config, not data-attribute from header element itself
            this.stickyOffset = this.config.stickyHeaderOffset;
            this.config.stickyHeaderOffsetScrolled = parseInt(this.$stickyHeader.css('--ml-header-height-scrolled')) || 70; // Get from CSS var
            this.config.stickyHeaderOffsetInitial = parseInt(this.$stickyHeader.css('--ml-header-height')) || 80; // Get from CSS var

            this.handleStickyHeader(); // Initial check
        },
        handleStickyHeader: function() { // This is called on scroll
            if (!this.$stickyHeader || !this.$stickyHeader.length) return;
            if ($(window).scrollTop() > this.stickyOffset) {
                this.$stickyHeader.addClass('is-scrolled');
            } else {
                this.$stickyHeader.removeClass('is-scrolled');
            }
        },

        initScrollToTop: function() {
            this.$scrollToTopButton = $(this.config.selectors.scrollToTopButton);
            if (!this.$scrollToTopButton.length) {
                if ($('#ml-scroll-to-top-placeholder').length && !this.$scrollToTopButton.length) {
                    $('body').append('<a href="#" class="ml-scroll-to-top" aria-label="Scroll to top"><i class="material-icons">keyboard_arrow_up</i></a>');
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
                const $track = $thisSlider.find(MundoLimpioTheme.config.selectors.brandsSliderTrack);
                if (!$track.length) return;

                const $items = $track.children('.brand-item');
                if ($items.length <= 3) {
                    $track.css('justify-content', 'center');
                    return;
                }

                const sliderWidth = $thisSlider.width();
                let trackWidth = 0;
                $items.each(function() { trackWidth += $(this).outerWidth(true); });

                if (trackWidth > sliderWidth) {
                    $items.clone().appendTo($track);
                    $track.css('width', trackWidth * 2);

                    const duration = $thisSlider.data('duration') || "30s";
                    $track.css({
                        'animation-duration': duration,
                        'animation-name': 'ml-scroll-brands'
                    });
                    // $track.addClass('css-animated'); // This class might not be needed if animation-name is set directly

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

                    const originalButtonText = $submitButton.html();
                    $submitButton.html(prestashop.modules.mlthemebuilder.translations.sending).prop('disabled', true);
                    $responseDiv.hide().removeClass('success-message error-message').empty();

                    let ajaxUrl = $form.attr('action');
                    let isNativeContactForm = ajaxUrl.includes('controller=contact'); // Check if it's PS native contact form

                    if (!isNativeContactForm && (!ajaxUrl || ajaxUrl === '#')) {
                        ajaxUrl = self.config.contactForm.ajaxUrl;
                        if (!formData.has('action')) formData.append('action', 'submitContactForm'); // For our custom AJAX handler
                        if (!formData.has('ajax')) formData.append('ajax', '1');
                    }

                    $.ajax({
                        url: ajaxUrl,
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        dataType: isNativeContactForm ? 'html' : 'json', // Expect HTML from PS ContactController, JSON from ours
                        success: function(response) {
                            if (isNativeContactForm) {
                                // Handle HTML response from PrestaShop's ContactController
                                // Look for success/error messages within the HTML
                                let $responseHtml = $('<div>').html(response);
                                if ($responseHtml.find('.alert-success, .alert.alert-success').length > 0) {
                                    $responseDiv.html(`<p class="success-message">${prestashop.modules.mlthemebuilder.translations.messageSent}</p>`).addClass('success-message').show();
                                    if (self.config.contactForm.clearFormAfterSuccess) $form[0].reset();
                                } else {
                                     let errorMsg = $responseHtml.find('.alert-danger ul li, .alert.alert-danger ul li').first().text() || prestashop.modules.mlthemebuilder.translations.errorSendingMessage;
                                     $responseDiv.html(`<p class="error-message">${errorMsg}</p>`).addClass('error-message').show();
                                }
                            } else {
                                // Handle JSON response from our custom AJAX handler
                                if (response.success || (response.sent && !response.error)) {
                                    $responseDiv.html(`<p class="success-message">${response.message || prestashop.modules.mlthemebuilder.translations.messageSent}</p>`).addClass('success-message').show();
                                    if (self.config.contactForm.clearFormAfterSuccess) $form[0].reset();
                                } else {
                                    let errors = response.errors || (response.message ? [response.message] : [prestashop.modules.mlthemebuilder.translations.errorSendingMessage]);
                                    $responseDiv.html(`<p class="error-message">${errors.join('<br>')}</p>`).addClass('error-message').show();
                                }
                            }
                        },
                        error: function() {
                            $responseDiv.html(`<p class="error-message">${prestashop.modules.mlthemebuilder.translations.errorSendingMessage}</p>`).addClass('error-message').show();
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
