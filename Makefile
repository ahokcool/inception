# Makefile for astein"s Inception

# Colors
RED    		= "\033[0;31m"
GREEN  		= "\033[0;32m"
ORANGE 		= "\033[0;33m"
BLUE   		= "\033[0;34m"
RESET  		= "\033[0m"

# Files
COMPOSE_FILE 	= ./src/docker-compose.yml
ENV_FILE 		= ./src/.env

# Folders
DATA_FOLDER 	= /home/astein/data/

# Containers
CONTAINERS 		= db wp nginx

# VOLUMES
VOLUMES 		= db-volume wp-volume

# Network
NETWORK_NAME 	= asteinsNetwork

# Targets
.PHONY: all build up down clean fclean re

# Default target = restart
all: down build up

# Building the project
build:
	@echo $(BLUE)"\n Building astein's inception..."$(RESET)
	mkdir -p $(DATA_FOLDER)/db-volume/
	mkdir -p $(DATA_FOLDER)/wp-volume/
	docker-compose --env-file $(ENV_FILE) -f $(COMPOSE_FILE) build

# Running the project
up:
	@echo $(GREEN)"\n Running astein's inception..."$(RESET)
	docker-compose --env-file $(ENV_FILE) -f $(COMPOSE_FILE) up -d

# Stopping the project
down:
	@echo $(RED)"\n Stopping astein's inception..."$(RESET)
	docker-compose -f $(COMPOSE_FILE) down
	
# Cleaning the project
clean:
	@echo $(RED)"\n Cleaning astein's inception..."$(RESET)
	@echo $(RED)"\n Deleting unused images..."$(RESET)
	@docker system prune -f
	@echo $(RED)"\n Deleting unused volumes..."$(RESET)
	@docker volume prune -f

# Full cleaning the project
fclean: down clean
	@echo "Are you sure you want to fully clean the project? [y/n]" && read ans && [ $${ans:-n} = y ]
	@echo $(RED)"\n Deleting inception volumes..."$(RESET)
	@docker volume rm $(VOLUMES) || true
	@echo $(RED)"\n Deleting inception networks..."$(RESET)
	@docker network rm $(NETWORK_NAME) || true
	@echo $(RED)"\n Deleting inception containers..."$(RESET)
	@docker rm $(CONTAINERS) || true
	@echo $(RED)"\n Deleting data folder..."$(RESET)
	@sudo rm -rf $(DATA_FOLDER)

# Rebuilding the project
re: fclean build up