/**
 * MlThemeBuilder - Frontend JavaScript
 * Handles theme interactions, animations, and dynamic behaviors.
 */

(function() {
    'use strict';

    const MlTheme = {
        // Configuration (can be overridden by data attributes or global JS vars if needed)
        config: {
            animationOffset: '100px', // How far from bottom of viewport to trigger animation
            lazyLoadOffset: '200px',  // How far from bottom of viewport to start loading images
            throttleDelay: 100,       // Milliseconds for scroll/resize throttle
            debounceDelay: 250,       // Milliseconds for resize debounce
            smoothScrollDuration: 800,
            brandsSlider: {
                speed: '30s', // Default animation speed for brands slider (CSS animation duration)
                pauseOnHover: true
            },
            contactForm: {
                ajaxUrl: (typeof prestashop !== 'undefined' && prestashop.urls.base_url ? prestashop.urls.base_url + 'modules/mlthemebuilder/ajax.php' : './modules/mlthemebuilder/ajax.php'), // Fallback, should be set via Media::addJsDef
                clearFormAfterSuccess: true
            }
        },

        // Initialization
        init: function() {
            this.setGlobalAjaxUrl(); // Set AJAX URL from prestashop object if available
            this.initSmoothScroll();
            this.initScrollAnimations();
            this.initLazyLoading();
            this.initMobileMenu();
            this.initStickyHeader();
            this.initScrollToTop();
            this.initRippleEffects();
            this.initBrandsSlider();
            this.initContactForms();
            // Add other initializations here (e.g., carousels, parallax, etc.)

            // Event listeners with throttling/debouncing
            window.addEventListener('scroll', this.utils.throttle(this.onScroll.bind(this), this.config.throttleDelay));
            window.addEventListener('resize', this.utils.debounce(this.onResize.bind(this), this.config.debounceDelay));

            // Initial check for elements in viewport (e.g., for animations on page load)
            this.onScroll();
            this.onResize();
            console.log('MlThemeBuilder Frontend JS Initialized.');
        },

        setGlobalAjaxUrl: function() {
            if (typeof prestashop !== 'undefined' && prestashop.urls && prestashop.urls.base_url) {
                // A more robust way to get the AJAX URL would be via a dedicated controller link
                // For now, assuming a generic ajax.php or using the contact form one as a base.
                // This should ideally be set via Media::addJsDef in the module's PHP.
                // Example: prestashop.modules.mlthemebuilder.ajaxUrl
                if (prestashop.modules && prestashop.modules.mlthemebuilder && prestashop.modules.mlthemebuilder.ajaxUrl) {
                     this.config.contactForm.ajaxUrl = prestashop.modules.mlthemebuilder.ajaxUrl;
                } else {
                    // Fallback if not defined specifically
                    // This is a guess, actual AJAX endpoint might be different or part of a controller
                    // For contact form, it might be a specific action to the module's controller.
                    // The user's ajax-handler.php was in /ajax/ directory, not a controller.
                    // So, this path needs to be correct.
                    this.config.contactForm.ajaxUrl = prestashop.urls.base_url + 'modules/mlthemebuilder/ajax-mlthemebuilder.php';
                }
            }
        },

        // --- Event Handlers (Throttled/Debounced) ---
        onScroll: function() {
            this.checkScrollAnimations();
            this.checkLazyLoad();
            this.checkStickyHeader();
            this.checkScrollToTopButton();
        },

        onResize: function() {
            // Recalculate layouts or element positions if needed
            this.closeMobileMenuOnDesktop(); // Example
        },

        // --- Smooth Scrolling for Anchors ---
        initSmoothScroll: function() {
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    const href = this.getAttribute('href');
                    if (href === '#' || href === '#!') return; // Ignore empty or placeholder links

                    const targetElement = document.querySelector(href);
                    if (targetElement) {
                        e.preventDefault();
                        const offsetTop = targetElement.getBoundingClientRect().top + window.pageYOffset;
                        // Consider fixed header height if any
                        const headerHeight = document.querySelector('header.sticky') ? document.querySelector('header.sticky').offsetHeight : 0;

                        window.scrollTo({
                            top: offsetTop - headerHeight - 20, // Extra 20px offset
                            behavior: 'smooth'
                        });
                    }
                });
            });
        },

        // --- Scroll Animations ---
        initScrollAnimations: function() {
            this.animatedElements = document.querySelectorAll('.ml-animate-on-scroll');
            if (!this.animatedElements.length) return;
            // Initial check in case elements are already in view
            this.checkScrollAnimations();
        },
        checkScrollAnimations: function() {
            if (!this.animatedElements || !this.animatedElements.length) return;
            this.animatedElements.forEach(el => {
                if (this.utils.isElementInView(el, this.config.animationOffset) && !el.classList.contains('is-visible')) {
                    el.classList.add('is-visible');
                    // Optional: remove event listener or class after animation to save resources
                    // if (el.dataset.animOnce) {
                    //    el.classList.remove('ml-animate-on-scroll');
                    // }
                }
            });
        },

        // --- Lazy Loading ---
        initLazyLoading: function() {
            this.lazyLoadImages = document.querySelectorAll('img.lazyload');
            if (!this.lazyLoadImages.length) return;

            // Support for IntersectionObserver if available
            if ('IntersectionObserver' in window) {
                const observer = new IntersectionObserver((entries, obs) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            this.loadLazyImage(entry.target);
                            obs.unobserve(entry.target);
                        }
                    });
                }, { rootMargin: this.config.lazyLoadOffset });
                this.lazyLoadImages.forEach(img => observer.observe(img));
            } else {
                // Fallback for older browsers (less performant)
                this.checkLazyLoad(); // Initial check
                // Scroll/resize events will call checkLazyLoad via onScroll
            }
        },
        loadLazyImage: function(img) {
            if (img.dataset.src) {
                img.src = img.dataset.src;
                if (img.dataset.srcset) {
                    img.srcset = img.dataset.srcset;
                }
                img.classList.remove('lazyload');
                img.classList.add('lazyloaded');
                img.removeAttribute('data-src');
                img.removeAttribute('data-srcset');
            }
        },
        checkLazyLoad: function() { // Fallback if IntersectionObserver not supported
            if ('IntersectionObserver' in window || !this.lazyLoadImages || !this.lazyLoadImages.length) return;

            this.lazyLoadImages.forEach(img => {
                if (img.classList.contains('lazyload') && this.utils.isElementInView(img, this.config.lazyLoadOffset)) {
                    this.loadLazyImage(img);
                }
            });
            // Remove loaded images from the list to improve performance
            this.lazyLoadImages = Array.from(this.lazyLoadImages).filter(img => img.classList.contains('lazyload'));
        },

        // --- Mobile Menu ---
        initMobileMenu: function() {
            const menuToggle = document.querySelector('.ml-menu-toggle'); // Standardize class name
            const mobileNav = document.querySelector('.ml-mobile-nav'); // Standardize class name

            if (menuToggle && mobileNav) {
                menuToggle.addEventListener('click', () => {
                    menuToggle.classList.toggle('active');
                    mobileNav.classList.toggle('active');
                    document.body.classList.toggle('mobile-menu-active'); // For potential overflow hidden
                });

                // Close menu when a link is clicked (for single-page navigation)
                mobileNav.querySelectorAll('a').forEach(link => {
                    link.addEventListener('click', () => {
                        if (mobileNav.classList.contains('active')) {
                             menuToggle.classList.remove('active');
                             mobileNav.classList.remove('active');
                             document.body.classList.remove('mobile-menu-active');
                        }
                    });
                });
            }
        },
        closeMobileMenuOnDesktop: function() {
            if (window.innerWidth > 991) { // Assuming 992px is desktop breakpoint
                const menuToggle = document.querySelector('.ml-menu-toggle.active');
                const mobileNav = document.querySelector('.ml-mobile-nav.active');
                if (menuToggle && mobileNav) {
                    menuToggle.classList.remove('active');
                    mobileNav.classList.remove('active');
                    document.body.classList.remove('mobile-menu-active');
                }
            }
        },

        // --- Sticky Header ---
        initStickyHeader: function() {
            this.header = document.querySelector('header.ml-main-header'); // Standardize class name
            this.stickyOffset = this.header ? (parseInt(this.header.dataset.stickyOffset) || 100) : 100;
            if (!this.header) return;
            this.checkStickyHeader(); // Initial check
        },
        checkStickyHeader: function() {
            if (!this.header) return;
            if (window.pageYOffset > this.stickyOffset) {
                this.header.classList.add('sticky');
            } else {
                this.header.classList.remove('sticky');
            }
        },

        // --- Scroll to Top Button ---
        initScrollToTop: function() {
            this.scrollToTopButton = document.querySelector('.ml-scroll-to-top'); // Standardize
            if (!this.scrollToTopButton) return;

            this.scrollToTopButton.addEventListener('click', (e) => {
                e.preventDefault();
                window.scrollTo({ top: 0, behavior: 'smooth' });
            });
            this.checkScrollToTopButton(); // Initial check
        },
        checkScrollToTopButton: function() {
            if (!this.scrollToTopButton) return;
            if (window.pageYOffset > 300) { // Show after 300px scroll
                this.scrollToTopButton.classList.add('visible');
            } else {
                this.scrollToTopButton.classList.remove('visible');
            }
        },

        // --- Ripple Effect for Buttons ---
        initRippleEffects: function() {
            document.querySelectorAll('.btn.ml-ripple-effect').forEach(button => { // Standardize
                button.addEventListener('click', function(e) {
                    const existingRipple = this.querySelector(".ripple");
                    if (existingRipple) existingRipple.remove();

                    const circle = document.createElement("span");
                    const diameter = Math.max(this.clientWidth, this.clientHeight);
                    const radius = diameter / 2;

                    circle.style.width = circle.style.height = `${diameter}px`;
                    // Get click position relative to the button
                    const rect = this.getBoundingClientRect();
                    circle.style.left = `${e.clientX - rect.left - radius}px`;
                    circle.style.top = `${e.clientY - rect.top - radius}px`;
                    circle.classList.add("ripple");

                    this.appendChild(circle);
                });
            });
        },

        // --- Brands Slider ---
        initBrandsSlider: function() {
            const sliders = document.querySelectorAll('.brands-section .brands-slider');
            sliders.forEach(slider => {
                const track = slider.querySelector('.brands-track');
                if (!track) return;

                const items = track.querySelectorAll('.brand-item');
                if (items.length === 0) return;

                // Clone items for infinite effect
                items.forEach(item => track.appendChild(item.cloneNode(true)));

                // Set animation duration from data attribute or config
                const duration = slider.dataset.duration || this.config.brandsSlider.speed;
                track.style.animationDuration = duration;
                track.classList.add('css-animated'); // Add class to trigger CSS animation

                if (this.config.brandsSlider.pauseOnHover) {
                    slider.addEventListener('mouseenter', () => track.style.animationPlayState = 'paused');
                    slider.addEventListener('mouseleave', () => track.style.animationPlayState = 'running');
                }
            });
        },

        // --- Contact Forms ---
        initContactForms: function() {
            const forms = document.querySelectorAll('form.contact-form-inner'); // Class from contact.tpl
            forms.forEach(form => {
                form.addEventListener('submit', this.handleContactFormSubmit.bind(this));
            });
        },
        handleContactFormSubmit: function(e) {
            e.preventDefault();
            const form = e.target;
            const submitButton = form.querySelector('button[type="submit"]');
            const responseDiv = form.querySelector('.contact-form-response');

            if (!responseDiv) {
                console.error('Contact form response div not found.');
                return;
            }

            // Basic validation (can be enhanced)
            let isValid = true;
            form.querySelectorAll('[required]').forEach(input => {
                if (!input.value.trim()) {
                    isValid = false;
                    input.classList.add('error'); // Add error class for styling
                } else {
                    input.classList.remove('error');
                }
            });

            if (!isValid) {
                responseDiv.innerHTML = `<p class="error">${prestashop.modules.mlthemebuilder.translations.fillRequiredFields || 'Please fill all required fields.'}</p>`;
                responseDiv.style.display = 'block';
                responseDiv.className = 'contact-form-response error';
                return;
            }

            const formData = new FormData(form);
            formData.append('action', 'submitContactForm'); // AJAX action for your handler
            formData.append('ajax', '1');
            // Add security token if your AJAX handler requires it
            // formData.append('token', prestashop.static_token);

            const originalButtonText = submitButton.innerHTML;
            submitButton.innerHTML = prestashop.modules.mlthemebuilder.translations.sending || 'Sending...';
            submitButton.disabled = true;
            responseDiv.style.display = 'none';

            fetch(this.config.contactForm.ajaxUrl, {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    responseDiv.innerHTML = `<p class="success">${data.message || prestashop.modules.mlthemebuilder.translations.messageSent || 'Message sent successfully!'}</p>`;
                    responseDiv.className = 'contact-form-response success';
                    if (this.config.contactForm.clearFormAfterSuccess) {
                        form.reset();
                    }
                } else {
                    responseDiv.innerHTML = `<p class="error">${data.message || prestashop.modules.mlthemebuilder.translations.errorSendingMessage || 'An error occurred. Please try again.'}</p>`;
                     responseDiv.className = 'contact-form-response error';
                }
            })
            .catch(error => {
                console.error('Contact form submission error:', error);
                responseDiv.innerHTML = `<p class="error">${prestashop.modules.mlthemebuilder.translations.errorSendingMessage || 'An error occurred. Please try again.'}</p>`;
                responseDiv.className = 'contact-form-response error';
            })
            .finally(() => {
                submitButton.innerHTML = originalButtonText;
                submitButton.disabled = false;
                responseDiv.style.display = 'block';
                setTimeout(() => { responseDiv.style.display = 'none'; }, 5000); // Hide after 5s
            });
        },


        // --- Utility Functions ---
        utils: {
            isElementInView: function(el, offset = '0px') {
                const rect = el.getBoundingClientRect();
                const viewHeight = Math.max(document.documentElement.clientHeight, window.innerHeight);
                // Check if bottom of element is past the top of viewport (minus offset)
                // AND top of element is before the bottom of viewport (plus offset)
                return !(rect.bottom < 0 || rect.top - viewHeight >= parseInt(offset));
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

    // Initialize the theme scripts when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => MlTheme.init());
    } else {
        MlTheme.init(); // DOMContentLoaded has already fired
    }

    // Expose MlTheme to global scope if needed for debugging or external calls
    window.MlTheme = MlTheme;

})();
