<template>
  <div class="flex items-center justify-center min-h-64">
    <div class="relative">
      <div class="w-12 h-12 border-4 border-tertiary border-t-accent-primary rounded-full animate-spin"></div>
      <div class="absolute inset-0 w-12 h-12 border-4 border-transparent border-r-accent-secondary rounded-full animate-spin" style="animation-duration: 1.5s;"></div>
    </div>
    <p class="ml-4 text-secondary-text">{{ message }}</p>
  </div>
</template>

<script setup>
defineProps({
  message: {
    type: String,
    default: 'Loading...'
  }
})
</script>

<style scoped>
.text-secondary-text {
  color: var(--text-secondary);
}
</style>
