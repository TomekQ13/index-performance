#!/bin/bash

git pull && docker-compose down 
docker-compose up -d && docker exec -t index-performance_postgres_1 bash <<END
    su postgres
    psql < /home/postgres/inital-tests.sql
END && \
echo success