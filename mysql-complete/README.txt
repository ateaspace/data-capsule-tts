####
# Compiling
####

# MySQL documentation for compiling from source:
#   https://dev.mysql.com/doc/refman/8.0/en/source-installation-prerequisites.html
#   https://dev.mysql.com/doc/mysql-sourcebuild-excerpt/8.0/en/installing-source-distribution.html

# 'cmake' and 'gcc' are key for linux
#
# For building on Ubuntu (and quite likely other Linux distributions)
# the source code to other required command-line tools and libraries
# are provided here, and compile up through the scripts as detailed
# below

####
# TLDR:

# Review in a text edit, and adjust as needed:

emacs _MYSQL-SETTINGS.bash


# 1. Compiling

  ./CASCADE-MAKE-ALL.sh

# Then wait for a while, the mysql compliation in particular takes a while


# 2. Init mysql and get server running

  ./MYSQLD-INIT.sh
  ./MYSQLD-RUN-SERVER.sh


# 3. Connect to mysqld via the command-line

  ./MYSQL-RUN-CLIENT.sh
  

####

# In more detail ...

# Concerning the compilation of mysql from source:
#   You can trigger downloading 'boost' when mysql is configured with 'cmake'
#   But you need to manually install the following if not already present:
#     openssl, m4, bison, ncurses 
#   See above web page for minimum version numbers
#
#   Appropriate *.tar.gz files for the above have already been downloaded and
#   git commited into this folder for convenience.
#
#   The "cascade-make" scripts have been writting the run a wget command
#   to download the source code tar-ball if not present on the system, and
#   at the top of the script they use the variable 'package_version' to
#   simplify the process of working with a different version number of the
#   package source code, as/if needed.


source ./SETUP.bash

./CASCADE-MAKE-OPENSSL.sh

# Note: The following runs a patch file after untarring as part of the script
./CASCADE-MAKE-NURSES.sh

# To compile up mysql, need 'bison' on your PATH, however to compile up
# bison that needs 'm4'

./CASCADE-MAKE-M4.sh
./CASCADE-MAKE-BISON.sh


# Compiling up mysql instructions adapted from:
#   https://dev.mysql.com/doc/mysql-sourcebuild-excerpt/8.0/en/installing-source-distribution.html


# Don't believe the demands on the mysql are that great, and so focus
# in on a good-old fashioned stable version: v5.7

git clone https://github.com/mysql/mysql-server.git mysql-server-v5.7

# Optional: To look at the branches available:
cd mysql-server-v5.7 \
  && git branch -r \
  && cd ..

# To change to version v5.7

cd mysql-server-v5.7 \
 && git checkout 5.7

mkdir bld \
  && cd bld/

cmake .. -DDOWNLOAD_BOOST=1 -DWITH_BOOST=$MYSQL_COMPLETE_HOME/boost \
  -DWITH_SSL=$MYSQL_COMPLETE_INSTALLED \
  -DCURSES_LIBRARY=$MYSQL_COMPLETE_INSTALLED/lib/libncurses.a \
  -DCURSES_INCLUDE_PATH=$MYSQL_COMPLETE_INSTALLED/include \
  -DCMAKE_C_FLAGS="-I$MYSQL_COMPLETE_INSTALLED/include/ncurses -DHAVE_TERMCAP_H=1" \
  -DCMAKE_C_FLAGS_RELWITHDEBINFO="-I$MYSQL_COMPLETE_INSTALLED/include/ncurses -O2 -g -DNDEBUG -DHAVE_TERMCAP_H=1" \
  -DCMAKE_INSTALL_PREFIX=$MYSQL_COMPLETE_INSTALLED/mysql






cmake .. -DDOWNLOAD_BOOST=1 -DWITH_BOOST=$MYSQL_COMPLETE_HOME/boost \
  -DWITH_SSL=$MYSQL_COMPLETE_INSTALLED \
  -DCURSES_LIBRARY=$MYSQL_COMPLETE_INSTALLED/lib/libncurses.a \
  -DCURSES_INCLUDE_PATH=$MYSQL_COMPLETE_INSTALLED/include/ \
  -DWITH_EDITLINE=system \
  -DEDITLINE_INCLUDE_DIR=$MYSQL_COMPLETE_INSTALLED/include/ \
  -DEDITLINE_LIBRARY=$MYSQL_COMPLETE_INSTALLED/lib/libedit.a \
  -DCMAKE_C_FLAGS="-I$MYSQL_COMPLETE_INSTALLED/include/ -I$MYSQL_COMPLETE_INSTALLED/include/ncurses -I$MYSQL_COMPLETE_INSTALLED/include/editline" \
  -DCMAKE_CXX_FLAGS="-I$MYSQL_COMPLETE_INSTALLED/include/ -I$MYSQL_COMPLETE_INSTALLED/include/ncurses -I$MYSQL_COMPLETE_INSTALLED/include/editline" \
  -DCMAKE_LD_FLAGS="-L$MYSQL_COMPLETE_INSTALLED/lib" \
  -DCMAKE_INSTALL_PREFIX=$MYSQL_COMPLETE_INSTALLED/mysql

  -DCMAKE_C_FLAGS_RELWITHDEBINFO="-I$MYSQL_COMPLETE_INSTALLED/include/ncurses -DTERMCAP_H=1 -O2 -g -DNDEBUG" \


make
make install 


####
# Setup
####

cd "$MYSQL_COMPLETE_INSTALLED/mysql"

# The following is not currently used, could it be the implicit
# default name of what becomes the 'data' directory??

mkdir mysql-files

# Following needed if running mysqld as a different user
#   chown mysql:mysql mysql-files
#   chmod 750 mysql-files

# Initialize database tables in 'data' area on file-system
bin/mysqld --initialize --user=davidb --port=6606 --datadir=`pwd`/data

# => take not of temporary password it generates

# RSA init/setup/topup
bin/mysql_ssl_rsa_setup --datadir=`pwd`/data


####
# Running
####

# In theory, you would then run the following command using the
# temporary password generated, however this produced an error
# message about the password having expired:

#  bin/mysqld_safe --user=davidb --password --port=6606 --datadir=`pwd`/data &

# So, have resorted to a less safe way of starting up the server: 

bin/mysqld --skip-grant-tables --user=davidb --port=6606 --datadir=`pwd`/data

# Then to connect via the command-line client

mysql --host=localhost --port=6606  --user=davidb --socket=/tmp/mysql.sock


