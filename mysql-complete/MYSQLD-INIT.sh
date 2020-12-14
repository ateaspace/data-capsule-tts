#!/bin/bash

# https://dev.mysql.com/doc/refman/5.7/en/data-directory-initialization.html


if [ "x$MYSQL_COMPLETE_INSTALLED" = "x" ] ; then
    source ./SETUP.bash
fi

source ./_MYSQL-SETTINGS.bash


if [ ! -d "$MYSQL_COMPLETE_INSTALLED/mysql" ] ; then
    echo "Directory:" >&2
    echo "  $MYSQL_COMPLETE_INSTALLED/mysql" >&2
    echo "does not exist." >&2
    echo "" >&2
    echo "Have your compiled and installed the mysql source code?" >&2
    echo "This can be done by running:" >&2
    echo "  ./CASCADE-MADE-PACKAGES-ALL.sh" >&2
    echo "  ./CASCADE-MADE-MYSQL.sh" >&2
    exit 1
fi


if [ -d "$MYSQL_DATA" ] ; then
    echo  "****"
    echo  "* Data directory:"
    echo "*    $MYSQL_DATA"
    echo "*  Assuming mysql has already been initialized"
    echo  "****"
    exit 0
fi
    

echo ""
echo "Creating directory:"
echo "  $MYSQL_DATA"
mkdir "$MYSQL_DATA"


echo ""
echo "To run a production version of mysql, you will most likely also want to change"
echo "this directory's group/ownwership settings."
echo ""
echo "For the 'mysql' user, for example:"
echo "  chown mysql:mysql data"
echo "  chmod 750 data"
echo ""


"$MYSQL_COMPLETE_INSTALLED/mysql/bin/mysqld" \
    --initialize --user=$MYSQL_USER--port=$MYSQL_PORT \
    --datadir="$MYSQL_DATA"

# => take not of temporary password it generates

echo ""
echo "****"
echo "* Please take note of the temporary password generated above"
echo "****"
echo ""

# RSA init/setup/topup
"$MYSQL_COMPLETE_INSTALLED/mysql/bin/mysql_ssl_rsa_setup" --datadir="$MYSQL_DATA"
