all :
	sudo docker compose -f docker_compose.yml up --build


down:
	@-docker compose -f docker_compose.yml stop
	@docker system prune -a -f
	@docker volume ls -q | xargs -r docker volume rm
	@docker network prune -f