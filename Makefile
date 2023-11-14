# bundle install
bundle: 
	docker compose run web bundle install 

# build
build:
	docker compose build

# rails db 起動
run: 
	docker compose up -d 

# rails down
down:
	docker compose down web

# rails generate
generate:
	docker compose run web rails g $(filter-out $@,$(MAKECMDGOALS))

# db migrate
migrate:
	docker compose run web rails db:migrate

# rails console
console:
	docker compose run web rails c

# docker logs
logs:
	docker compose logs -f

# 'make generate'に続く引数をキャッチするための特別なターゲット
%:
	@:

