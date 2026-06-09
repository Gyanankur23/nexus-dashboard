<template>
  <div class="relative">
    <Search :size="20" class="absolute left-3 top-1/2 transform -translate-y-1/2 text-secondary-text" />
    <input
      v-model="searchQuery"
      type="text"
      class="input pl-10"
      :placeholder="placeholder"
      @input="handleSearch"
    />
    <button
      v-if="searchQuery"
      @click="clearSearch"
      class="absolute right-3 top-1/2 transform -translate-y-1/2 text-secondary-text hover:text-white"
    >
      <X :size="16" />
    </button>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { Search, X } from 'lucide-vue-next'

const props = defineProps({
  placeholder: {
    type: String,
    default: 'Search...'
  }
})

const emit = defineEmits(['search'])

const searchQuery = ref('')

const handleSearch = () => {
  emit('search', searchQuery.value)
}

const clearSearch = () => {
  searchQuery.value = ''
  emit('search', '')
}
</script>

<style scoped>
.text-secondary-text {
  color: var(--text-secondary);
}
</style>
