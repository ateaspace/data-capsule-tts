#!/bin/bash

mariadbd-safe --port=$MARIADB_PORT --datadir=$MARIADB_DATADIR --socket=/tmp/mysqld-$USER.sock
#mariadbd --port=$MARIADB_PORT --datadir=$MARIADB_DATADIR --socket=/tmp/mysqld-$USER.sock

# --bind-address=localhost
# --bind-address=tanekaha
