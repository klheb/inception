all:
	@mkdir ~/data; \
	mkdir ~/data/wordpress; \
	mkdir ~/data/mariadb; \
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

re:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls);\
	docker network rm $$(docker network ls -q);\
	sudo rm -rf ~/data

.PHONY: all down re clean
