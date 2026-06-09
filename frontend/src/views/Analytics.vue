<template>
  <Layout>
    <div class="animate-fade-in">
      <div class="flex items-center justify-between mb-8">
        <div>
          <h1 class="text-3xl font-bold mb-2">Analytics</h1>
          <p class="text-secondary-text">Comprehensive performance metrics and insights</p>
        </div>
        <div class="flex gap-4">
          <select v-model="timeRange" class="input w-40">
            <option value="7d">Last 7 days</option>
            <option value="30d">Last 30 days</option>
            <option value="90d">Last 90 days</option>
            <option value="1y">Last year</option>
          </select>
          <button class="btn-secondary flex items-center gap-2">
            <Download :size="18" />
            Export
          </button>
        </div>
      </div>

      <!-- Key Metrics -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <div v-for="metric in keyMetrics" :key="metric.label" class="card">
          <div class="flex items-center justify-between mb-2">
            <span class="text-secondary-text text-sm">{{ metric.label }}</span>
            <span :class="metric.change >= 0 ? 'text-accent-success' : 'text-accent-danger'" class="text-sm font-medium">
              {{ metric.change >= 0 ? '+' : '' }}{{ metric.change }}%
            </span>
          </div>
          <p class="text-3xl font-bold">{{ metric.value }}</p>
          <div class="mt-2 h-1 bg-tertiary rounded-full overflow-hidden">
            <div class="h-full rounded-full" :style="{ width: metric.progress + '%', background: metric.color }" />
          </div>
        </div>
      </div>

      <!-- Charts Row -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
        <div class="card">
          <h3 class="text-lg font-semibold mb-4">Project Completion Rate</h3>
          <div class="space-y-4">
            <div v-for="item in completionData" :key="item.month" class="flex items-center gap-4">
              <span class="w-20 text-sm text-secondary-text">{{ item.month }}</span>
              <div class="flex-1 h-8 bg-tertiary rounded-lg overflow-hidden">
                <div class="h-full rounded-lg transition-all duration-500 flex items-center px-3" 
                     :style="{ width: item.value + '%', background: 'linear-gradient(90deg, #6366f1, #8b5cf6)' }">
                  <span class="text-xs font-medium text-white">{{ item.value }}%</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="card">
          <h3 class="text-lg font-semibold mb-4">Team Productivity</h3>
          <div class="space-y-4">
            <div v-for="member in teamProductivity" :key="member.name" class="flex items-center gap-4">
              <div class="w-10 h-10 rounded-full bg-tertiary flex items-center justify-center">
                {{ member.avatar }}
              </div>
              <div class="flex-1">
                <div class="flex items-center justify-between mb-1">
                  <span class="font-medium">{{ member.name }}</span>
                  <span class="text-sm text-secondary-text">{{ member.tasks }} tasks</span>
                </div>
                <div class="h-2 bg-tertiary rounded-full overflow-hidden">
                  <div class="h-full rounded-full" :style="{ width: member.efficiency + '%', background: getEfficiencyColor(member.efficiency) }" />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Performance Metrics -->
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
        <div class="card">
          <h3 class="text-lg font-semibold mb-4">Task Distribution</h3>
          <div class="space-y-3">
            <div v-for="item in taskDistribution" :key="item.status" class="flex items-center justify-between">
              <span class="text-sm">{{ item.status }}</span>
              <div class="flex items-center gap-2">
                <div class="w-32 h-2 bg-tertiary rounded-full overflow-hidden">
                  <div class="h-full rounded-full" :style="{ width: item.percentage + '%', background: item.color }" />
                </div>
                <span class="text-sm font-medium w-12 text-right">{{ item.count }}</span>
              </div>
            </div>
          </div>
        </div>

        <div class="card">
          <h3 class="text-lg font-semibold mb-4">Project Health</h3>
          <div class="text-center mb-4">
            <div class="text-5xl font-bold gradient-text mb-2">{{ projectHealth.score }}</div>
            <p class="text-secondary-text text-sm">Overall Health Score</p>
          </div>
          <div class="space-y-2">
            <div v-for="metric in projectHealth.metrics" :key="metric.name" class="flex items-center justify-between text-sm">
              <span class="text-secondary-text">{{ metric.name }}</span>
              <span :class="metric.status === 'good' ? 'text-accent-success' : 'text-accent-warning'">{{ metric.value }}</span>
            </div>
          </div>
        </div>

        <div class="card">
          <h3 class="text-lg font-semibold mb-4">Recent Achievements</h3>
          <div class="space-y-3">
            <div v-for="achievement in achievements" :key="achievement.id" class="flex items-center gap-3 p-3 bg-tertiary rounded-lg">
              <div class="p-2 rounded-lg" :class="achievement.bgColor">
                <component :is="achievement.icon" :size="20" :class="achievement.iconColor" />
              </div>
              <div>
                <p class="font-medium text-sm">{{ achievement.title }}</p>
                <p class="text-xs text-secondary-text">{{ achievement.description }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Trend Analysis -->
      <div class="card">
        <h3 class="text-lg font-semibold mb-4">Performance Trends</h3>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div v-for="trend in trends" :key="trend.metric" class="text-center p-4 bg-tertiary rounded-lg">
            <component :is="trend.icon" :size="32" :class="trend.iconColor" class="mx-auto mb-2" />
            <p class="text-2xl font-bold">{{ trend.value }}</p>
            <p class="text-sm text-secondary-text mb-1">{{ trend.metric }}</p>
            <span :class="trend.trend >= 0 ? 'text-accent-success' : 'text-accent-danger'" class="text-xs">
              {{ trend.trend >= 0 ? '↑' : '↓' }} {{ Math.abs(trend.trend) }}% vs last period
            </span>
          </div>
        </div>
      </div>
    </div>
  </Layout>
</template>

<script setup>
import { ref } from 'vue'
import Layout from '../components/Layout.vue'
import { Download, TrendingUp, Users, CheckCircle, Clock, Award, Zap } from 'lucide-vue-next'

const timeRange = ref('7d')

const keyMetrics = ref([
  { label: 'Total Revenue', value: '$124,500', change: 12.5, progress: 75, color: '#6366f1' },
  { label: 'Active Projects', value: '24', change: 8.3, progress: 60, color: '#8b5cf6' },
  { label: 'Tasks Completed', value: '1,247', change: 23.1, progress: 85, color: '#10b981' },
  { label: 'Team Efficiency', value: '94%', change: 5.2, progress: 94, color: '#f59e0b' },
])

const completionData = ref([
  { month: 'Jan', value: 65 },
  { month: 'Feb', value: 78 },
  { month: 'Mar', value: 82 },
  { month: 'Apr', value: 75 },
  { month: 'May', value: 88 },
  { month: 'Jun', value: 92 },
])

const teamProductivity = ref([
  { name: 'John Developer', avatar: '👨‍💻', tasks: 47, efficiency: 92 },
  { name: 'Sarah Designer', avatar: '👩‍🎨', tasks: 38, efficiency: 88 },
  { name: 'Mike Manager', avatar: '👨‍💼', tasks: 29, efficiency: 95 },
  { name: 'Admin User', avatar: '👨‍💼', tasks: 52, efficiency: 90 },
])

const taskDistribution = ref([
  { status: 'Completed', count: 847, percentage: 68, color: '#10b981' },
  { status: 'In Progress', count: 289, percentage: 23, color: '#6366f1' },
  { status: 'Pending', count: 111, percentage: 9, color: '#f59e0b' },
])

const projectHealth = ref({
  score: 87,
  metrics: [
    { name: 'On-time Delivery', value: '92%', status: 'good' },
    { name: 'Budget Adherence', value: '88%', status: 'good' },
    { name: 'Quality Score', value: '85%', status: 'good' },
    { name: 'Client Satisfaction', value: '90%', status: 'good' },
  ]
})

const achievements = ref([
  { id: 1, title: 'Fastest Project', description: 'Completed in record time', icon: Zap, iconColor: 'text-accent-warning', bgColor: 'bg-accent-warning/20' },
  { id: 2, title: 'Team Player', description: 'Most collaborative member', icon: Users, iconColor: 'text-accent-primary', bgColor: 'bg-accent-primary/20' },
  { id: 3, title: 'Quality Master', description: 'Zero bug deliveries', icon: CheckCircle, iconColor: 'text-accent-success', bgColor: 'bg-accent-success/20' },
])

const trends = ref([
  { metric: 'Productivity', value: '+18%', trend: 18, icon: TrendingUp, iconColor: 'text-accent-success' },
  { metric: 'Efficiency', value: '+12%', trend: 12, icon: Clock, iconColor: 'text-accent-primary' },
  { metric: 'Satisfaction', value: '+8%', trend: 8, icon: Award, iconColor: 'text-accent-secondary' },
])

const getEfficiencyColor = (efficiency) => {
  if (efficiency >= 90) return '#10b981'
  if (efficiency >= 80) return '#6366f1'
  if (efficiency >= 70) return '#f59e0b'
  return '#ef4444'
}
</script>

<style scoped>
.text-secondary-text {
  color: var(--text-secondary);
}
</style>
