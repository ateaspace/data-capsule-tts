#!/bin/bash


if [ "x$MYSQL_COMPLETE_INSTALLED" = "x" ] ; then
    source ./SETUP.bash
fi

source ./_MYSQL-SETTINGS.bash


"$MYSQL_COMPLETE_INSTALLED/mysql/bin/mysqladmin" \
    -u root -p shutdown

