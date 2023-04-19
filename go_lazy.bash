#!/bin/bash

#Bash script that automates testing of the sql files so don't have to
#drop, create the database for every change makes.
# ^^ added back the lost comment made by Saeed.

HOST='network.weirdcompany.net'
USERNAME='cobalt'
PASSWORD='qqqqqqqqq'

mysql -u $USERNAME -h $HOST -p$PASSWORD \
-e 'drop database if exists P_E_T;' \
-e 'create database P_E_T;' && \

cat p_e_t_schema.sql p_e_t_data.sql | mysql -u $USERNAME -h $HOST -p$PASSWORD P_E_T
mysql -u $USERNAME -h $HOST -p$PASSWORD -t P_E_T < query_test.sql
