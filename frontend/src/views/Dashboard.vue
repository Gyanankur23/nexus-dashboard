<template>
  <Layout>
    <div class="animate-fade-in">
      <div class="flex items-center justify-between mb-8">
        <div>
          <h1 class="text-3xl font-bold mb-2">Dashboard Overview</h1>
          <p class="text-secondary-text">Welcome back, {{ authStore.user?.name }}!</p>
        </div>
        <div class="flex gap-4">
          <button class="btn-secondary flex items-center gap-2">
            <RefreshCw :size="18" />
            Refresh
          </button>
          <button class="btn-primary flex items-center gap-2">
            <Plus :size="18" />
            New Project
          </button>
        </div>
      </div>

      <!-- Stats Cards -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <div v-for="stat in stats" :key="stat.label" class="card">
          <div class="flex items-center justify-between mb-4">
            <div class="p-3 rounded-lg" :style="{ background: stat.color + '20', color: stat.color }">
              <component :is="stat.icon" :size="24" />
            </div>
            <span class="text-xs text-secondary-text">{{ stat.change }}</span>
          </div>
          <h3 class="text-3xl font-bold mb-1">{{ stat.value }}</h3>
          <p class="text-secondary-text text-sm">{{ stat.label }}</p>
        </div>
      </div>

      <!-- Charts Row -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
        <div class="card">
          <h3 class="text-lg font-semibold mb-4">Project Progress</h3>
          <div class="space-y-4">
            <div v-for="project in dataStore.projects" :key="project.id">
              <div class="flex items-center justify-between mb-2">
                <span class="text-sm font-medium">{{ project.name }}</span>
                <span class="text-sm text-secondary-text">{{ project.progress }}%</span>
              </div>
              <div class="h-2 bg-tertiary rounded-full overflow-hidden">
                <div 
                  class="h-full rounded-full transition-all duration-500"
                  :style="{ width: project.progress + '%', background: getProgressColor(project.progress) }"
                />
              </div>
            </div>
          </div>
        </div>

        <div class="card">
          <h3 class="text-lg font-semibold mb-4">Task Distribution</h3>
          <div class="grid grid-cols-2 gap-4">
            <div class="bg-tertiary rounded-lg p-4 text-center">
              <p class="text-2xl font-bold text-accent-success">{{ taskStats.completed }}</p>
              <p class="text-xs text-secondary-text">Completed</p>
            </div>
            <div class="bg-tertiary rounded-lg p-4 text-center">
              <p class="text-2xl font-bold text-accent-primary">{{ taskStats.inProgress }}</p>
              <p class="text-xs text-secondary-text">In Progress</p>
            </div>
            <div class="bg-tertiary rounded-lg p-4 text-center">
              <p class="text-2xl font-bold text-accent-warning">{{ taskStats.todo }}</p>
              <p class="text-xs text-secondary-text">To Do</p>
            </div>
            <div class="bg-tertiary rounded-lg p-4 text-center">
              <p class="text-2xl font-bold text-accent-danger">{{ taskStats.overdue }}</p>
              <p class="text-xs text-secondary-text">Overdue</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Recent Activity -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div class="card">
          <h3 class="text-lg font-semibold mb-4">Recent Projects</h3>
          <div class="space-y-3">
            <div v-for="project in dataStore.projects" :key="project.id" class="flex items-center gap-4 p-3 bg-tertiary rounded-lg hover:bg-border transition-colors cursor-pointer">
              <div class="p-2 rounded-lg bg-accent-primary/20 text-accent-primary">
                <Folder :size="20" />
              </div>
              <div class="flex-1">
                <p class="font-medium">{{ project.name }}</p>
                <p class="text-xs text-secondary-text">Due: {{ project.deadline }}</p>
              </div>
              <span class="badge" :class="getStatusBadgeClass(project.status)">
                {{ project.status }}
              </span>
            </div>
          </div>
        </div>

        <div class="card">
          <h3 class="text-lg font-semibold mb-4">Recent Tasks</h3>
          <div class="space-y-3">
            <div v-for="task in dataStore.tasks" :key="task.id" class="flex items-center gap-4 p-3 bg-tertiary rounded-lg hover:bg-border transition-colors cursor-pointer">
              <div class="p-2 rounded-lg" :class="getTaskIconClass(task.status)">
                <CheckSquare :size="20" />
              </div>
              <div class="flex-1">
                <p class="font-medium">{{ task.title }}</p>
                <p class="text-xs text-secondary-text">Assigned to: {{ getUserName(task.assignee) }}</p>
              </div>
              <span class="badge" :class="getPriorityBadgeClass(task.priority)">
                {{ task.priority }}
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </Layout>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import Layout from '../components/Layout.vue'
import { useAuthStore } from '../stores/auth'
import { useDataStore } from '../stores/data'
import { Users, FolderKanban, CheckSquare, TrendingUp, RefreshCw, Plus, Folder } from 'lucide-vue-next'

const authStore = useAuthStore()
const dataStore = useDataStore()

const stats = ref([
  { label: 'Total Users', value: '4', icon: Users, color: '#6366f1', change: '+12%' },
  { label: 'Active Projects', value: '4', icon: FolderKanban, color: '#8b5cf6', change: '+8%' },
  { label: 'Total Tasks', value: '6', icon: CheckSquare, color: '#10b981', change: '+25%' },
  { label: 'Productivity', value: '78%', icon: TrendingUp, color: '#f59e0b', change: '+5%' },
])

const taskStats = computed(() => ({
  completed: dataStore.tasks.filter(t => t.status === 'done').length,
  inProgress: dataStore.tasks.filter(t => t.status === 'in-progress').length,
  todo: dataStore.tasks.filter(t => t.status === 'todo').length,
  overdue: 0,
}))

const getProgressColor = (progress) => {
  if (progress >= 80) return '#10b981'
  if (progress >= 50) return '#6366f1'
  if (progress >= 25) return '#f59e0b'
  return '#ef4444'
}

const getStatusBadgeClass = (status) => {
  const classes = {
    'completed': 'badge-success',
    'in-progress': 'badge-info',
    'pending': 'badge-warning',
  }
  return classes[status] || 'badge-info'
}

const getPriorityBadgeClass = (priority) => {
  const classes = {
    'high': 'badge-danger',
    'medium': 'badge-warning',
    'low': 'badge-success',
  }
  return classes[priority] || 'badge-info'
}

const getTaskIconClass = (status) => {
  const classes = {
    'done': 'bg-accent-success/20 text-accent-success',
    'in-progress': 'bg-accent-primary/20 text-accent-primary',
    'todo': 'bg-accent-warning/20 text-accent-warning',
  }
  return classes[status] || 'bg-tertiary text-secondary-text'
}

const getUserName = (id) => {
  const user = dataStore.users.find(u => u.id === id)
  return user ? user.name : 'Unknown'
}

onMounted(() => {
  authStore.initialize()
  dataStore.fetchDashboard()
})
</script>

<style scoped>
.text-secondary-text {
  color: var(--text-secondary);
}
</style>
