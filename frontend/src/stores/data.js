import { defineStore } from 'pinia'

// Mock data for demo purposes
const MOCK_USERS = [
  { id: 1, name: 'Admin User', email: 'admin@nexus.com', role: 'admin', avatar: '👨‍💼', status: 'active', joined: '2024-01-15' },
  { id: 2, name: 'John Developer', email: 'john@nexus.com', role: 'developer', avatar: '👨‍💻', status: 'active', joined: '2024-02-20' },
  { id: 3, name: 'Sarah Designer', email: 'sarah@nexus.com', role: 'designer', avatar: '👩‍🎨', status: 'active', joined: '2024-03-10' },
  { id: 4, name: 'Mike Manager', email: 'mike@nexus.com', role: 'manager', avatar: '👨‍💼', status: 'inactive', joined: '2024-01-05' },
  { id: 5, name: 'Emily QA', email: 'emily@nexus.com', role: 'developer', avatar: '👩‍💻', status: 'active', joined: '2024-04-01' },
  { id: 6, name: 'David DevOps', email: 'david@nexus.com', role: 'developer', avatar: '👨‍💻', status: 'active', joined: '2024-04-15' },
]

const MOCK_PROJECTS = [
  { id: 1, name: 'Website Redesign', status: 'in-progress', progress: 65, team: [1, 2, 3], deadline: '2024-07-15', priority: 'high' },
  { id: 2, name: 'Mobile App Development', status: 'in-progress', progress: 40, team: [2, 3], deadline: '2024-08-20', priority: 'high' },
  { id: 3, name: 'API Integration', status: 'completed', progress: 100, team: [2], deadline: '2024-05-30', priority: 'medium' },
  { id: 4, name: 'Database Migration', status: 'pending', progress: 0, team: [2, 4], deadline: '2024-09-01', priority: 'low' },
  { id: 5, name: 'E-commerce Platform', status: 'in-progress', progress: 75, team: [2, 5, 6], deadline: '2024-06-30', priority: 'high' },
  { id: 6, name: 'Security Audit', status: 'completed', progress: 100, team: [6], deadline: '2024-05-15', priority: 'high' },
]

const MOCK_TASKS = [
  { id: 1, projectId: 1, title: 'Design homepage mockup', status: 'done', assignee: 3, priority: 'high' },
  { id: 2, projectId: 1, title: 'Implement responsive layout', status: 'in-progress', assignee: 2, priority: 'high' },
  { id: 3, projectId: 1, title: 'Add animations', status: 'todo', assignee: 3, priority: 'medium' },
  { id: 4, projectId: 2, title: 'Setup React Native', status: 'done', assignee: 2, priority: 'high' },
  { id: 5, projectId: 2, title: 'Build login screen', status: 'in-progress', assignee: 2, priority: 'high' },
  { id: 6, projectId: 2, title: 'Integrate API', status: 'todo', assignee: 2, priority: 'medium' },
  { id: 7, projectId: 5, title: 'Setup payment gateway', status: 'in-progress', assignee: 2, priority: 'high' },
  { id: 8, projectId: 5, title: 'Product catalog', status: 'done', assignee: 5, priority: 'high' },
  { id: 9, projectId: 5, title: 'Shopping cart', status: 'in-progress', assignee: 2, priority: 'high' },
  { id: 10, projectId: 6, title: 'Penetration testing', status: 'done', assignee: 6, priority: 'high' },
]

const MOCK_STATS = {
  totalUsers: 6,
  activeUsers: 5,
  totalProjects: 6,
  completedProjects: 2,
  totalTasks: 10,
  completedTasks: 4,
  productivity: 85,
}

export const useDataStore = defineStore('data', {
  state: () => ({
    users: [],
    projects: [],
    tasks: [],
    stats: null,
    loading: false,
    error: null
  }),
  
  actions: {
    async fetchDashboard() {
      this.loading = true
      // Simulate API delay
      await new Promise(resolve => setTimeout(resolve, 300))
      
      try {
        this.stats = MOCK_STATS
        this.projects = MOCK_PROJECTS
        this.tasks = MOCK_TASKS
        this.users = MOCK_USERS
      } catch (error) {
        this.error = error.message
      } finally {
        this.loading = false
      }
    },
    
    async fetchUsers() {
      this.loading = true
      await new Promise(resolve => setTimeout(resolve, 300))
      
      try {
        this.users = MOCK_USERS
      } catch (error) {
        this.error = error.message
      } finally {
        this.loading = false
      }
    },
    
    async fetchProjects() {
      this.loading = true
      await new Promise(resolve => setTimeout(resolve, 300))
      
      try {
        this.projects = MOCK_PROJECTS
      } catch (error) {
        this.error = error.message
      } finally {
        this.loading = false
      }
    },
    
    async fetchTasks() {
      this.loading = true
      await new Promise(resolve => setTimeout(resolve, 300))
      
      try {
        this.tasks = MOCK_TASKS
      } catch (error) {
        this.error = error.message
      } finally {
        this.loading = false
      }
    }
  }
})
