<template>
  <div v-if="error" class="card p-8 text-center">
    <AlertCircle :size="48" class="mx-auto mb-4 text-accent-danger" />
    <h2 class="text-xl font-bold mb-2">Something went wrong</h2>
    <p class="text-secondary-text mb-4">{{ error.message }}</p>
    <button @click="reset" class="btn-primary">Try Again</button>
  </div>
  <slot v-else />
</template>

<script setup>
import { ref, onErrorCaptured } from 'vue'
import { AlertCircle } from 'lucide-vue-next'

const error = ref(null)

onErrorCaptured((err) => {
  error.value = err
  return false
})

const reset = () => {
  error.value = null
}
</script>

<style scoped>
.text-secondary-text {
  color: var(--text-secondary);
}
</style>
