/**
 * Mundo Limpio Theme - JavaScript Completo
 * Funcionalidad completa del tema con animaciones y interactividad
 */

class MundoLimpioTheme {
    constructor() {
        this.header = null;
        this.mobileMenuToggle = null;
        this.mobileMenu = null;
        this.backToTopButton = null;
        
        this.lastScrollY = 0;
        this.isScrollingUp = false;
        this.scrollThreshold = 100;
        this.isMobileMenuOpen = false;
        
        this.init();
    }

    init() {
        console.log('🌿 Mundo Limpio Theme - Inicializado');
        this.bindElements();
        this.bindEvents();
        this.initStickyHeader();
        this.initMobileMenu();
        this.initBackToTop();
        this.initScrollAnimations();
        this.initSmoothScroll();
        this.initCounters();
        this.initNewsletterForm();
        
        // Throttled handlers para mejor performance
        this.throttledScrollHandler = this.throttle(this.handleScroll.bind(this), 16);
        this.throttledResizeHandler = this.throttle(this.handleResize.bind(this), 250);
    }

    bindElements() {
        // Obtener elementos del DOM
        this.header = document.getElementById('mundo-header');
        this.mobileMenuToggle = document.getElementById('mobile-menu-toggle');
        this.mobileMenu = document.getElementById('mobile-menu');
        this.backToTopButton = document.getElementById('back-to-top');
    }

