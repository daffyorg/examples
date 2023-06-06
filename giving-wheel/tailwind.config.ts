import type { Config } from 'tailwindcss'

export default {
  content: ['./app/**/*.{js,jsx,ts,tsx}'],
  theme: {
    extend: {
      colors: {
        green: {
          darker: "#175945",
          dark: "#418B74",
          light: "#DBEA82"
        },
        neutral: {
          dark: "#1D2538",
          regular: "#6D6D6D",
          light: "#969696"
        }
      },
      animation: {
        "dot-flashing": "dot-flashing 1s infinite alternate",
      },
      keyframes: ({ theme }) => {
        return {
          "dot-flashing": {
            "0%": { backgroundColor: theme("colors.neutral.200") },
            "50%, 100%": { backgroundColor: theme("colors.neutral.500") },
          },
        };
      },
    },
  },
  plugins: [
    require("tailwindcss-animation-delay"),
  ],
} satisfies Config

