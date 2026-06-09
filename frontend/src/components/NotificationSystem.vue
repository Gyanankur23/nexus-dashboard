<template>
  <div class="fixed top-4 right-4 z-50 space-y-2">
    <transition-group name="notification">
      <div
        v-for="notification in notifications"
        :key="notification.id"
        class="card p-4 flex items-center gap-3 min-w-80"
        :class="getNotificationClass(notification.type)"
      >
        <component :is="getIcon(notification.type)" :size="20" />
        <div class="flex-1">
          <p class="font-medium text-sm">{{ notification.title }}</p>
          <p class="text-xs text-secondary-text">{{ notification.message }}</p>
        </div>
        <button @click="remove(notification.id)" class="text-secondary-text hover:text-white">
          <X :size="16" />
        </button>
      </div>
    </transition-group>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { CheckCircle, AlertCircle, Info, X } from 'lucide-vue-next'

const notifications = ref([])

const add = (title, message, type = 'info') => {
  const id = Date.now()
  notifications.value.push({ id, title, message, type })
  
  // Auto-remove after 5 seconds
  setTimeout(() => {
    remove(id)
  }, 5000)
}

const remove = (id) => {
  notifications.value = notifications.value.filter(n => n.id !== id)
}

const getNotificationClass = (type) => {
  const classes = {
    success: 'border-accent-success/50 bg-accent-success/10',
    error: 'border-accent-danger/50 bg-accent-danger/10',
    warning: 'border-accent-warning/50 bg-accent-warning/10',
    info: 'border-accent-primary/50 bg-accent-primary/10',
  }
  return classes[type] || classes.info
}

const getIcon = (type) => {
  const icons = {
    success: CheckCircle,
    error: AlertCircle,
    warning: AlertCircle,
    info: Info,
  }
  return icons[type] || Info
}

// Expose methods for global use
defineExpose({ add, remove })
</script>

<style scoped>
.notification-enter-active,
.notification-leave-active {
  transition: all 0.3s ease;
}

.notification-enter-from {
  opacity: 0;
  transform: translateX(100%);
}

.notification-leave-to {
  opacity: 0;
  transform: translateX(100%);
}

.text-secondary-text {
  color: var(--text-secondary);
}
</style>
