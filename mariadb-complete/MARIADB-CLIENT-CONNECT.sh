#!/bin/bash

#mariadb --host=localhost --port=$MARIADB_PORT --user=$USER

mariadb --host=localhost --port=$MARIADB_PORT --user=$USER --socket=/tmp/mysqld-davidb.sock mysql

