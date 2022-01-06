#!/bin/bash

git pull && docker-compose down 
docker-compose up -d && docker exec -t index-performance_postgres_1 bash << 'EOF'
    su postgres \
    && psql < /home/postgres/inital-tests.sql \
    && exit