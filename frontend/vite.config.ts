import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vuetify from 'vite-plugin-vuetify'

// https://vite.dev/config/
export default defineConfig({
  // 使用したVuetifyコンポーネントだけを自動でimportする（ビルドサイズ削減）
  plugins: [vue(), vuetify({ autoImport: true })],
})
