<script setup>
defineProps({
  settingsForm: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['save'])
</script>

<template>
  <div class="settings-view fade-in">
    <div class="page-header">
      <h1 class="page-title">Global Settings</h1>
      <button class="btn btn-primary" @click="emit('save')">Save Changes</button>
    </div>

    <div class="settings-grid">
      <div class="glass-card settings-section">
        <h3 class="section-title-small">General Information</h3>
        <div class="form-group">
          <label>Company/ERP Name</label>
          <input v-model="settingsForm.companyName" type="text" />
        </div>
        <div class="form-group">
          <label>System Timezone</label>
          <select v-model="settingsForm.timezone" class="form-select">
            <option value="UTC">UTC (Universal Coordinated Time)</option>
            <option value="EST">EST (Eastern Standard Time)</option>
            <option value="PST">PST (Pacific Standard Time)</option>
          </select>
        </div>
        <div class="form-group">
          <label>Default Date Format</label>
          <select v-model="settingsForm.dateFormat" class="form-select">
            <option value="MM/DD/YYYY">MM/DD/YYYY</option>
            <option value="DD/MM/YYYY">DD/MM/YYYY</option>
            <option value="YYYY-MM-DD">YYYY-MM-DD</option>
          </select>
        </div>
      </div>

      <div class="glass-card settings-section">
        <h3 class="section-title-small">Security Policies</h3>
        <div class="toggle-group">
          <div class="toggle-info">
            <h4>Require 2FA (Two-Factor Auth)</h4>
            <p>Force all administrators to use 2FA for login.</p>
          </div>
          <label class="switch">
            <input v-model="settingsForm.require2FA" type="checkbox" />
            <span class="slider round"></span>
          </label>
        </div>

        <div class="form-group mt-4">
          <label>Session Timeout (Minutes)</label>
          <input v-model="settingsForm.sessionTimeout" type="number" min="5" max="1440" />
        </div>

        <div class="danger-zone mt-4">
          <h4>Danger Zone</h4>
          <button class="btn btn-outline border-danger text-danger mt-2">Factory Reset System</button>
        </div>
      </div>
    </div>
  </div>
</template>
