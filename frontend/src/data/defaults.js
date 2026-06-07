export const defaultActivities = [
  { id: 1, action: 'User login', detail: 'SuperAdmin signed in', time: 'Just now', type: 'info' },
  { id: 2, action: 'Module connected', detail: 'Finance Management sync established', time: '10 mins ago', type: 'success' },
  { id: 3, action: 'System Alert', detail: 'High CPU usage detected on Database server', time: '1 hr ago', type: 'warning' },
  { id: 4, action: 'User added', detail: 'New user "jdoe" created', time: '2 hrs ago', type: 'info' }
]

export const defaultIntegrations = [
  { id: 1, name: 'Stripe Payment Gateway', icon: 'CARD', status: 'connected', description: 'Process global payments and subscriptions' },
  { id: 2, name: 'SendGrid SMTP', icon: 'MAIL', status: 'connected', description: 'Automated system emails and notifications' },
  { id: 3, name: 'Slack Alerts', icon: 'CHAT', status: 'disconnected', description: 'Send critical system alerts to Slack channel' },
  { id: 4, name: 'Salesforce CRM', icon: 'CRM', status: 'disconnected', description: 'Sync customer data automatically' }
]

export const fallbackModules = [
  { id: 'admin', name: 'Admin Module', group: '12', status: 'active' },
  { id: 'finance', name: 'Finance Management', group: '9', status: 'offline' }
]

export const fallbackUsers = [
  { id: 1, username: 'admin', role: 'SuperAdmin', email: 'admin@erp.com' },
  { id: 2, username: 'testuser', role: 'User', email: 'test@erp.com' }
]
