/**
 * Mundo Limpio Theme - Main JavaScript
 * Handles sticky header, mobile menu, scroll effects, and animations
 */

class MundoLimpioTheme {
    constructor() {
        this.header = document.getElementById('header');
        this.mobileMenuToggle = document.getElementById('mobile-menu-toggle');
        this.mobileMenu = document.getElementById('mobile-menu');
        this.backToTopButton = document.getElementById('back-to-top');
        
        this.lastScrollY = 0;
        this.isScrollingUp = false;
        this.scrollThreshold = 100;
        this.isMobileMenuOpen = false;
        
        this.init();
    }

    init() {
        this.bindEvents();
        this.initScrollBehavior();
        this.initMobileMenu();
        this.initBackToTop();
        this.initAnimations();
        this.initSmoothScroll();
        this.initLazyLoading();
        
        // Performance optimization
        this.throttledScrollHandler = this.throttle(this.handleScroll.bind(this), 16);
        this.throttledResizeHandler = this.throttle(this.handleResize.bind(this), 250);
    }

    bindEvents() {
        // Scroll events
        window.addEventListener('scroll', this.throttledScrollHandler, { passive: true });
        window.addEventListener('resize', this.throttledResizeHandler);
        
        // Mobile menu events
        if (this.mobileMenuToggle) {
            this.mobileMenuToggle.addEventListener('click', this.toggleMobileMenu.bind(this));
        }

        // Back to top events
        if (this.backToTopButton) {
            this.backToTopButton.addEventListener('click', this.scrollToTop.bind(this));
        }

        // Close mobile menu when clicking outside
        document.addEventListener('click', (e) => {
            if (this.isMobileMenuOpen && !this.mobileMenu.contains(e.target) && !this.mobileMenuToggle.contains(e.target)) {
                this.closeMobileMenu();
            }
        });

        // ESC key to close mobile menu
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && this.isMobileMenuOpen) {
                this.closeMobileMenu();
            }
        });

        // Prevent scroll when mobile menu is open
        this.preventBodyScrollWhenMenuOpen();
    }

    handleScroll() {
        const currentScrollY = window.scrollY;
        
        // Determine scroll direction
        this.isScrollingUp = currentScrollY < this.lastScrollY;
        
        // Handle sticky header behavior
        this.handleStickyHeader(currentScrollY);
        
        // Handle back to top button
        this.handleBackToTopVisibility(currentScrollY);
        
        // Handle scroll-based animations
        this.handleScrollAnimations(currentScrollY);
        
        this.lastScrollY = currentScrollY;
    }

    handleStickyHeader(scrollY) {
        if (!this.header) return;

        if (scrollY > this.scrollThreshold) {
            // Add shadow and adjust header when scrolled
            this.header.classList.add('scrolled');
            
            if (this.isScrollingUp) {
                // Show header when scrolling up
                this.header.style.transform = 'translateY(0)';
                this.header.classList.remove('hidden-header');
            } else {
                // Hide header when scrolling down
                this.header.style.transform = 'translateY(-100%)';
                this.header.classList.add('hidden-header');
            }
        } else {
            // Always show header at top
            this.header.style.transform = 'translateY(0)';
            this.header.classList.remove('scrolled', 'hidden-header');
        }
    }

    handleBackToTopVisibility(scrollY) {
        if (!this.backToTopButton) return;

        if (scrollY > 500) {
            this.backToTopButton.classList.remove('translate-y-16', 'opacity-0');
            this.backToTopButton.classList.add('translate-y-0', 'opacity-100');
        } else {
            this.backToTopButton.classList.add('translate-y-16', 'opacity-0');
            this.backToTopButton.classList.remove('translate-y-0', 'opacity-100');
        }
    }

    handleScrollAnimations(scrollY) {
        // Animate elements on scroll
        const animatedElements = document.querySelectorAll('[data-scroll-animation]');
        
        animatedElements.forEach(element => {
            const elementTop = element.offsetTop;
            const elementHeight = element.offsetHeight;
            const windowHeight = window.innerHeight;
            
            if (scrollY + windowHeight > elementTop + elementHeight * 0.1) {
                element.classList.add('animate-fade-in-up');
                element.classList.remove('opacity-0', 'translate-y-8');
            }
        });
    }

    initScrollBehavior() {
        // Add scroll-based classes to header
        if (this.header) {
            this.header.style.transition = 'transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out';
        }
    }

    initMobileMenu() {
        if (!this.mobileMenu || !this.mobileMenuToggle) return;

        // Set initial state
        this.mobileMenu.style.transform = 'translateY(-100%)';
        this.mobileMenu.style.opacity = '0';
        this.mobileMenu.style.visibility = 'hidden';
    }

    toggleMobileMenu() {
        if (this.isMobileMenuOpen) {
            this.closeMobileMenu();
        } else {
            this.openMobileMenu();
        }
    }

    openMobileMenu() {
        if (!this.mobileMenu || !this.mobileMenuToggle) return;

        this.isMobileMenuOpen = true;
        
        // Update button icon
        const icon = this.mobileMenuToggle.querySelector('i');
        if (icon) {
            icon.textContent = 'close';
        }
        
        // Show menu
        this.mobileMenu.style.visibility = 'visible';
        this.mobileMenu.style.transform = 'translateY(0)';
        this.mobileMenu.style.opacity = '1';
        
        // Prevent body scroll
        document.body.classList.add('overflow-hidden');
        
        // Animate menu items
        const menuItems = this.mobileMenu.querySelectorAll('.mobile-nav-link');
        menuItems.forEach((item, index) => {
            item.style.transitionDelay = `${index * 0.1}s`;
            item.classList.add('animate-fade-in-up');
        });
    }

    closeMobileMenu() {
        if (!this.mobileMenu || !this.mobileMenuToggle) return;

        this.isMobileMenuOpen = false;
        
        // Update button icon
        const icon = this.mobileMenuToggle.querySelector('i');
        if (icon) {
            icon.textContent = 'menu';
        }
        
        // Hide menu
        setTimeout(() => {
            this.mobileMenu.style.visibility = 'hidden';
        }, 300);
        
        this.mobileMenu.style.transform = 'translateY(-100%)';
        this.mobileMenu.style.opacity = '0';
        
        // Allow body scroll
        document.body.classList.remove('overflow-hidden');
        
        // Reset menu items animation
        const menuItems = this.mobileMenu.querySelectorAll('.mobile-nav-link');
        menuItems.forEach(item => {
            item.style.transitionDelay = '0s';
            item.classList.remove('animate-fade-in-up');
        });
    }

    initBackToTop() {
        if (!this.backToTopButton) return;

        // Set initial state
        this.backToTopButton.classList.add('translate-y-16', 'opacity-0');
    }

    scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }

    initAnimations() {
        // Intersection Observer for scroll animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-fade-in-up');
                    entry.target.classList.remove('opacity-0', 'translate-y-8');
                }
            });
        }, observerOptions);

        // Observe elements with scroll animation
        const animatedElements = document.querySelectorAll('[data-scroll-animation]');
        animatedElements.forEach(element => {
            element.classList.add('opacity-0', 'translate-y-8');
            observer.observe(element);
        });
    }

    initSmoothScroll() {
        // Smooth scroll for anchor links
        const anchorLinks = document.querySelectorAll('a[href^="#"]');
        
        anchorLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                const href = link.getAttribute('href');
                
                if (href === '#') return;
                
                const target = document.querySelector(href);
                
                if (target) {
                    e.preventDefault();
                    
                    const headerHeight = this.header ? this.header.offsetHeight : 0;
                    const targetPosition = target.offsetTop - headerHeight - 20;
                    
                    window.scrollTo({
                        top: targetPosition,
                        behavior: 'smooth'
                    });
                    
                    // Close mobile menu if open
                    if (this.isMobileMenuOpen) {
                        this.closeMobileMenu();
                    }
                }
            });
        });
    }

    initLazyLoading() {
        // Simple lazy loading for images
        const images = document.querySelectorAll('img[data-src]');
        
        const imageObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.classList.remove('opacity-0');
                    img.classList.add('opacity-100', 'transition-opacity', 'duration-500');
                    imageObserver.unobserve(img);
                }
            });
        });

        images.forEach(img => {
            img.classList.add('opacity-0');
            imageObserver.observe(img);
        });
    }

    preventBodyScrollWhenMenuOpen() {
        // Prevent background scroll when mobile menu is open
        let startY = 0;
        
        document.addEventListener('touchstart', (e) => {
            if (this.isMobileMenuOpen && !this.mobileMenu.contains(e.target)) {
                startY = e.touches[0].clientY;
            }
        }, { passive: false });
        
        document.addEventListener('touchmove', (e) => {
            if (this.isMobileMenuOpen && !this.mobileMenu.contains(e.target)) {
                e.preventDefault();
            }
        }, { passive: false });
    }

    handleResize() {
        // Close mobile menu on desktop
        if (window.innerWidth >= 1024 && this.isMobileMenuOpen) {
            this.closeMobileMenu();
        }
        
        // Recalculate positions and sizes
        this.handleScroll();
    }

    // Utility function for throttling
    throttle(func, limit) {
        let inThrottle;
        return function() {
            const args = arguments;
            const context = this;
            if (!inThrottle) {
                func.apply(context, args);
                inThrottle = true;
                setTimeout(() => inThrottle = false, limit);
            }
        }
    }

    // Utility function for debouncing
    debounce(func, wait, immediate) {
        let timeout;
        return function() {
            const context = this;
            const args = arguments;
            const later = function() {
                timeout = null;
                if (!immediate) func.apply(context, args);
            };
            const callNow = immediate && !timeout;
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
            if (callNow) func.apply(context, args);
        };
    }
}

