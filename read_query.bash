#!/bin/bash

HOST='network.weirdcompany.net'
USERNAME='cobalt'
PASSWORD='qqqqqqqqq'

mysql -u $USERNAME -h $HOST -p$PASSWORD \
-e 'use P_E_T;' && \
mysql -u $USERNAME -h $HOST -p$PASSWORD -t P_E_T < query_test.sql
