### express Docker compose commands  :

.PHONY: compose-up
compose-up:
	docker compose up -d

# .PHONY: docker-run-nodejs-multi-instances
# docker-run-nodejs-multi-instances:
# 	@echo "Starting Node.js instance 1..."

# 	docker run \
#         	--name express-node-app-container-1 \
# 	        --publish 4001:4001 \
# 	        --env-file ./.env \
# 		-d \
# 	        node-app-node-app:latest

# 	@echo "Starting Node.js instance 2..."
	
# 	docker run \
# 	        --name express-node-app-container-2 \
# 		--publish 4002:4002 \
# 	        --env-file ./.env \
# 		-d \
# 	        node-app-node-app:latest

# 	@echo "Starting Node.js instance 3..."
	
# 	docker run \
# 	        --name express-node-app-container-3 \
# 		--publish 4003:4003 \
# 	        --env-file ./.env \
# 		-d \
# 		node-app-node-app:latest




.PHONY: compose-down
compose-down:
	docker compose down	


.PHONY: docker-logs-express
docker-logs-express:
	docker logs express-node-app-container


.PHONY: compose-up-build
compose-up-build:
	docker compose up -d --build


.PHONY: compose-up-dev-mode
compose-up-dev-mode:
	docker compose -f docker-compose.yml -f docker-compose-dev.yml \
	up -d


.PHONY: compose-up-dev-mode-build
compose-up-dev-mode-build:
	docker compose -f docker-compose.yml -f docker-compose-dev.yml \
	up -d --build

.PHONY: compose-build-dev-mode
compose-build-dev-mode: 
	docker compose -f docker-compose.yml -f docker-compose-dev.yml build

.PHONY: compose-down-dev-mode
compose-down-dev-mode:
	docker compose -f docker-compose.yml -f docker-compose-dev.yml down


.PHONY: compose-up-prod-mode
compose-up-prod-mode:
	docker compose -f docker-compose.yml -f docker-compose-prod.yml up -d


.PHONY: compose-down-prod-mode
compose-down-prod-mode:
	docker compose -f docker-compose.yml -f docker-compose-prod.yml down



.PHONY: compose-up-prod-mode-build
compose-up-prod-mode-build:
	docker compose -f docker-compose.yml -f docker-compose-prod.yml \
	up -d --build

.PHONY: compose-build-prod-mode
compose-build-prod-mode:
	docker compose -f docker-compose.yml -f docker-compose-prod.yml build

.PHONY: compose-push-prod-mode
compose-push-prod-mode:
	docker compose -f docker-compose.yml -f docker-compose-prod.yml push

.PHONY: remove-all-containers
remove-all-containers:
	docker rm $(docker ps -aq)


.PHONY: run-watchtower-container
run-watchtower-container:
	docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock \
	-e WATCHTOWER_POLL_INTERVAL=30  containrrr/watchtower \
	express-node-app-container express-node-app-container-1 \
	express-node-app-container-2 express-node-app-container-3


.PHONY: compose-terminal-express
compose-terminal-express:
	docker exec -it express-node-app-container sh
