####
# Compiling
####

# MySQL documentation for compiling from source:
#   https://dev.mysql.com/doc/refman/8.0/en/source-installation-prerequisites.html
#   https://dev.mysql.com/doc/mysql-sourcebuild-excerpt/8.0/en/installing-source-distribution.html

# 'cmake' and 'gcc' are key for linux

# TLDR:
#   You can trigger downloading 'boost' when mysql is configured with 'cmake'
#   But you need to manually install the following if not already present:
#     openssl, m4, bison, ncurses 
#   See above web page for minimum version numbers
#
#   Appropriate *.tar.gz files for the above have already been downloaded and
#   git commited into this folder for convenience, so the 'wget' lines can be
#   skipped
#   


source ./SETUP.bash

# wget "https://www.openssl.org/source/openssl-1.1.1h.tar.gz"
tar xvzf openssl-1.1.1h.tar.gz
cd openssl-1.1.1h/
./config --prefix=$MYSQL_COMPLETE_INSTALLED
make
make install


# wget "https://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz"
tar xvzf ncurses-5.9.tar.gz

# Apply patch to fix up MKlib_gen.sh within ncurses
./APPLY-PATCH.sh

cd ncurses-5.9/
./configure --prefix=$MYSQL_COMPLETE_INSTALLED --without-cxx-binding
make
make install

# To compile up mysql, need 'bison' on your PATH,
# however to compile up bison that needs 'm4' 

# wget "https://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.gz"
tar xvzf m4-1.4.18.tar.gz
cd m4-1.4.18/
./configure --prefix=$MYSQL_COMPLETE_INSTALLED
make
make install
cd ..


# wget "https://ftp.gnu.org/gnu/bison/bison-3.7.tar.gz"
tar xvzf bison-3.7.tar.gz
cd bison-3.7/
make
make install



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


