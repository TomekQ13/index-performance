#!/bin/bash
docker-compose down 
git pull \
&& docker-compose up --build -d \
&& sleep 5s
# preparing the setup
echo "Preparing configuration..." \
&& time docker exec index-performance_postgres_1 bash /home/postgres/runPrepareSetup.sh
# running the insert without an index
echo "Running inserts without any index..." \
&& for i in {1..10} 
do
    echo "Running iteration $i"
    { echo "Iteration $i " ; { time docker exec index-performance_postgres_1 bash /home/postgres/runInsert.sh ; } 2>&1 | sed -n 3p ; } >> times.txt
done 