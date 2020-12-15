#!/bin/bash


if [ "x$MYSQL_COMPLETE_INSTALLED" = "x" ] ; then
    source ./SETUP.bash
fi

source ./_MYSQL-SETTINGS.bash


echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" 
     
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" \
    | "$MYSQL_COMPLETE_INSTALLED/mysql/bin/mysql" \
	  --protocol=tcp \
	  --host=$MYSQL_HOST --port=$MYSQL_PORT \
	  --user=root --skip-password

#    --socket="$MYSQL_SOCK"


echo ""
echo "####"
echo "# Connect to the mysqld server by running:"
echo "#  ./MYSQL-RUN-CLIENT.sh"
echo "# Entering the password (above) that has just been set"
echo "####"
echo ""

