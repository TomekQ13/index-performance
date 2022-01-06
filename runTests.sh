#!/bin/bash

echo connected \
&& su postgres \
&& echo changed user \
&& pwd \
&& cd /var/run/postgresql \
&& ls -a \
&& psql -U postgres < /home/postgres/initial-tests.sql
