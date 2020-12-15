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
  ./MYSQLD-SAFE-RUN-SERVER.sh

# Force change the root password timeout/expired to False or oppisite of what it is, if you cant login.

# Rerun with the RUN-SERVER boi


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


####
# MySQL Compilation
####

# Compiling up mysql instructions adapted from:
#   https://dev.mysql.com/doc/mysql-sourcebuild-excerpt/8.0/en/installing-source-distribution.html

./CASCADE-MAKE-MYSQL57.sh

####
# MySQL Init/Setup
####

# Look at _MYSQL-SETTINGS.bash to check the values specified there work for
# your computer's setup

# The following script:
#  i)   creates a data directory,
#  ii)  runs 'mysqld' with the --initialize flag on,
#         which in turn populates the data directory and terminates by printing out
#         the temporary 'root' password it has set
#  iii) tops up the data directory with SSL RSA based authentication init/setup

./MYSQLD-INIT.sh

###
# Running the MySQL server
###

./MYSQLD-RUN-SERVER.sh


####
# Connecting to the MySQL server
####

./MYSQL-RUN-CLIENT.sh








####

# In theory, you would then run the following command using the
# temporary password generated, however this produced an error
# message about the password having expired:

#  bin/mysqld_safe --user=davidb --password --port=6606 --datadir=`pwd`/data &

# So, have resorted to a less safe way of starting up the server: 

bin/mysqld --skip-grant-tables --user=davidb --port=6606 --datadir=`pwd`/data

# Then to connect via the command-line client

mysql --host=localhost --port=6606  --user=davidb --socket=/tmp/mysql.sock


