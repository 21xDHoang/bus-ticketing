import react from '@vitejs/plugin-react'
import { defineConfig } from 'vite'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],

  server: {
    port: 5173,

    // ============================================================
    //  PROXY - Chuyen tiep moi request /api sang backend
    //
    //  Nho proxy nay, luc dev frontend goi '/api/trips'
    //  thay vi 'https://localhost:7000/api/trips'
    //  => KHONG BAO GIO gap loi CORS
    // ============================================================
    proxy: {
      '/api': {
        target: 'https://localhost:7000',
        changeOrigin: true,
        secure: false, // backend dung chung chi tu ky (self-signed) luc dev
      },
    },
  },
})
