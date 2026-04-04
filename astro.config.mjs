import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import sitemap from '@astrojs/sitemap';
import mkcert from 'vite-plugin-mkcert';

export default defineConfig({
  site: 'https://gabrewer.com',
  output: 'static',
  integrations: [sitemap()],
  vite: {
    plugins: [tailwindcss(), mkcert()],
  },
});
