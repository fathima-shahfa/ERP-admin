package main

import (
	"log"

	"erp-admin-backend/internal/config"
	"erp-admin-backend/internal/database"
	"erp-admin-backend/internal/server"
)

func main() {
	cfg := config.Load()
	db, err := database.Connect(cfg)
	if err != nil {
		log.Fatalf("failed to connect to database: %v", err)
	}

	router := server.NewRouter(db)
	router.Run(":" + cfg.Port)
}
