module.exports = {
  mode: "jit",
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: ["style-loader", "css-loader", "sass-loader"],
      },
    ],
  },
  content: [
    "./app/views/**/*.{slim,erb,jbuilder,turbo_stream,js}",
    "./app/decorators/**/*.rb",
    "./app/helpers/**/*.rb",
    "./app/inputs/**/*.rb",
    "./app/assets/javascripts/**/*.js",
    "./config/initializers/**/*.rb",
    "./lib/components/**/*.rb",
    "./node_modules/flowbite/**/*.js",
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
    extend: {
      fontFamily: {
        sans: ['"Proxima Nova"', "sans-serif"],
      },
    },
  },
  // eslint-disable-next-line global-require
  plugins: [require("@tailwindcss/typography"), require("daisyui")],
  daisyui: {
    themes: ["light", "dark"],
  },
};
