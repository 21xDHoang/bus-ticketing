import axios from 'axios'

/**
 * Axios instance dung chung cho ca du an.
 *
 * - Luc dev : baseURL de trong '' => di qua proxy cua Vite => khong bi CORS
 * - Luc prod: baseURL lay tu bien moi truong VITE_API_URL
 */
export const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || '',
  headers: {
    'Content-Type': 'application/json',
  },
})

// ============================================================
//  Tu dong gan token JWT vao MOI request
// ============================================================
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token')
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})

// ============================================================
//  Token het han (401) => xoa token va day ve trang dang nhap
// ============================================================
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('token')
      window.location.href = '/login'
    }
    return Promise.reject(error)
  },
)

export default api
