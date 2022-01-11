#!/bin/bash
iterationCount=10
timesLogFile=times.txt

docker-compose down 
git pull \
&& docker-compose up --build -d \
&& sleep 5s
# preparing the setup
rm times.txt
echo "Preparing configuration..." \
&& time docker exec index-performance_postgres_1 bash /home/postgres/runSQL.sh /home/postgres/sql/prepareSetup.sql
# running the insert without an index
echo "Running inserts without any index..." \
&& i=0 \
&& while [ "$i" < "$iterationCount" ]
do
    # times the insert, redirects the stderr output to stream 1, removes unnecessary lines and removes newline character between iteration n and time and saves to a file
    { echo "No indexes - Iteration $i " ; { time docker exec index-performance_postgres_1 bash /home/postgres/runSQL.sh /home/postgres/sql/insert.sql ; } 2>&1 | sed -n 3p ; } | tr "\n" " " >> $timesLogFile
    # append a newline at the end of the iterations
    echo "" >> $timesLogFile
    i=$(($i + 1))
done \
&& time docker exec index-performance_postgres_1 bash /home/postgres/runSQL.sh /home/postgres/sql/createIndexId.sql \
&&i=0 \
&& while [ "$i" < "$iterationCount" ]
do
    # times the insert, redirects the stderr output to stream 1, removes unnecessary lines and removes newline character between iteration n and time and saves to a file
    { echo "ID index - Iteration $i " ; { time docker exec index-performance_postgres_1 bash /home/postgres/runSQL.sh /home/postgres/sql/insert.sql ; } 2>&1 | sed -n 3p ; } | tr "\n" " " >> $timesLogFile
    # append a newline at the end of the iterations
    echo "" >> $timesLogFile
done