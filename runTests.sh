#!/bin/bash

echo connected \
&& su postgres \
&& echo changed user \
&& pwd \
&& cd /var/run/postgresql \
&& ls \
&& psql
