module.exports = {
  content: [
    "./app/views/**/*.{slim,erb,jbuilder,turbo_stream,js}",
    "./app/decorators/**/*.rb",
    "./app/helpers/**/*.rb",
    "./app/inputs/**/*.rb",
    "./app/assets/javascripts/**/*.js",
    "./config/initializers/**/*.rb",
    "./lib/components/**/*.rb",
  ],
  variants: {
    extend: {
      overflow: ["hover"],
    },
  },
  theme: {
    listStyleType: {
      none: "none",
      disc: "disc",
      decimal: "decimal",
      square: "square",
    },
  },
  // eslint-disable-next-line global-require
  plugins: [require("@tailwindcss/typography"), require("daisyui")],
  daisyui: {
    themes: ["light", "dark"],
  },
};
