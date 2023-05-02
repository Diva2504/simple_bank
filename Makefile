postgres:
	docker run --name simple -p 5432:5432 -e POSTGRES_USER=diva -e POSTGRES_PASSWORD=divasecret -d postgres:latest

createdb:
	 docker exec -it simple createdb --username=diva --owner=diva simple_bank

dropdb:
	docker exec -it simple dropdb --username=diva simple_bank


migrateup :
	 migrate -path db/migration -database "postgresql://diva:divasecret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown :
	 migrate -path db/migration -database "postgresql://diva:divasecret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlcinit :
	 docker run --rm -v ${PWD}:/src -w /src kjconroy/sqlc init

sqlcgenerate :
	docker run --rm -v "${CURDIR}":/src -w /src kjconroy/sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlcinit sqlcgenerate