    bindEvents() {
        // Eventos de scroll
        window.addEventListener('scroll', this.throttledScrollHandler, { passive: true });
        window.addEventListener('resize', this.throttledResizeHandler);
        
        // Eventos del menú móvil
        if (this.mobileMenuToggle) {
            this.mobileMenuToggle.addEventListener('click', this.toggleMobileMenu.bind(this));
        }

        // Eventos del botón back to top
        if (this.backToTopButton) {
            this.backToTopButton.addEventListener('click', this.scrollToTop.bind(this));
        }

        // Cerrar menú móvil al hacer clic fuera
        document.addEventListener('click', (e) => {
            if (this.isMobileMenuOpen && 
                this.mobileMenu && 
                !this.mobileMenu.contains(e.target) && 
                this.mobileMenuToggle &&
                !this.mobileMenuToggle.contains(e.target)) {
                this.closeMobileMenu();
            }
        });

        // ESC para cerrar menú móvil
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && this.isMobileMenuOpen) {
                this.closeMobileMenu();
            }
        });

        // Cerrar menú móvil en resize a desktop
        window.addEventListener('resize', () => {
            if (window.innerWidth >= 1024 && this.isMobileMenuOpen) {
                this.closeMobileMenu();
            }
        });
    }

    initStickyHeader() {
        if (!this.header) return;
        
        // Configurar transiciones del header
        this.header.style.transition = 'all 0.3s ease';
    }

    handleScroll() {
        const currentScrollY = window.scrollY;
        
        // Determinar dirección del scroll
        this.isScrollingUp = currentScrollY < this.lastScrollY;
        
        // Manejar header sticky
        this.handleStickyHeader(currentScrollY);
        
        // Manejar botón back to top
        this.handleBackToTopVisibility(currentScrollY);
        
        // Manejar animaciones basadas en scroll
        this.handleScrollAnimations();
        
        this.lastScrollY = currentScrollY;
    }

    handleStickyHeader(scrollY) {
        if (!this.header) return;

        if (scrollY > this.scrollThreshold) {
            // Agregar clase scrolled para efectos visuales
            this.header.classList.add('scrolled');
            
            if (this.isScrollingUp) {
                // Mostrar header al hacer scroll hacia arriba
                this.header.style.transform = 'translateY(0)';
                this.header.classList.remove('hidden-header');
            } else {
                // Ocultar header al hacer scroll hacia abajo
                this.header.style.transform = 'translateY(-100%)';
                this.header.classList.add('hidden-header');
            }
        } else {
            // Siempre mostrar header en la parte superior
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

    initMobileMenu() {
        if (!this.mobileMenu) return;
        
        // Estado inicial del menú móvil
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
        
        // Cambiar icono del botón
        const icon = this.mobileMenuToggle.querySelector('i');
        if (icon) {
            icon.textContent = 'close';
        }
        
        // Mostrar menú
        this.mobileMenu.classList.add('open');
        this.mobileMenu.style.visibility = 'visible';
        this.mobileMenu.style.transform = 'translateY(0)';
        this.mobileMenu.style.opacity = '1';
        
        // Prevenir scroll del body
        document.body.style.overflow = 'hidden';
        
        // Animar elementos del menú
        const menuItems = this.mobileMenu.querySelectorAll('.mobile-nav-link');
        menuItems.forEach((item, index) => {
            setTimeout(() => {
                item.classList.add('animate-fade-in-left');
            }, index * 100);
        });
        
        console.log('📱 Menú móvil abierto');
    }

    closeMobileMenu() {
        if (!this.mobileMenu || !this.mobileMenuToggle) return;

        this.isMobileMenuOpen = false;
        
        // Cambiar icono del botón
        const icon = this.mobileMenuToggle.querySelector('i');
        if (icon) {
            icon.textContent = 'menu';
        }
        
        // Ocultar menú
        this.mobileMenu.classList.remove('open');
        this.mobileMenu.style.transform = 'translateY(-100%)';
        this.mobileMenu.style.opacity = '0';
        
        setTimeout(() => {
            if (!this.isMobileMenuOpen) {
                this.mobileMenu.style.visibility = 'hidden';
            }
        }, 300);
        
        // Restaurar scroll del body
        document.body.style.overflow = '';
        
        // Reset animaciones del menú
        const menuItems = this.mobileMenu.querySelectorAll('.mobile-nav-link');
        menuItems.forEach(item => {
            item.classList.remove('animate-fade-in-left');
        });
        
        console.log('📱 Menú móvil cerrado');
    }

    initBackToTop() {
        if (!this.backToTopButton) return;

        // Estado inicial
        this.backToTopButton.classList.add('translate-y-16', 'opacity-0');
    }

    scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }

    initScrollAnimations() {
        // Intersection Observer para animaciones de scroll
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

        // Observar elementos con animación de scroll
        const animatedElements = document.querySelectorAll('[data-scroll-animation]');
        animatedElements.forEach(element => {
            element.classList.add('opacity-0', 'translate-y-8');
            observer.observe(element);
        });

        // Observar secciones para animaciones automáticas
        const sections = document.querySelectorAll('section');
        sections.forEach(section => {
            observer.observe(section);
        });
    }

    handleScrollAnimations() {
        // Animaciones adicionales basadas en scroll
        const scrolled = window.scrollY;
        const rate = scrolled * -0.5;
        
        // Parallax effect para elementos decorativos
        const decorations = document.querySelectorAll('.hero-decorations > div');
        decorations.forEach((decoration, index) => {
            const speed = (index + 1) * 0.3;
            decoration.style.transform = `translateY(${rate * speed}px)`;
        });
    }

    initSmoothScroll() {
        // Smooth scroll para enlaces ancla
        const anchorLinks = document.querySelectorAll('a[href^="#"]');
        
        anchorLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                const href = link.getAttribute('href');
                
                if (href === '#') return;
                
                const target = document.querySelector(href);
                
                if (target) {
                    e.preventDefault();
                    
                    const headerHeight = this.header ? this.header.offsetHeight : 80;
                    const targetPosition = target.offsetTop - headerHeight - 20;
                    
                    window.scrollTo({
                        top: targetPosition,
                        behavior: 'smooth'
                    });
                    
                    // Cerrar menú móvil si está abierto
                    if (this.isMobileMenuOpen) {
                        this.closeMobileMenu();
                    }
                }
            });
        });
    }

    initCounters() {
        // Animación de contadores numéricos
        const counters = document.querySelectorAll('[data-counter]');
        
        const counterObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const counter = entry.target;
                    const target = parseInt(counter.getAttribute('data-counter'));
                    this.animateCounter(counter, target, 2000);
                    counterObserver.unobserve(counter);
                }
            });
        });
        
        counters.forEach(counter => {
            counterObserver.observe(counter);
        });
    }

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

    initNewsletterForm() {
        // Manejar formulario de newsletter
        const newsletterForm = document.getElementById('newsletter-form');
        if (newsletterForm) {
            newsletterForm.addEventListener('submit', (e) => {
                e.preventDefault();
                const email = e.target.querySelector('input[type="email"]').value;
                
                if (this.validateEmail(email)) {
                    this.showNotification('¡Gracias por suscribirte a nuestro newsletter!', 'success');
                    e.target.reset();
                } else {
                    this.showNotification('Por favor, ingresa un email válido.', 'error');
                }
            });
        }
    }

    handleResize() {
        // Manejar cambios de tamaño de ventana
        if (window.innerWidth >= 1024 && this.isMobileMenuOpen) {
            this.closeMobileMenu();
        }
        
        // Recalcular posiciones
        this.handleScroll();
    }

    // Utilidades
    validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

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
                <button class="ml-4 text-white hover:text-gray-200 transition-colors" onclick="this.parentElement.parentElement.remove()">
                    <i class="material-icons text-sm">close</i>
                </button>
            </div>
        `;
        
        document.body.appendChild(notification);
        
        // Mostrar notificación
        setTimeout(() => {
            notification.classList.remove('translate-x-full');
        }, 100);
        
        // Auto remover
        setTimeout(() => {
            notification.classList.add('translate-x-full');
            setTimeout(() => {
                if (notification.parentElement) {
                    notification.remove();
                }
            }, 300);
        }, duration);
    }

    // Función throttle para optimización de performance
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

    // Función debounce
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

// Utilidades adicionales
const MundoLimpioUtils = {
    // Validar email
    validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    },

    // Formatear precio
    formatPrice(price, currency = '$') {
        return `${currency}${parseFloat(price).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,')}`;
    },

    // Animar contador
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
    },

    // Obtener posición de elemento
    getElementPosition(element) {
        const rect = element.getBoundingClientRect();
        return {
            top: rect.top + window.scrollY,
            left: rect.left + window.scrollX
        };
    },

    // Verificar si elemento está en viewport
    isInViewport(element) {
        const rect = element.getBoundingClientRect();
        return (
            rect.top >= 0 &&
            rect.left >= 0 &&
            rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
            rect.right <= (window.innerWidth || document.documentElement.clientWidth)
        );
    }
};

