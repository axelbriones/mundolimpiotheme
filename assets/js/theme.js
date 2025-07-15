/**
 * Mundo Limpio Theme - Main JavaScript (theme.js)
 */
'use strict';

(function($) {
    const MundoLimpioTheme = {
        init: function() {
            this.initMobileMenu();
            this.initStickyHeader();
            $(window).on('scroll', this.throttle(this.onScroll.bind(this), 100));
        },

        onScroll: function() {
            this.handleStickyHeader();
        },

        initMobileMenu: function() {
            const $toggle = $('.js-ml-menu-toggle');
            const $menu = $('.js-ml-mobile-nav');

            if ($toggle.length && $menu.length) {
                $toggle.on('click', function(e) {
                    e.preventDefault();
                    $menu.toggleClass('open');
                    $(this).toggleClass('open');
                    $('body').toggleClass('mobile-menu-open');
                });

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
            this.$stickyHeader = $('#header');
            if (!this.$stickyHeader.length) return;
            this.stickyOffset = 50;
            this.handleStickyHeader();
        },

        handleStickyHeader: function() {
            if (!this.$stickyHeader || !this.$stickyHeader.length) return;
            if ($(window).scrollTop() > this.stickyOffset) {
                this.$stickyHeader.addClass('bg-white shadow-lg');
                this.$stickyHeader.find('.material-icons').removeClass('text-white').addClass('text-gray-700');
            } else {
                this.$stickyHeader.removeClass('bg-white shadow-lg');
                this.$stickyHeader.find('.material-icons').removeClass('text-gray-700').addClass('text-white');
            }
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
        }
    };

    $(document).ready(function() {
        MundoLimpioTheme.init();
    });

})(jQuery);
