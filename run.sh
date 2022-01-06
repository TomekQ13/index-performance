#!/bin/bash

git pull && docker-compose down 
docker-compose up -d && cat < docker exec -t index-performance_postgres_1 bash <<EOF
    su postgres \
    && psql < /home/postgres/inital-tests.sql
EOF \
&& echo "success"