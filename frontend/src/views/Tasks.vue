<template>
  <Layout>
    <div class="animate-fade-in">
      <div class="flex items-center justify-between mb-8">
        <div>
          <h1 class="text-3xl font-bold mb-2">Tasks</h1>
          <p class="text-secondary-text">Track and manage your tasks</p>
        </div>
        <button class="btn-primary flex items-center gap-2">
          <Plus :size="18" />
          New Task
        </button>
      </div>

      <!-- Kanban Board -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <!-- To Do Column -->
        <div class="space-y-4">
          <div class="flex items-center gap-2 mb-4">
            <div class="w-3 h-3 rounded-full bg-accent-warning" />
            <h3 class="font-semibold">To Do ({{ todoTasks.length }})</h3>
          </div>
          <div v-for="task in todoTasks" :key="task.id" class="card p-4 cursor-pointer hover:border-accent-primary transition-all">
            <div class="flex items-center justify-between mb-3">
              <span class="badge" :class="getPriorityBadgeClass(task.priority)">
                {{ task.priority }}
              </span>
              <span class="text-xs text-secondary-text">#{{ task.id }}</span>
            </div>
            <h4 class="font-medium mb-2">{{ task.title }}</h4>
            <div class="flex items-center justify-between">
              <div class="flex items-center gap-2">
                <div class="w-6 h-6 rounded-full bg-tertiary flex items-center justify-center text-xs">
                  {{ getUserName(task.assignee) }}
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- In Progress Column -->
        <div class="space-y-4">
          <div class="flex items-center gap-2 mb-4">
            <div class="w-3 h-3 rounded-full bg-accent-primary" />
            <h3 class="font-semibold">In Progress ({{ inProgressTasks.length }})</h3>
          </div>
          <div v-for="task in inProgressTasks" :key="task.id" class="card p-4 cursor-pointer hover:border-accent-primary transition-all">
            <div class="flex items-center justify-between mb-3">
              <span class="badge" :class="getPriorityBadgeClass(task.priority)">
                {{ task.priority }}
              </span>
              <span class="text-xs text-secondary-text">#{{ task.id }}</span>
            </div>
            <h4 class="font-medium mb-2">{{ task.title }}</h4>
            <div class="flex items-center justify-between">
              <div class="flex items-center gap-2">
                <div class="w-6 h-6 rounded-full bg-tertiary flex items-center justify-center text-xs">
                  {{ getUserName(task.assignee) }}
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Done Column -->
        <div class="space-y-4">
          <div class="flex items-center gap-2 mb-4">
            <div class="w-3 h-3 rounded-full bg-accent-success" />
            <h3 class="font-semibold">Done ({{ doneTasks.length }})</h3>
          </div>
          <div v-for="task in doneTasks" :key="task.id" class="card p-4 cursor-pointer hover:border-accent-primary transition-all opacity-75">
            <div class="flex items-center justify-between mb-3">
              <span class="badge" :class="getPriorityBadgeClass(task.priority)">
                {{ task.priority }}
              </span>
              <span class="text-xs text-secondary-text">#{{ task.id }}</span>
            </div>
            <h4 class="font-medium mb-2 line-through text-secondary-text">{{ task.title }}</h4>
            <div class="flex items-center justify-between">
              <div class="flex items-center gap-2">
                <div class="w-6 h-6 rounded-full bg-tertiary flex items-center justify-center text-xs">
                  {{ getUserName(task.assignee) }}
                </div>
              </div>
              <CheckCircle :size="16" class="text-accent-success" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </Layout>
</template>

<script setup>
import { computed, onMounted } from 'vue'
import Layout from '../components/Layout.vue'
import { useDataStore } from '../stores/data'
import { Plus, CheckCircle } from 'lucide-vue-next'

const dataStore = useDataStore()

const todoTasks = computed(() => dataStore.tasks.filter(t => t.status === 'todo'))
const inProgressTasks = computed(() => dataStore.tasks.filter(t => t.status === 'in-progress'))
const doneTasks = computed(() => dataStore.tasks.filter(t => t.status === 'done'))

const getPriorityBadgeClass = (priority) => {
  const classes = {
    'high': 'badge-danger',
    'medium': 'badge-warning',
    'low': 'badge-success',
  }
  return classes[priority] || 'badge-info'
}

const getUserName = (id) => {
  const user = dataStore.users.find(u => u.id === id)
  return user ? user.name.charAt(0) : '?'
}

onMounted(() => {
  dataStore.fetchTasks()
})
</script>

<style scoped>
.text-secondary-text {
  color: var(--text-secondary);
}
</style>
