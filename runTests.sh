#!/bin/bash

echo connected \
&& su postgres \
&& echo changed user \
&& pwd \
&& psql < /home/postgres/initial-tests.sql
