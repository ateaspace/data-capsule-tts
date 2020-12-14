#!/bin/bash

source ./SETUP.bash

package_version="mariadb-server-v10.5"

build_dir="build--$package_version"

git_clone_url="https://github.com/MariaDB/server.git"

if [ ! -d $package_version ] ; then
    echo "git clone $git_clone_url $package_version"
    git clone "$git_clone_url" "$package_version"
    
    cd $package_version \
	&& git checkout 10.5 \
	&& cd ..
fi

if [ ! -d "$build_dir" ] ; then
    echo "Making directory:"
    echo "  $build_dir"
    mkdir "$build_dir"
fi


cd "$build_dir" && \
    cmake ../$package_version \
	  -DCMAKE_INSTALL_PREFIX=$MARIADB_COMPLETE_INSTALLED/mysql

#	  -DDOWNLOAD_BOOST=1 -DWITH_BOOST=$MARIADB_COMPLETE_HOME/boost \
#      -DWITH_SSL=$MARIADB_COMPLETE_INSTALLED \
#      -DCURSES_LIBRARY=$MARIADB_COMPLETE_INSTALLED/lib/libncurses.a \
#      -DCURSES_INCLUDE_PATH=$MARIADB_COMPLETE_INSTALLED/include \
#      -DCMAKE_C_FLAGS="-I$MARIADB_COMPLETE_INSTALLED/include/ncurses -DHAVE_TERMCAP_H=1" \
#      -DCMAKE_C_FLAGS_RELWITHDEBINFO="-I$MARIADB_COMPLETE_INSTALLED/include/ncurses -O2 -g -DNDEBUG -DHAVE_TERMCAP_H=1" \



#cd "$build_dir" && \
#    cmake ../$package_version \
#       -DDOWNLOAD_BOOST=1 -DWITH_BOOST=$MARIADB_COMPLETE_HOME/boost \
#      -DWITH_SSL=$MARIADB_COMPLETE_INSTALLED \
#      -DCURSES_LIBRARY=$MARIADB_COMPLETE_INSTALLED/lib/libncurses.a \
#      -DCURSES_INCLUDE_PATH=$MARIADB_COMPLETE_INSTALLED/include \
#      -DCMAKE_C_FLAGS="-I$MARIADB_COMPLETE_INSTALLED/include/ncurses -DHAVE_TERMCAP_H=1" \
#      -DCMAKE_C_FLAGS_RELWITHDEBINFO="-I$MARIADB_COMPLETE_INSTALLED/include/ncurses -O2 -g -DNDEBUG -DHAVE_TERMCAP_H=1" \
#      -DCMAKE_INSTALL_PREFIX=$MARIADB_COMPLETE_INSTALLED/mysql

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
