docker-compose up -d
docker exec -it index-performance_postgres_1 bash < su postgres < psql < /home/postgres/inital-tests.sql