// Inicializar tema cuando DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
    const theme = new MundoLimpioTheme();
    
    // Hacer disponible globalmente
    window.MundoLimpioTheme = theme;
    window.MundoLimpioUtils = MundoLimpioUtils;
    
    // Mostrar mensaje de éxito
    setTimeout(() => {
        theme.showNotification('🌿 Mundo Limpio Theme cargado exitosamente', 'success');
    }, 1000);
});

// Manejar cambios de visibilidad de página
document.addEventListener('visibilitychange', () => {
    const originalTitle = document.title;
    if (document.hidden) {
        document.title = '¡Vuelve pronto! 🌿 - Mundo Limpio';
    } else {
        document.title = originalTitle;
    }
});

// Log de performance (solo en development)
if (window.location.hostname === 'localhost' || window.location.hostname.includes('dev')) {
    window.addEventListener('load', () => {
        console.log('🚀 Mundo Limpio Theme - Performance:', {
            'DOM Content Loaded': performance.getEntriesByType('navigation')[0].domContentLoadedEventEnd,
            'Load Complete': performance.getEntriesByType('navigation')[0].loadEventEnd,
            'First Paint': performance.getEntriesByName('first-paint')[0]?.startTime || 'N/A',
            'First Contentful Paint': performance.getEntriesByName('first-contentful-paint')[0]?.startTime || 'N/A'
        });
    });
}