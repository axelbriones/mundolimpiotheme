/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './**/*.tpl',
    './templates/**/*.tpl',
    './modules/**/*.tpl',
  ],
  theme: {
    extend: {
      colors: {
        'corporate-blue': '#0064b6',
        'corporate-green': '#4caf50',
      },
      fontFamily: {
        'sans': ['Open Sans', 'sans-serif'],
        'montserrat': ['Montserrat', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
