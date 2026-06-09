<template>
  <Layout>
    <div class="animate-fade-in">
      <div class="mb-8">
        <h1 class="text-3xl font-bold mb-2">Settings</h1>
        <p class="text-secondary-text">Manage your account and preferences</p>
      </div>

      <div class="space-y-6">
        <!-- Profile Settings -->
        <div class="card">
          <h3 class="text-lg font-semibold mb-4">Profile Settings</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium mb-2">Full Name</label>
              <input type="text" class="input" :value="authStore.user?.name" />
            </div>
            <div>
              <label class="block text-sm font-medium mb-2">Email</label>
              <input type="email" class="input" :value="authStore.user?.email" />
            </div>
            <div>
              <label class="block text-sm font-medium mb-2">Role</label>
              <input type="text" class="input" :value="authStore.user?.role" disabled />
            </div>
          </div>
          <button class="btn-primary mt-4">Save Changes</button>
        </div>

        <!-- Security Settings -->
        <div class="card">
          <h3 class="text-lg font-semibold mb-4">Security</h3>
          <div class="space-y-4">
            <div>
              <label class="block text-sm font-medium mb-2">Current Password</label>
              <input type="password" class="input" placeholder="••••••••" />
            </div>
            <div>
              <label class="block text-sm font-medium mb-2">New Password</label>
              <input type="password" class="input" placeholder="••••••••" />
            </div>
            <div>
              <label class="block text-sm font-medium mb-2">Confirm Password</label>
              <input type="password" class="input" placeholder="••••••••" />
            </div>
          </div>
          <button class="btn-primary mt-4">Update Password</button>
        </div>

        <!-- Notifications -->
        <div class="card">
          <h3 class="text-lg font-semibold mb-4">Notifications</h3>
          <div class="space-y-4">
            <label class="flex items-center gap-3 cursor-pointer">
              <input type="checkbox" checked class="w-5 h-5 rounded bg-tertiary border-border" />
              <span>Email notifications for new tasks</span>
            </label>
            <label class="flex items-center gap-3 cursor-pointer">
              <input type="checkbox" checked class="w-5 h-5 rounded bg-tertiary border-border" />
              <span>Email notifications for project updates</span>
            </label>
            <label class="flex items-center gap-3 cursor-pointer">
              <input type="checkbox" class="w-5 h-5 rounded bg-tertiary border-border" />
              <span>Push notifications</span>
            </label>
            <label class="flex items-center gap-3 cursor-pointer">
              <input type="checkbox" checked class="w-5 h-5 rounded bg-tertiary border-border" />
              <span>Weekly digest</span>
            </label>
          </div>
        </div>

        <!-- Danger Zone -->
        <div class="card border-accent-danger/50">
          <h3 class="text-lg font-semibold mb-4 text-accent-danger">Danger Zone</h3>
          <p class="text-secondary-text mb-4">Once you delete your account, there is no going back. Please be certain.</p>
          <button class="btn-secondary border-accent-danger text-accent-danger hover:bg-accent-danger hover:text-white">
            Delete Account
          </button>
        </div>
      </div>
    </div>
  </Layout>
</template>

<script setup>
import { useAuthStore } from '../stores/auth'

const authStore = useAuthStore()
authStore.initialize()
</script>

<style scoped>
.text-secondary-text {
  color: var(--text-secondary);
}
</style>
