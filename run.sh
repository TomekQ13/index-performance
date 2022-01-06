#!/bin/bash

git pull && docker-compose down 
docker-compose up -d && docker exec index-performance_postgres_1 bash /home/postgres/runTests.sh