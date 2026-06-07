CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT NOT NULL DEFAULT '',
    is_system BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role_id INTEGER REFERENCES roles(id),
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    full_name VARCHAR(100) NOT NULL DEFAULT '',
    department VARCHAR(80) NOT NULL DEFAULT '',
    last_login_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS permissions (
    id SERIAL PRIMARY KEY,
    code VARCHAR(80) UNIQUE NOT NULL,
    label VARCHAR(120) NOT NULL,
    module VARCHAR(80) NOT NULL,
    description TEXT NOT NULL DEFAULT ''
);

CREATE TABLE IF NOT EXISTS role_permissions (
    role_id INTEGER REFERENCES roles(id) ON DELETE CASCADE,
    permission_id INTEGER REFERENCES permissions(id) ON DELETE CASCADE,
    PRIMARY KEY (role_id, permission_id)
);

CREATE TABLE IF NOT EXISTS modules (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    module_group VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    owner VARCHAR(100) NOT NULL DEFAULT '',
    description TEXT NOT NULL DEFAULT '',
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS system_settings (
    key VARCHAR(80) PRIMARY KEY,
    value TEXT NOT NULL,
    label VARCHAR(120) NOT NULL,
    setting_group VARCHAR(80) NOT NULL
);

CREATE TABLE IF NOT EXISTS audit_logs (
    id SERIAL PRIMARY KEY,
    actor VARCHAR(80) NOT NULL,
    action VARCHAR(120) NOT NULL,
    target VARCHAR(120) NOT NULL,
    details TEXT NOT NULL DEFAULT '',
    severity VARCHAR(20) NOT NULL DEFAULT 'info',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO roles (name, description, is_system) VALUES
('SuperAdmin', 'Full access to every admin capability', TRUE),
('Admin', 'Can manage users, modules, and settings', TRUE),
('Auditor', 'Read-only access to reports and audit logs', TRUE),
('User', 'Basic access with no administrative privileges', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO permissions (code, label, module, description) VALUES
('dashboard.view', 'View dashboard', 'Dashboard', 'See admin overview and metrics'),
('users.manage', 'Manage users', 'Users', 'Create, update, suspend, and delete users'),
('roles.manage', 'Manage roles', 'Roles', 'Create roles and assign permissions'),
('modules.manage', 'Manage modules', 'Modules', 'Enable, disable, and configure ERP modules'),
('settings.manage', 'Manage settings', 'Settings', 'Update global system settings'),
('audit.view', 'View audit logs', 'Audit', 'Review system activity history')
ON CONFLICT (code) DO NOTHING;

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r CROSS JOIN permissions p
WHERE r.name = 'SuperAdmin'
ON CONFLICT DO NOTHING;

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r JOIN permissions p ON p.code IN (
    'dashboard.view', 'users.manage', 'modules.manage', 'settings.manage', 'audit.view'
)
WHERE r.name = 'Admin'
ON CONFLICT DO NOTHING;

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r JOIN permissions p ON p.code IN ('dashboard.view', 'audit.view')
WHERE r.name = 'Auditor'
ON CONFLICT DO NOTHING;

INSERT INTO users (username, email, password_hash, role_id, status, full_name, department)
SELECT 'admin', 'admin@erp.com', '$2a$10$En5mWTwACXTDj76i95nfS.KNNf4CDohI0TKKSRLgtH5GH5S7bbtPa', r.id, 'active', 'System Administrator', 'IT'
FROM roles r WHERE r.name = 'SuperAdmin'
ON CONFLICT (username) DO NOTHING;

INSERT INTO modules (id, name, module_group, status, owner, description) VALUES
('admin', 'Admin Module', '12', 'active', 'IT Administration', 'Central system administration and access control'),
('finance', 'Finance Management', '9', 'active', 'Finance Team', 'Budgets, payments, and financial reporting'),
('hr', 'Human Resource Management', '10', 'active', 'HR Team', 'Employee records and HR workflows'),
('procurement', 'Procurement Module', '11', 'active', 'Operations', 'Supplier, purchase order, and inventory workflows'),
('project', 'Project Management Module', '13', 'maintenance', 'PMO', 'Project planning, tracking, and delivery controls'),
('asset', 'Asset Management Module', '14', 'inactive', 'Facilities', 'Company asset tracking and lifecycle management')
ON CONFLICT (id) DO NOTHING;

INSERT INTO system_settings (key, value, label, setting_group) VALUES
('company_name', 'Acme Corp ERP', 'Company / ERP Name', 'General'),
('timezone', 'UTC', 'System Timezone', 'General'),
('date_format', 'MM/DD/YYYY', 'Date Format', 'General'),
('require_2fa', 'true', 'Require Two-Factor Authentication', 'Security'),
('session_timeout', '30', 'Session Timeout Minutes', 'Security'),
('password_min_length', '8', 'Minimum Password Length', 'Security'),
('maintenance_mode', 'false', 'Maintenance Mode', 'Operations'),
('email_notifications', 'true', 'Email Notifications', 'Notifications')
ON CONFLICT (key) DO NOTHING;

INSERT INTO audit_logs (actor, action, target, details, severity) VALUES
('system', 'System initialized', 'Admin Module', 'Default roles, permissions, modules, and settings created', 'success')
ON CONFLICT DO NOTHING;
