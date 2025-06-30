postgres:
	sudo docker-compose up -d

dblogs:
	sudo docker logs postgresDB

createdb:
	sudo docker exec -it postgresDB createdb --username=postgres --password --owner=postgres simple_bank

dropdb:
	sudo docker exec -it postgresDB dropdb --username=postgres --password simple_bank

shelldb:
	sudo docker exec -it postgresDB psql -U postgres --password -d simple_bank

# Migrations
migrateversion:
	sudo docker run --rm -v ./db/migrations/:/migrations \
	--network host migrate/migrate \
	-source file:///migrations \
	-database postgres://postgres:secret@localhost:5432/simple_bank?sslmode=disable \
	version

migrateup:
	@if [ -z "$(n)" ]; then \
		echo "Running all migrations..."; \
		sudo docker run --rm -v ./db/migrations/:/migrations \
		--network host migrate/migrate \
		-source file:///migrations \
		-database postgres://postgres:secret@localhost:5432/simple_bank?sslmode=disable \
		up; \
	else \
		echo "Running $(n) up migrations..."; \
		sudo docker run --rm -v ./db/migrations/:/migrations \
		--network host migrate/migrate \
		-source file:///migrations \
		-database postgres://postgres:secret@localhost:5432/simple_bank?sslmode=disable \
		up $(n); \
	fi

migratedown:
	@if [ -z "$(n)" ]; then \
		echo "Running all down migrations..."; \
		sudo docker run --rm -v ./db/migrations/:/migrations \
		--network host migrate/migrate \
		-source file:///migrations \
		-database postgres://postgres:secret@localhost:5432/simple_bank?sslmode=disable \
		down -all; \
	else \
		echo "Running $(n) down migrations..."; \
		sudo docker run --rm -v ./db/migrations/:/migrations \
		--network host migrate/migrate \
		-source file:///migrations \
		-database postgres://postgres:secret@localhost:5432/simple_bank?sslmode=disable \
		down $(n); \
	fi

sqlc:
	sudo docker run --rm -v ./:/src -w /src sqlc/sqlc generate

test:
	go test -v -cover ./...

.PHONY: createdb dropdb selldb migrateup migratedown sqlc test
