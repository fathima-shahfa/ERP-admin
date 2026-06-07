<script setup>
import { reactive } from 'vue'

defineProps({
  error: {
    type: String,
    default: ''
  }
})

const emit = defineEmits(['login'])

const form = reactive({
  username: '',
  password: ''
})
</script>

<template>
  <div class="login-container">
    <div class="login-box glass">
      <div class="login-header">
        <div class="logo"></div>
        <h2>ERP Admin Login</h2>
        <p>Please sign in to continue</p>
      </div>

      <form class="login-form" @submit.prevent="emit('login', form)">
        <div v-if="error" class="error-alert">{{ error }}</div>

        <div class="form-group">
          <label>Username</label>
          <input v-model="form.username" type="text" placeholder="Enter 'admin'" />
        </div>

        <div class="form-group">
          <label>Password</label>
          <input v-model="form.password" type="password" placeholder="Enter any password" />
        </div>

        <button type="submit" class="btn btn-primary login-btn">Sign In</button>
      </form>
    </div>
  </div>
</template>
