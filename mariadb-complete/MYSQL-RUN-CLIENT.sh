#!/bin/bash


if [ "x$MYSQL_COMPLETE_INSTALLED" = "x" ] ; then
    source ./SETUP.bash
fi

source ./_MYSQL-SETTINGS.bash


"$MYSQL_COMPLETE_INSTALLED/mysql/bin/mysql" \
    --host=$MYSQL_HOST --user=$MYSQL_USER --port=$MYSQL_PORT \
    --socket="$MYSQL_SOCK"
