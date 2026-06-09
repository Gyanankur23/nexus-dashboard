<template>
  <div class="min-h-screen bg-primary">
    <!-- Sidebar -->
    <aside class="fixed left-0 top-0 h-full w-64 bg-secondary border-r border-border flex flex-col">
      <div class="p-6 border-b border-border">
        <h1 class="text-2xl font-bold gradient-text">Nexus</h1>
        <p class="text-sm text-secondary-text mt-1">Dashboard</p>
      </div>
      
      <nav class="flex-1 p-4">
        <ul class="space-y-2">
          <li v-for="item in navItems" :key="item.path">
            <router-link
              :to="item.path"
              class="flex items-center gap-3 px-4 py-3 rounded-lg transition-all duration-300"
              :class="$route.path === item.path ? 'bg-accent-primary text-white' : 'text-secondary-text hover:bg-tertiary'"
            >
              <component :is="item.icon" :size="20" />
              <span>{{ item.name }}</span>
            </router-link>
          </li>
        </ul>
      </nav>
      
      <div class="p-4 border-t border-border">
        <div class="flex items-center gap-3 px-4 py-3">
          <div class="text-2xl">{{ authStore.user?.avatar || '👤' }}</div>
          <div class="flex-1">
            <p class="font-medium text-sm">{{ authStore.user?.name || 'User' }}</p>
            <p class="text-xs text-secondary-text">{{ authStore.user?.role || 'Member' }}</p>
          </div>
          <button @click="authStore.logout" class="text-secondary-text hover:text-accent-danger transition-colors">
            <LogOut :size="20" />
          </button>
        </div>
      </div>
    </aside>
    
    <!-- Main Content -->
    <main class="ml-64 p-8">
      <slot />
    </main>
  </div>
</template>

<script setup>
import { useAuthStore } from '../stores/auth'
import { LayoutDashboard, FolderKanban, CheckSquare, Users, Settings, LogOut, Activity, BarChart } from 'lucide-vue-next'

const authStore = useAuthStore()

const navItems = [
  { path: '/', name: 'Dashboard', icon: LayoutDashboard },
  { path: '/projects', name: 'Projects', icon: FolderKanban },
  { path: '/tasks', name: 'Tasks', icon: CheckSquare },
  { path: '/users', name: 'Users', icon: Users },
  { path: '/settings', name: 'Settings', icon: Settings },
]
</script>

<style scoped>
.text-secondary-text {
  color: var(--text-secondary);
}
</style>
