#!/bin/bash

su postgres \
&& psql -U postgres < /home/postgres/initial-tests.sql