// Additional utility functions
const MundoLimpioUtils = {
    // Form validation
    validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    },

    // Show notification
    showNotification(message, type = 'info', duration = 5000) {
        const notification = document.createElement('div');
        notification.className = `fixed top-4 right-4 z-50 px-6 py-4 rounded-lg shadow-lg text-white transform translate-x-full transition-transform duration-300 ${
            type === 'success' ? 'bg-green-600' : 
            type === 'error' ? 'bg-red-600' : 
            type === 'warning' ? 'bg-yellow-600' : 'bg-blue-600'
        }`;
        
        notification.innerHTML = `
            <div class="flex items-center">
                <i class="material-icons mr-2">${
                    type === 'success' ? 'check_circle' : 
                    type === 'error' ? 'error' : 
                    type === 'warning' ? 'warning' : 'info'
                }</i>
                <span>${message}</span>
                <button class="ml-4 text-white hover:text-gray-200" onclick="this.parentElement.parentElement.remove()">
                    <i class="material-icons text-sm">close</i>
                </button>
            </div>
        `;
        
        document.body.appendChild(notification);
        
        // Show notification
        setTimeout(() => {
            notification.classList.remove('translate-x-full');
        }, 100);
        
        // Auto remove
        setTimeout(() => {
            notification.classList.add('translate-x-full');
            setTimeout(() => {
                if (notification.parentElement) {
                    notification.remove();
                }
            }, 300);
        }, duration);
    },

    // Format price
    formatPrice(price, currency = '$') {
        return `${currency}${parseFloat(price).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,')}`;
    },

    // Animate counter
    animateCounter(element, target, duration = 2000) {
        let start = 0;
        const increment = target / (duration / 16);
        
        const timer = setInterval(() => {
            start += increment;
            element.textContent = Math.floor(start);
            
            if (start >= target) {
                element.textContent = target;
                clearInterval(timer);
            }
        }, 16);
    }
};

