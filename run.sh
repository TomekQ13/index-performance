#!/bin/bash

git pull 
docker-compose down 
docker-compose up --build -d
sleep 5s
docker exec index-performance_postgres_1 bash /home/postgres/runTests.sh