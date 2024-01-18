import { defineConfig } from 'vite';
import ViteRails from 'vite-plugin-rails';

export default defineConfig({
  plugins: [
    ViteRails({
      envVars: { RAILS_ENV: 'development' },
      envOptions: { defineOn: 'import.meta.env' },
      fullReload: {
        additionalPaths: [],
      },
    }),
  ],
  root: './app/frontend',
  build: {
    manifest: true,
    rollupOptions: {
      input: '/app/frontend/entrypoints/application.js',
    },
  },
});