// Initialize theme when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    const theme = new MundoLimpioTheme();
    
    // Make theme globally available
    window.MundoLimpioTheme = theme;
    window.MundoLimpioUtils = MundoLimpioUtils;
    
    // Newsletter form handling
    const newsletterForm = document.querySelector('.newsletter-form');
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const email = e.target.querySelector('input[type="email"]').value;
            
            if (MundoLimpioUtils.validateEmail(email)) {
                // Here you would typically send the email to your backend
                MundoLimpioUtils.showNotification('¡Gracias por suscribirte a nuestro newsletter!', 'success');
                e.target.reset();
            } else {
                MundoLimpioUtils.showNotification('Por favor, ingresa un email válido.', 'error');
            }
        });
    }
    
    // Search form enhancements
    const searchInputs = document.querySelectorAll('.search-input');
    searchInputs.forEach(input => {
        input.addEventListener('focus', () => {
            input.parentElement.classList.add('ring-2', 'ring-green-500');
        });
        
        input.addEventListener('blur', () => {
            input.parentElement.classList.remove('ring-2', 'ring-green-500');
        });
    });
});

// Handle page visibility changes
document.addEventListener('visibilitychange', () => {
    if (document.hidden) {
        // Page is hidden
        document.title = '¡Vuelve pronto! - Mundo Limpio';
    } else {
        // Page is visible
        document.title = 'Mundo Limpio - Soluciones Sustentables para Limpieza';
    }
});