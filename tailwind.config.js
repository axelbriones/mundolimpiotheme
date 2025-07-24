/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./templates/**/*.tpl",
    "./assets/js/**/*.js",
    "./config/**/*.yml",
    "./assets/css/src/**/*.css"
  ],
  
  theme: {
    extend: {
      // Custom colors for Mundo Limpio theme
      colors: {
        primary: {
          50: '#f0fdf4',
          100: '#dcfce7',
          200: '#bbf7d0',
          300: '#86efac',
          400: '#4ade80',
          500: '#22c55e',
          600: '#16a34a', // Main primary color
          700: '#15803d',
          800: '#166534',
          900: '#14532d',
          950: '#052e16',
        },
        secondary: {
          50: '#f9fafb',
          100: '#f3f4f6',
          200: '#e5e7eb',
          300: '#d1d5db',
          400: '#9ca3af',
          500: '#6b7280',
          600: '#4b5563',
          700: '#374151',
          800: '#1f2937',
          900: '#111827',
          950: '#030712',
        },
        accent: {
          50: '#fffbeb',
          100: '#fef3c7',
          200: '#fde68a',
          300: '#fcd34d',
          400: '#fbbf24',
          500: '#f59e0b', // Main accent color
          600: '#d97706',
          700: '#b45309',
          800: '#92400e',
          900: '#78350f',
          950: '#451a03',
        },
        eco: {
          50: '#f0fdf4',
          100: '#dcfce7',
          200: '#bbf7d0',
          300: '#86efac',
          400: '#4ade80',
          500: '#22c55e',
          600: '#16a34a',
          700: '#15803d',
          800: '#166534',
          900: '#14532d',
        }
      },

      // Typography
      fontFamily: {
        'sans': ['Inter', '-apple-system', 'BlinkMacSystemFont', '"Segoe UI"', 'Roboto', '"Helvetica Neue"', 'Arial', 'sans-serif'],
        'display': ['Inter', '-apple-system', 'BlinkMacSystemFont', '"Segoe UI"', 'Roboto', '"Helvetica Neue"', 'Arial', 'sans-serif'],
        'body': ['Inter', '-apple-system', 'BlinkMacSystemFont', '"Segoe UI"', 'Roboto', '"Helvetica Neue"', 'Arial', 'sans-serif'],
        'mono': ['"SF Mono"', 'Monaco', '"Cascadia Code"', '"Roboto Mono"', 'Consolas', '"Courier New"', 'monospace'],
      },

      fontSize: {
        'xs': ['0.75rem', { lineHeight: '1rem' }],
        'sm': ['0.875rem', { lineHeight: '1.25rem' }],
        'base': ['1rem', { lineHeight: '1.5rem' }],
        'lg': ['1.125rem', { lineHeight: '1.75rem' }],
        'xl': ['1.25rem', { lineHeight: '1.75rem' }],
        '2xl': ['1.5rem', { lineHeight: '2rem' }],
        '3xl': ['1.875rem', { lineHeight: '2.25rem' }],
        '4xl': ['2.25rem', { lineHeight: '2.5rem' }],
        '5xl': ['3rem', { lineHeight: '1' }],
        '6xl': ['3.75rem', { lineHeight: '1' }],
        '7xl': ['4.5rem', { lineHeight: '1' }],
        '8xl': ['6rem', { lineHeight: '1' }],
        '9xl': ['8rem', { lineHeight: '1' }],
      },

      // Spacing
      spacing: {
        '18': '4.5rem',
        '88': '22rem',
        '128': '32rem',
        '144': '36rem',
      },

      // Container
      container: {
        center: true,
        padding: {
          DEFAULT: '1rem',
          sm: '1rem',
          lg: '1.5rem',
          xl: '2rem',
          '2xl': '2rem',
        },
        screens: {
          sm: '640px',
          md: '768px',
          lg: '1024px',
          xl: '1280px',
          '2xl': '1320px',
        },
      },

      // Breakpoints
      screens: {
        'xs': '475px',
        'sm': '640px',
        'md': '768px',
        'lg': '1024px',
        'xl': '1280px',
        '2xl': '1536px',
        '3xl': '1920px',
      },

      // Animations
      animation: {
        'fade-in': 'fadeIn 0.5s ease-in-out',
        'fade-in-up': 'fadeInUp 0.6s ease-out',
        'fade-in-down': 'fadeInDown 0.6s ease-out',
        'fade-in-left': 'fadeInLeft 0.6s ease-out',
        'fade-in-right': 'fadeInRight 0.6s ease-out',
        'slide-up': 'slideUp 0.4s ease-out',
        'slide-down': 'slideDown 0.4s ease-out',
        'scale-in': 'scaleIn 0.3s ease-out',
        'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'bounce-slow': 'bounce 3s infinite',
        'spin-slow': 'spin 3s linear infinite',
        'float-1': 'float1 8s ease-in-out infinite',
        'float-2': 'float2 6s ease-in-out infinite',
        'float-3': 'float3 10s ease-in-out infinite',
        'float-4': 'float4 7s ease-in-out infinite',
        'float-5': 'float5 9s ease-in-out infinite',
      },

      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        fadeInUp: {
          '0%': { opacity: '0', transform: 'translateY(30px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
        fadeInDown: {
          '0%': { opacity: '0', transform: 'translateY(-30px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
        fadeInLeft: {
          '0%': { opacity: '0', transform: 'translateX(-30px)' },
          '100%': { opacity: '1', transform: 'translateX(0)' },
        },
        fadeInRight: {
          '0%': { opacity: '0', transform: 'translateX(30px)' },
          '100%': { opacity: '1', transform: 'translateX(0)' },
        },
        slideUp: {
          '0%': { transform: 'translateY(100%)' },
          '100%': { transform: 'translateY(0)' },
        },
        slideDown: {
          '0%': { transform: 'translateY(-100%)' },
          '100%': { transform: 'translateY(0)' },
        },
        scaleIn: {
          '0%': { transform: 'scale(0.9)', opacity: '0' },
          '100%': { transform: 'scale(1)', opacity: '1' },
        },
        float1: {
          '0%, 100%': { transform: 'translateY(0px) translateX(0px) rotate(0deg)' },
          '25%': { transform: 'translateY(-20px) translateX(10px) rotate(90deg)' },
          '50%': { transform: 'translateY(-10px) translateX(-10px) rotate(180deg)' },
          '75%': { transform: 'translateY(-30px) translateX(5px) rotate(270deg)' },
        },
        float2: {
          '0%, 100%': { transform: 'translateY(0px) translateX(0px)' },
          '33%': { transform: 'translateY(-15px) translateX(-15px)' },
          '66%': { transform: 'translateY(-25px) translateX(15px)' },
        },
        float3: {
          '0%, 100%': { transform: 'translateY(0px) translateX(0px) scale(1)' },
          '25%': { transform: 'translateY(-25px) translateX(20px) scale(1.1)' },
          '50%': { transform: 'translateY(-15px) translateX(-20px) scale(0.9)' },
          '75%': { transform: 'translateY(-35px) translateX(10px) scale(1.05)' },
        },
        float4: {
          '0%, 100%': { transform: 'translateY(0px) translateX(0px)' },
          '50%': { transform: 'translateY(-40px) translateX(-25px)' },
        },
        float5: {
          '0%, 100%': { transform: 'translateY(0px) translateX(0px)' },
          '20%': { transform: 'translateY(-30px) translateX(15px)' },
          '40%': { transform: 'translateY(-10px) translateX(-20px)' },
          '60%': { transform: 'translateY(-45px) translateX(25px)' },
          '80%': { transform: 'translateY(-20px) translateX(-10px)' },
        },
      },

      // Box Shadow
      boxShadow: {
        'soft': '0 2px 15px -3px rgba(0, 0, 0, 0.07), 0 10px 20px -2px rgba(0, 0, 0, 0.04)',
        'medium': '0 4px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
        'strong': '0 10px 40px -10px rgba(0, 0, 0, 0.15), 0 4px 6px -2px rgba(0, 0, 0, 0.05)',
        'green': '0 4px 14px 0 rgba(34, 197, 94, 0.25)',
        'green-lg': '0 10px 40px -10px rgba(34, 197, 94, 0.3)',
      },

      // Border radius
      borderRadius: {
        'none': '0',
        'sm': '0.125rem',
        DEFAULT: '0.25rem',
        'md': '0.375rem',
        'lg': '0.5rem',
        'xl': '0.75rem',
        '2xl': '1rem',
        '3xl': '1.5rem',
        '4xl': '2rem',
        'full': '9999px',
      },

      // Gradient stops
      gradientColorStops: {
        'primary-gradient': {
          '0%': '#16a34a',
          '100%': '#22c55e',
        },
        'eco-gradient': {
          '0%': '#14532d',
          '50%': '#16a34a',
          '100%': '#22c55e',
        },
      },

      // Z-index
      zIndex: {
        '0': '0',
        '10': '10',
        '20': '20',
        '30': '30',
        '40': '40',
        '50': '50',
        '60': '60',
        '70': '70',
        '80': '80',
        '90': '90',
        '100': '100',
        'auto': 'auto',
      },

      // Backdrop blur
      backdropBlur: {
        'xs': '2px',
        'sm': '4px',
        DEFAULT: '8px',
        'md': '12px',
        'lg': '16px',
        'xl': '24px',
        '2xl': '40px',
        '3xl': '64px',
      },

      // Aspect ratio
      aspectRatio: {
        '1/1': '1 / 1',
        '4/3': '4 / 3',
        '16/9': '16 / 9',
        '21/9': '21 / 9',
        '3/2': '3 / 2',
        '2/3': '2 / 3',
        '9/16': '9 / 16',
      },

      // Line height
      lineHeight: {
        '3': '.75rem',
        '4': '1rem',
        '5': '1.25rem',
        '6': '1.5rem',
        '7': '1.75rem',
        '8': '2rem',
        '9': '2.25rem',
        '10': '2.5rem',
      },

      // Letter spacing
      letterSpacing: {
        'tighter': '-0.05em',
        'tight': '-0.025em',
        'normal': '0em',
        'wide': '0.025em',
        'wider': '0.05em',
        'widest': '0.1em',
      },

      // Max width
      maxWidth: {
        '0': '0rem',
        'xs': '20rem',
        'sm': '24rem',
        'md': '28rem',
        'lg': '32rem',
        'xl': '36rem',
        '2xl': '42rem',
        '3xl': '48rem',
        '4xl': '56rem',
        '5xl': '64rem',
        '6xl': '72rem',
        '7xl': '80rem',
        '8xl': '88rem',
        'full': '100%',
        'min': 'min-content',
        'max': 'max-content',
        'fit': 'fit-content',
        'prose': '65ch',
        'screen-sm': '640px',
        'screen-md': '768px',
        'screen-lg': '1024px',
        'screen-xl': '1280px',
        'screen-2xl': '1536px',
      },

      // Transition
      transitionDuration: {
        '0': '0ms',
        '75': '75ms',
        '100': '100ms',
        '150': '150ms',
        '200': '200ms',
        '300': '300ms',
        '500': '500ms',
        '700': '700ms',
        '1000': '1000ms',
      },

      transitionTimingFunction: {
        'bounce': 'cubic-bezier(0.68, -0.55, 0.265, 1.55)',
        'smooth': 'cubic-bezier(0.4, 0, 0.2, 1)',
      },
    },
  },

  plugins: [
    require('@tailwindcss/forms')({
      strategy: 'class', // only generate classes
    }),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    
    // Custom plugin for utility classes
    function({ addUtilities, addComponents, theme }) {
      // Custom utilities
      const newUtilities = {
        '.text-shadow': {
          textShadow: '2px 2px 4px rgba(0, 0, 0, 0.1)',
        },
        '.text-shadow-md': {
          textShadow: '4px 4px 8px rgba(0, 0, 0, 0.12)',
        },
        '.text-shadow-lg': {
          textShadow: '15px 15px 30px rgba(0, 0, 0, 0.11)',
        },
        '.text-shadow-none': {
          textShadow: 'none',
        },
        '.gradient-text': {
          background: 'linear-gradient(135deg, #16a34a, #22c55e)',
          '-webkit-background-clip': 'text',
          '-webkit-text-fill-color': 'transparent',
          'background-clip': 'text',
        },
        '.glass-effect': {
          background: 'rgba(255, 255, 255, 0.1)',
          'backdrop-filter': 'blur(10px)',
          '-webkit-backdrop-filter': 'blur(10px)',
          border: '1px solid rgba(255, 255, 255, 0.2)',
        },
        '.scrollbar-hide': {
          '-ms-overflow-style': 'none',
          'scrollbar-width': 'none',
          '&::-webkit-scrollbar': {
            display: 'none',
          },
        },
      }

      // Custom components
      const newComponents = {
        '.btn': {
          '@apply inline-flex items-center justify-center px-4 py-2 text-sm font-medium rounded-lg transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2': {},
        },
        '.btn-primary': {
          '@apply bg-primary-600 text-white hover:bg-primary-700 focus:ring-primary-500 shadow-md hover:shadow-lg': {},
        },
        '.btn-secondary': {
          '@apply bg-secondary-200 text-secondary-900 hover:bg-secondary-300 focus:ring-secondary-500': {},
        },
        '.btn-outline': {
          '@apply border-2 border-primary-600 text-primary-600 hover:bg-primary-600 hover:text-white focus:ring-primary-500': {},
        },
        '.btn-lg': {
          '@apply px-6 py-3 text-base': {},
        },
        '.btn-sm': {
          '@apply px-3 py-1.5 text-xs': {},
        },
        '.card': {
          '@apply bg-white rounded-lg shadow-md overflow-hidden transition-all duration-300 hover:shadow-lg': {},
        },
        '.badge': {
          '@apply inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium': {},
        },
        '.badge-primary': {
          '@apply bg-primary-100 text-primary-800': {},
        },
      }

      addUtilities(newUtilities)
      addComponents(newComponents)
    },
  ],

  // Safelist classes that might be generated dynamically
  safelist: [
    'animate-fade-in-up',
    'animate-fade-in-down',
    'animate-fade-in-left',
    'animate-fade-in-right',
    'animate-float-1',
    'animate-float-2',
    'animate-float-3',
    'animate-float-4',
    'animate-float-5',
    // Animation delays
    'animation-delay-200',
    'animation-delay-400',
    'animation-delay-600',
    'animation-delay-800',
    'animation-delay-1000',
    'animation-delay-1200',
    // Color variations
    'text-primary-400',
    'text-primary-500',
    'text-primary-600',
    'text-primary-700',
    'bg-primary-50',
    'bg-primary-100',
    'bg-primary-500',
    'bg-primary-600',
    'bg-primary-700',
    // Responsive classes
    'sm:text-2xl',
    'md:text-3xl',
    'lg:text-4xl',
    'xl:text-5xl',
    // Grid columns
    'lg:col-span-3',
    'lg:col-span-6',
    'lg:col-span-9',
    'lg:col-span-12',
  ],
}