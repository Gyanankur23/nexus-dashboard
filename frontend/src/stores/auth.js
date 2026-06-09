import { defineStore } from 'pinia'

// Mock data for demo purposes
const MOCK_USERS = [
  { id: 1, email: 'admin@nexus.com', password: 'admin123', name: 'Admin User', role: 'admin', avatar: '👨‍💼' },
  { id: 2, email: 'john@nexus.com', password: 'password', name: 'John Developer', role: 'developer', avatar: '👨‍💻' },
  { id: 3, email: 'sarah@nexus.com', password: 'password', name: 'Sarah Designer', role: 'designer', avatar: '👩‍🎨' },
]

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: null,
    token: localStorage.getItem('token') || null,
    loading: false,
    error: null
  }),
  
  actions: {
    async login(email, password) {
      this.loading = true
      this.error = null
      
      // Simulate API delay
      await new Promise(resolve => setTimeout(resolve, 500))
      
      try {
        // Mock authentication - case insensitive email check
        const user = MOCK_USERS.find(u => u.email.toLowerCase() === email.toLowerCase() && u.password === password)
        
        if (user) {
          const token = 'mock-jwt-token-' + Date.now()
          this.token = token
          this.user = { id: user.id, name: user.name, email: user.email, role: user.role, avatar: user.avatar }
          localStorage.setItem('token', token)
          localStorage.setItem('user', JSON.stringify(this.user))
          return true
        } else {
          this.error = 'Invalid credentials'
          return false
        }
      } catch (error) {
        this.error = 'Login failed'
        return false
      } finally {
        this.loading = false
      }
    },
    
    logout() {
      this.user = null
      this.token = null
      localStorage.removeItem('token')
      localStorage.removeItem('user')
    },
    
    initialize() {
      const user = localStorage.getItem('user')
      if (user) {
        this.user = JSON.parse(user)
      }
    }
  }
})
