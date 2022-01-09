#!/bin/bash
docker-compose down 
git pull \
&& docker-compose up --build -d \
&& sleep 5s
# preparing the setup
rm times.txt
echo "Preparing configuration..." \
&& time docker exec index-performance_postgres_1 bash /home/postgres/runPrepareSetup.sh
# running the insert without an index
echo "Running inserts without any index..." \
&& for i in {1..10} 
do
    echo "Running iteration $i"
    # times the insert, redirects the stderr output to stream 1, removes unnecessary lines and removes newline character between iteration n and time and saves to a file
    { echo "Iteration $i " ; { time docker exec index-performance_postgres_1 bash /home/postgres/runInsert.sh ; } 2>&1 | sed -n 3p ; } | tr "\n" " " >> times.txt
    # append a newline at the end of the iterations
    echo "" >> times.txt
done 