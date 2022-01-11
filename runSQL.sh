#!/bin/bash

su postgres \
&& psql -U postgres < $1