<template>
  <Layout>
    <div class="animate-fade-in">
      <div class="flex items-center justify-between mb-8">
        <div>
          <h1 class="text-3xl font-bold mb-2">Activity Feed</h1>
          <p class="text-secondary-text">Track all system activities and changes</p>
        </div>
        <div class="flex gap-4">
          <SearchBar placeholder="Search activities..." @search="handleSearch" />
          <select v-model="filterType" class="input w-40" @change="filterActivities">
            <option value="all">All Types</option>
            <option value="user">User</option>
            <option value="project">Project</option>
            <option value="task">Task</option>
            <option value="system">System</option>
          </select>
        </div>
      </div>

      <div class="space-y-4">
        <div v-for="activity in filteredActivities" :key="activity.id" class="card p-4 flex items-start gap-4">
          <div class="p-2 rounded-lg" :class="getActivityIconClass(activity.type)">
            <component :is="getActivityIcon(activity.type)" :size="20" />
          </div>
          <div class="flex-1">
            <div class="flex items-center gap-2 mb-1">
              <span class="font-medium">{{ activity.user }}</span>
              <span class="text-secondary-text text-sm">{{ activity.action }}</span>
            </div>
            <p class="text-sm text-secondary-text mb-2">{{ activity.description }}</p>
            <div class="flex items-center gap-4 text-xs text-secondary-text">
              <span>{{ activity.timestamp }}</span>
              <span class="badge" :class="getTypeBadgeClass(activity.type)">{{ activity.type }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </Layout>
</template>

<script setup>
import { ref, computed } from 'vue'
import Layout from '../components/Layout.vue'
import SearchBar from '../components/SearchBar.vue'
import { User, Folder, CheckSquare, Settings, Clock } from 'lucide-vue-next'

const activities = ref([
  { id: 1, user: 'Admin User', action: 'created', description: 'New project "Website Redesign"', type: 'project', timestamp: '2 minutes ago' },
  { id: 2, user: 'John Developer', action: 'completed', description: 'Task "Setup React Native"', type: 'task', timestamp: '15 minutes ago' },
  { id: 3, user: 'Sarah Designer', action: 'updated', description: 'Profile settings', type: 'user', timestamp: '1 hour ago' },
  { id: 4, user: 'System', action: 'deployed', description: 'Version 1.0.0 to production', type: 'system', timestamp: '3 hours ago' },
  { id: 5, user: 'Mike Manager', action: 'assigned', description: 'Task "Database Migration" to John Developer', type: 'task', timestamp: '5 hours ago' },
  { id: 6, user: 'Admin User', action: 'added', description: 'New user "Sarah Designer" to team', type: 'user', timestamp: '1 day ago' },
  { id: 7, user: 'John Developer', action: 'commented', description: 'On project "Mobile App Development"', type: 'project', timestamp: '1 day ago' },
  { id: 8, user: 'System', action: 'backed up', description: 'Database backup completed', type: 'system', timestamp: '2 days ago' },
])

const filterType = ref('all')
const searchQuery = ref('')

const filteredActivities = computed(() => {
  return activities.value.filter(activity => {
    const matchesType = filterType.value === 'all' || activity.type === filterType.value
    const matchesSearch = searchQuery.value === '' || 
      activity.description.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
      activity.user.toLowerCase().includes(searchQuery.value.toLowerCase())
    return matchesType && matchesSearch
  })
})

const handleSearch = (query) => {
  searchQuery.value = query
}

const filterActivities = () => {
  // Handled by computed property
}

const getActivityIcon = (type) => {
  const icons = {
    user: User,
    project: Folder,
    task: CheckSquare,
    system: Settings,
  }
  return icons[type] || Clock
}

const getActivityIconClass = (type) => {
  const classes = {
    user: 'bg-accent-primary/20 text-accent-primary',
    project: 'bg-accent-secondary/20 text-accent-secondary',
    task: 'bg-accent-success/20 text-accent-success',
    system: 'bg-accent-warning/20 text-accent-warning',
  }
  return classes[type] || 'bg-tertiary text-secondary-text'
}

const getTypeBadgeClass = (type) => {
  const classes = {
    user: 'badge-info',
    project: 'badge-success',
    task: 'badge-warning',
    system: 'badge-danger',
  }
  return classes[type] || 'badge-info'
}
</script>

<style scoped>
.text-secondary-text {
  color: var(--text-secondary);
}
</style>
