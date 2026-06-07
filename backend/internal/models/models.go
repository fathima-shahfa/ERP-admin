package models

import "time"

type Role struct {
	ID          uint      `json:"id"`
	Name        string    `json:"name"`
	Description string    `json:"description"`
	IsSystem    bool      `gorm:"column:is_system" json:"is_system"`
	CreatedAt   time.Time `json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}

type User struct {
	ID           uint       `json:"id"`
	Username     string     `json:"username"`
	Email        string     `json:"email"`
	PasswordHash string     `json:"-"`
	RoleID       uint       `gorm:"column:role_id" json:"role_id"`
	Role         Role       `json:"role"`
	Status       string     `json:"status"`
	FullName     string     `gorm:"column:full_name" json:"full_name"`
	Department   string     `json:"department"`
	LastLoginAt  *time.Time `gorm:"column:last_login_at" json:"last_login_at"`
	CreatedAt    time.Time  `json:"created_at"`
	UpdatedAt    time.Time  `json:"updated_at"`
}

type Permission struct {
	ID          uint   `json:"id"`
	Code        string `json:"code"`
	Label       string `json:"label"`
	Module      string `json:"module"`
	Description string `json:"description"`
}

type Module struct {
	ID          string    `json:"id"`
	Name        string    `json:"name"`
	ModuleGroup string    `gorm:"column:module_group" json:"module_group"`
	Status      string    `json:"status"`
	Owner       string    `json:"owner"`
	Description string    `json:"description"`
	UpdatedAt   time.Time `json:"updated_at"`
}

type SystemSetting struct {
	Key          string `gorm:"primaryKey" json:"key"`
	Value        string `json:"value"`
	Label        string `json:"label"`
	SettingGroup string `gorm:"column:setting_group" json:"setting_group"`
}

type AuditLog struct {
	ID        uint      `json:"id"`
	Actor     string    `json:"actor"`
	Action    string    `json:"action"`
	Target    string    `json:"target"`
	Details   string    `json:"details"`
	Severity  string    `json:"severity"`
	CreatedAt time.Time `json:"created_at"`
}
