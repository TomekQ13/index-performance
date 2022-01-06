#!/bin/bash

git pull && docker-compose down 
docker-compose up -d && docker exec index-performance_postgres_1 bash <<"EOF"
echo connected \
&& su postgres \
&& psql < /home/postgres/inital-tests.sql \
&& exit
EOF