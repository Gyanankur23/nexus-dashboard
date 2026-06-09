<template>
  <Layout>
    <div class="animate-fade-in">
      <div class="flex items-center justify-between mb-8">
        <div>
          <h1 class="text-3xl font-bold mb-2">Users</h1>
          <p class="text-secondary-text">Manage team members</p>
        </div>
        <div class="flex gap-4">
          <SearchBar placeholder="Search users..." @search="handleSearch" />
          <button class="btn-primary flex items-center gap-2">
            <Plus :size="18" />
            Add User
          </button>
        </div>
      </div>

      <!-- Filters -->
      <div class="flex gap-4 mb-6">
        <select v-model="filterRole" class="input w-40" @change="filterUsers">
          <option value="all">All Roles</option>
          <option value="admin">Admin</option>
          <option value="developer">Developer</option>
          <option value="designer">Designer</option>
          <option value="manager">Manager</option>
        </select>
        <select v-model="filterStatus" class="input w-40" @change="filterUsers">
          <option value="all">All Status</option>
          <option value="active">Active</option>
          <option value="inactive">Inactive</option>
        </select>
        <button class="btn-secondary flex items-center gap-2" @click="exportUsers">
          <Download :size="18" />
          Export CSV
        </button>
      </div>

      <!-- Users Table -->
      <div class="card overflow-hidden">
        <table class="w-full">
          <thead>
            <tr class="border-b border-border">
              <th class="text-left p-4 text-secondary-text font-medium cursor-pointer hover:text-white" @click="sortBy('name')">
                User <span v-if="sortField === 'name'">{{ sortOrder === 'asc' ? '↑' : '↓' }}</span>
              </th>
              <th class="text-left p-4 text-secondary-text font-medium cursor-pointer hover:text-white" @click="sortBy('role')">
                Role <span v-if="sortField === 'role'">{{ sortOrder === 'asc' ? '↑' : '↓' }}</span>
              </th>
              <th class="text-left p-4 text-secondary-text font-medium cursor-pointer hover:text-white" @click="sortBy('status')">
                Status <span v-if="sortField === 'status'">{{ sortOrder === 'asc' ? '↑' : '↓' }}</span>
              </th>
              <th class="text-left p-4 text-secondary-text font-medium cursor-pointer hover:text-white" @click="sortBy('joined')">
                Joined <span v-if="sortField === 'joined'">{{ sortOrder === 'asc' ? '↑' : '↓' }}</span>
              </th>
              <th class="text-left p-4 text-secondary-text font-medium">Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="user in filteredUsers" :key="user.id" class="border-b border-border hover:bg-tertiary transition-colors">
              <td class="p-4">
                <div class="flex items-center gap-3">
                  <div class="w-10 h-10 rounded-full bg-tertiary flex items-center justify-center text-xl">
                    {{ user.avatar }}
                  </div>
                  <div>
                    <p class="font-medium">{{ user.name }}</p>
                    <p class="text-sm text-secondary-text">{{ user.email }}</p>
                  </div>
                </div>
              </td>
              <td class="p-4">
                <span class="badge badge-info">{{ user.role }}</span>
              </td>
              <td class="p-4">
                <span class="badge" :class="user.status === 'active' ? 'badge-success' : 'badge-danger'">
                  {{ user.status }}
                </span>
              </td>
              <td class="p-4 text-secondary-text">{{ user.joined }}</td>
              <td class="p-4">
                <div class="flex gap-2">
                  <button class="p-2 rounded-lg hover:bg-border transition-colors" @click="editUser(user)">
                    <Edit :size="16" />
                  </button>
                  <button class="p-2 rounded-lg hover:bg-border transition-colors text-accent-danger" @click="deleteUser(user)">
                    <Trash2 :size="16" />
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </Layout>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import Layout from '../components/Layout.vue'
import SearchBar from '../components/SearchBar.vue'
import { useDataStore } from '../stores/data'
import { Plus, Edit, Trash2, Download } from 'lucide-vue-next'

const dataStore = useDataStore()

const filterRole = ref('all')
const filterStatus = ref('all')
const searchQuery = ref('')
const sortField = ref('name')
const sortOrder = ref('asc')

const filteredUsers = computed(() => {
  let users = [...dataStore.users]
  
  // Apply search
  if (searchQuery.value) {
    users = users.filter(user => 
      user.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
      user.email.toLowerCase().includes(searchQuery.value.toLowerCase())
    )
  }
  
  // Apply role filter
  if (filterRole.value !== 'all') {
    users = users.filter(user => user.role === filterRole.value)
  }
  
  // Apply status filter
  if (filterStatus.value !== 'all') {
    users = users.filter(user => user.status === filterStatus.value)
  }
  
  // Apply sorting
  users.sort((a, b) => {
    const aVal = a[sortField.value]
    const bVal = b[sortField.value]
    if (sortOrder.value === 'asc') {
      return aVal.localeCompare(bVal)
    } else {
      return bVal.localeCompare(aVal)
    }
  })
  
  return users
})

const handleSearch = (query) => {
  searchQuery.value = query
}

const filterUsers = () => {
  // Handled by computed property
}

const sortBy = (field) => {
  if (sortField.value === field) {
    sortOrder.value = sortOrder.value === 'asc' ? 'desc' : 'asc'
  } else {
    sortField.value = field
    sortOrder.value = 'asc'
  }
}

const editUser = (user) => {
  if (window.notificationSystem) {
    window.notificationSystem.add('Edit User', `Editing ${user.name}`, 'info')
  }
}

const deleteUser = (user) => {
  if (window.notificationSystem) {
    window.notificationSystem.add('Delete User', `Deleted ${user.name}`, 'warning')
  }
}

const exportUsers = () => {
  const csv = [
    ['Name', 'Email', 'Role', 'Status', 'Joined'].join(','),
    ...filteredUsers.value.map(u => [u.name, u.email, u.role, u.status, u.joined].join(','))
  ].join('\n')
  
  const blob = new Blob([csv], { type: 'text/csv' })
  const url = window.URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = 'users.csv'
  a.click()
  
  if (window.notificationSystem) {
    window.notificationSystem.add('Export Successful', 'Users exported to CSV', 'success')
  }
}

onMounted(() => {
  dataStore.fetchUsers()
})
</script>

<style scoped>
.text-secondary-text {
  color: var(--text-secondary);
}
</style>
