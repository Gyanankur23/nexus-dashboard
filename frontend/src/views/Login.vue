<template>
  <div style="min-height: 100vh; background: #0a0a0a; display: flex; align-items: center; justify-content: center; padding: 1rem;">
    <div style="width: 100%; max-width: 28rem;">
      <div style="background: #111111; border: 1px solid #2a2a2a; border-radius: 1rem; padding: 1.5rem;">
        <div style="text-align: center; margin-bottom: 2rem;">
          <h1 style="font-size: 2.25rem; font-weight: bold; margin-bottom: 0.5rem; background: linear-gradient(135deg, #6366f1, #8b5cf6); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Nexus</h1>
          <p style="color: #a0a0a0;">Admin & Project Management Dashboard</p>
        </div>
        
        <form @submit.prevent="handleLogin" style="display: flex; flex-direction: column; gap: 1.5rem;">
          <div>
            <label style="display: block; font-size: 0.875rem; font-weight: 500; margin-bottom: 0.5rem;">Email</label>
            <input
              v-model="email"
              type="email"
              style="width: 100%; background: #1a1a1a; border: 1px solid #2a2a2a; color: white; padding: 0.75rem 1rem; border-radius: 0.5rem;"
              placeholder="admin@nexus.com"
              required
            />
          </div>
          
          <div>
            <label style="display: block; font-size: 0.875rem; font-weight: 500; margin-bottom: 0.5rem;">Password</label>
            <input
              v-model="password"
              type="password"
              style="width: 100%; background: #1a1a1a; border: 1px solid #2a2a2a; color: white; padding: 0.75rem 1rem; border-radius: 0.5rem;"
              placeholder="••••••••"
              required
            />
          </div>
          
          <div v-if="authStore.error" style="color: #ef4444; font-size: 0.875rem; text-align: center;">
            {{ authStore.error }}
          </div>
          
          <button
            type="submit"
            style="width: 100%; background: linear-gradient(135deg, #6366f1, #8b5cf6); color: white; padding: 0.75rem 1.5rem; border-radius: 0.5rem; font-weight: 600; border: none; cursor: pointer;"
            :disabled="authStore.loading"
          >
            {{ authStore.loading ? 'Signing in...' : 'Sign In' }}
          </button>
        </form>
        
        <div style="margin-top: 1.5rem; padding: 1rem; background: #1a1a1a; border-radius: 0.5rem; border: 1px solid #2a2a2a;">
          <p style="font-size: 0.75rem; color: #a0a0a0; margin-bottom: 0.5rem;">Demo Credentials:</p>
          <p style="font-size: 0.875rem;">Email: <span style="color: #6366f1;">admin@nexus.com</span></p>
          <p style="font-size: 0.875rem;">Password: <span style="color: #6366f1;">admin123</span></p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const email = ref('admin@nexus.com')
const password = ref('admin123')

const handleLogin = async () => {
  const success = await authStore.login(email.value, password.value)
  if (success) {
    router.push('/')
  }
}
</script>
