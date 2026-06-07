# ERP Admin Module - Complete System

## Run with Docker

Open a terminal in this folder and run:

```powershell
docker compose down -v
docker compose up --build
```

Then open:

```text
http://localhost:3000
```

Default login:

```text
Username: admin
Password: admin123
```

## Included Features

- Admin dashboard with user, role, module, and audit metrics
- Real backend login endpoint
- User create, edit, delete, suspend, and password reset
- Role management
- Permission assignment per role
- ERP module status and owner management
- System settings management
- Audit log tracking for important admin actions
- PostgreSQL seed database
- Dockerized frontend, backend, and database

If the database schema changes, run `docker compose down -v` once before starting again.
