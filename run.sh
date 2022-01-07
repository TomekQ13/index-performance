#!/bin/bash
docker-compose down 
git pull \
&& docker-compose up --build -d \
&& sleep 5s \
&& time docker exec index-performance_postgres_1 bash /home/postgres/runTests.sh