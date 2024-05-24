# Makefile for astein"s Inception

# Colors
RED    		= "\033[0;31m"
GREEN  		= "\033[0;32m"
ORANGE 		= "\033[0;33m"
BLUE   		= "\033[0;34m"
RESET  		= "\033[0m"

# Files
COMPOSE_FILE = ./src/docker-compose.yml

# Folders
DATA_FOLDER = ./src/data

# Containers
CONTAINERS = db wp nginx

# Network
NETWORK_NAME = asteinsNetwork

# Targets
.PHONY: all build up down clean logs status purge re

# Default target = restart
all: down build up

# Building the project
build:
	@echo $(BLUE)"\n Building astein's inception..."$(RESET)
	docker-compose -f $(COMPOSE_FILE) build

# Running the project
up:
	@echo $(GREEN)"\n Running astein's inception..."$(RESET)
	docker-compose -f $(COMPOSE_FILE) up -d

# Stopping the project
down:
	@echo $(RED)"\n Stopping astein's inception..."$(RESET)
	docker-compose -f $(COMPOSE_FILE) down
	docker rm $(CONTAINERS) || true #The || true is to ignore the error if the container is not found

# Cleaning the project
clean:
	@echo $(RED)"\n Cleaning astein's inception..."$(RESET)
	docker system prune -f
	docker volume prune -f

# Viewing the logs
logs:
	@echo $(BLUE)"\n Viewing logs for astein's inception..."$(RESET)
	docker-compose -f $(COMPOSE_FILE) logs -f

# Viewing the status
status:
	@echo $(BLUE)"\n Viewing status for astein's inception..."$(RESET)
	docker-compose -f $(COMPOSE_FILE) ps

# View the docker network
network:
	@echo $(BLUE)"\n Viewing network for astein's inception..."$(RESET)
	docker network inspect $(NETWORK_NAME)

# Purging all data after confirmation
purge: down
	@read -p "Are you sure you want to delete all data? [y/N] " confirm && \
	if [ "$$confirm" = "y" ]; then \
		echo $(RED)"\n Deleting all data..."$(RESET); \
		sudo rm -rf $(DATA_FOLDER); \
	else \
		echo $(ORANGE)"\n Aborted purging of data."$(RESET); \
	fi

# Rebuilding the project
re: purge build up