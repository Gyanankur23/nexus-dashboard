<template>
  <Layout>
    <div class="animate-fade-in">
      <div class="flex items-center justify-between mb-8">
        <div>
          <h1 class="text-3xl font-bold mb-2">Projects</h1>
          <p class="text-secondary-text">Manage your team projects</p>
        </div>
        <div class="flex gap-4">
          <SearchBar placeholder="Search projects..." @search="handleSearch" />
          <button class="btn-primary flex items-center gap-2">
            <Plus :size="18" />
            New Project
          </button>
        </div>
      </div>

      <!-- Filters -->
      <div class="flex gap-4 mb-6">
        <select v-model="filterStatus" class="input w-40" @change="filterProjects">
          <option value="all">All Status</option>
          <option value="in-progress">In Progress</option>
          <option value="completed">Completed</option>
          <option value="pending">Pending</option>
        </select>
        <select v-model="filterPriority" class="input w-40" @change="filterProjects">
          <option value="all">All Priority</option>
          <option value="high">High</option>
          <option value="medium">Medium</option>
          <option value="low">Low</option>
        </select>
        <button class="btn-secondary flex items-center gap-2" @click="exportProjects">
          <Download :size="18" />
          Export CSV
        </button>
      </div>

      <!-- Project Grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div v-for="project in filteredProjects" :key="project.id" class="card hover:border-accent-primary transition-all cursor-pointer" @click="viewProject(project)">
          <div class="flex items-center justify-between mb-4">
            <div class="p-3 rounded-lg bg-accent-primary/20 text-accent-primary">
              <Folder :size="24" />
            </div>
            <span class="badge" :class="getStatusBadgeClass(project.status)">
              {{ project.status }}
            </span>
          </div>
          
          <h3 class="text-xl font-semibold mb-2">{{ project.name }}</h3>
          <p class="text-secondary-text text-sm mb-4">Project ID: #{{ project.id }}</p>
          
          <div class="mb-4">
            <div class="flex items-center justify-between mb-2">
              <span class="text-sm text-secondary-text">Progress</span>
              <span class="text-sm font-medium">{{ project.progress }}%</span>
            </div>
            <div class="h-2 bg-tertiary rounded-full overflow-hidden">
              <div 
                class="h-full rounded-full transition-all duration-500"
                :style="{ width: project.progress + '%', background: getProgressColor(project.progress) }"
              />
            </div>
          </div>
          
          <div class="flex items-center justify-between pt-4 border-t border-border">
            <div class="flex -space-x-2">
              <div v-for="(member, idx) in project.team.slice(0, 3)" :key="idx" class="w-8 h-8 rounded-full bg-tertiary border-2 border-secondary flex items-center justify-center text-sm">
                {{ getUserName(member) }}
              </div>
              <div v-if="project.team.length > 3" class="w-8 h-8 rounded-full bg-accent-primary border-2 border-secondary flex items-center justify-center text-xs">
                +{{ project.team.length - 3 }}
              </div>
            </div>
            <div class="text-right">
              <p class="text-xs text-secondary-text">Deadline</p>
              <p class="text-sm font-medium">{{ project.deadline }}</p>
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
import SearchBar from '../components/SearchBar.vue'
import { useDataStore } from '../stores/data'
import { Plus, Folder, Download } from 'lucide-vue-next'

const dataStore = useDataStore()

const filterStatus = ref('all')
const filterPriority = ref('all')
const searchQuery = ref('')

const filteredProjects = computed(() => {
  let projects = [...dataStore.projects]
  
  // Apply search
  if (searchQuery.value) {
    projects = projects.filter(project => 
      project.name.toLowerCase().includes(searchQuery.value.toLowerCase())
    )
  }
  
  // Apply status filter
  if (filterStatus.value !== 'all') {
    projects = projects.filter(project => project.status === filterStatus.value)
  }
  
  // Apply priority filter
  if (filterPriority.value !== 'all') {
    projects = projects.filter(project => project.priority === filterPriority.value)
  }
  
  return projects
})

const handleSearch = (query) => {
  searchQuery.value = query
}

const filterProjects = () => {
  // Handled by computed property
}

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

const getUserName = (id) => {
  const user = dataStore.users.find(u => u.id === id)
  return user ? user.name.charAt(0) : '?'
}

const viewProject = (project) => {
  if (window.notificationSystem) {
    window.notificationSystem.add('View Project', `Opening ${project.name}`, 'info')
  }
}

const exportProjects = () => {
  const csv = [
    ['ID', 'Name', 'Status', 'Progress', 'Priority', 'Deadline'].join(','),
    ...filteredProjects.value.map(p => [p.id, p.name, p.status, p.progress, p.priority, p.deadline].join(','))
  ].join('\n')
  
  const blob = new Blob([csv], { type: 'text/csv' })
  const url = window.URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = 'projects.csv'
  a.click()
  
  if (window.notificationSystem) {
    window.notificationSystem.add('Export Successful', 'Projects exported to CSV', 'success')
  }
}

onMounted(() => {
  dataStore.fetchProjects()
})
</script>

<style scoped>
.text-secondary-text {
  color: var(--text-secondary);
}
</style>
