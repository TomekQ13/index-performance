#!/bin/bash

su postgres \
&& psql -U postgres < /home/postgres/sql/insert.sql