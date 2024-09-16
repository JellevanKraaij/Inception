start: build
	docker compose -f ./srcs/docker-compose.yml up
start-d: build
	docker compose -f ./srcs/docker-compose.yml up -d
build:
	docker compose -f ./srcs/docker-compose.yml build
stop:
	docker compose -f ./srcs/docker-compose.yml stop
down:
	docker compose -f ./srcs/docker-compose.yml down
restart: stop start
re: clean start
ps:
	docker compose -f ./srcs/docker-compose.yml ps
logs:
	docker compose -f ./srcs/docker-compose.yml logs
live-logs:
	docker compose -f ./srcs/docker-compose.yml logs -f
clean: down
	docker stop $(shell docker ps -qa); docker rm $(shell docker ps -qa); docker rmi -f $(shell docker images -qa); docker volume rm $(shell docker volume ls -q); docker network rm $(shell docker network ls -q); docker system prune --all --volumes --force

.PHONY: start start-d build stop down restart re ps logs live-logs clean