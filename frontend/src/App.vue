<template>
  <router-view />
  <NotificationSystem ref="notificationSystem" />
</template>

<script setup>
import { onMounted, ref } from 'vue'
import NotificationSystem from './components/NotificationSystem.vue'

const notificationSystem = ref(null)

onMounted(() => {
  // Make notification system globally available
  window.notificationSystem = notificationSystem.value
})
</script>
