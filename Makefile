.PHONY: *

pretty:
	npx prettier --write .
	shfmt -w .

install:
	sudo ./setup-nginx-docker.sh

update:
	git pull
	./update-mls.sh

front:
	npm run --prefix ./next dev

run:
	docker compose up

build:
	docker compose build

exec:
	docker exec -it nginx_server bash

dev: build run

css:
	npx tailwindcss -i ./html/input.css -o ./html/output.css --watch
