<script setup>
defineProps({
  integrations: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['toggle-integration'])
</script>

<template>
  <div class="integrations-view fade-in">
    <div class="page-header">
      <h1 class="page-title">Third-Party Integrations</h1>
    </div>

    <div class="integrations-grid">
      <div v-for="integration in integrations" :key="integration.id" class="glass-card integration-card">
        <div class="integration-header">
          <div class="int-icon">{{ integration.icon }}</div>
          <div class="int-info">
            <h3>{{ integration.name }}</h3>
            <span :class="['status-badge', integration.status]">{{ integration.status }}</span>
          </div>
        </div>
        <p class="integration-desc">{{ integration.description }}</p>
        <div class="integration-footer">
          <button
            class="btn"
            :class="integration.status === 'connected' ? 'btn-outline border-danger text-danger' : 'btn-outline'"
            @click="emit('toggle-integration', integration)"
          >
            {{ integration.status === 'connected' ? 'Disconnect' : 'Connect' }}
          </button>
          <button v-if="integration.status === 'connected'" class="btn-text">Configure</button>
        </div>
      </div>
    </div>
  </div>
</template>
