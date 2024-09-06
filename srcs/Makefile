all :
	@sudo mkdir -p /home/dboire/data/mysql
	@sudo mkdir -p /home/dboire/data/webwordpress
	@sudo docker-compose -f docker_compose.yml up


down:
	@-docker compose -f docker_compose.yml stop
	@docker system prune -a -f
	@docker network prune -f
	@sudo rm -rf /home/dboire/data/mysql
	@sudo rm -rf /home/dboire/data/webwordpress
	@sudo docker rmi $$(docker images -a -q) -f
	@docker volume ls -q | xargs -r docker volume rm