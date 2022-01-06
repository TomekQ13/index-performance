#!/bin/bash

echo connected \
&& su postgres \
&& psql < /home/postgres/initial-tests.sql \
&& exit \