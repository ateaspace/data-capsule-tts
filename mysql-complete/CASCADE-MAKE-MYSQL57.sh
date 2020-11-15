#!/bin/bash

source ./SETUP.bash

package_version="mysql-server-v5.7"

if [ ! -d $package_version ] ; then
    echo "git clone https://github.com/mysql/mysql-server.git $package_version"
    git clone https://github.com/mysql/mysql-server.git $package_version
    
    # To change to version v5.7

    cd $package_version \
	&& git checkout 5.7 \
	&& cd ..
fi

if [ ! -d $package_version/bld ] ; then
    echo "Making directory:"
    echo "  $package_version/bld"
    mkdir "$package_version/bld"
fi


cd "$package_version/bld" && \
    cmake .. -DDOWNLOAD_BOOST=1 -DWITH_BOOST=$MYSQL_COMPLETE_HOME/boost \
      -DWITH_SSL=$MYSQL_COMPLETE_INSTALLED \
      -DCURSES_LIBRARY=$MYSQL_COMPLETE_INSTALLED/lib/libncurses.a \
      -DCURSES_INCLUDE_PATH=$MYSQL_COMPLETE_INSTALLED/include \
      -DCMAKE_C_FLAGS="-I$MYSQL_COMPLETE_INSTALLED/include/ncurses -DHAVE_TERMCAP_H=1" \
      -DCMAKE_C_FLAGS_RELWITHDEBINFO="-I$MYSQL_COMPLETE_INSTALLED/include/ncurses -O2 -g -DNDEBUG -DHAVE_TERMCAP_H=1" \
      -DCMAKE_INSTALL_PREFIX=$MYSQL_COMPLETE_INSTALLED/mysql

if [ $? != "0" ] ; then
    echo "****" >&2
    echo "* Error: failed to run 'cmake'" >&2
    echo "****" >&2
    exit 1
fi


make

if [ $? != "0" ] ; then
    echo "****" >&2
    echo "* Error: failed to run 'make'" >&2
    echo "****" >&2
    exit 1
fi

make install

if [ $? != "0" ] ; then
    echo "****" >&2
    echo "* Error: failed to run 'make install'" >&2
    echo "****" >&2
    exit 1
fi
