#!/bin/bash

if [ ! -d mysql-server-v5.7 ] ; then
    echo "git clone https://github.com/mysql/mysql-server.git mysql-server-v5.7"
    git clone https://github.com/mysql/mysql-server.git mysql-server-v5.7
    
    # To change to version v5.7

    cd mysql-server-v5.7 \
	&& git checkout 5.7
fi

if [ ! -d mysql-server-v5.7/bld ] ; then
    echo "Making directory:"
    echo "  mysql-server-v5.7/bld"
fi

#mkdir bld \
#    && cd bld/

cd "mysql-server-v5.7/bld" && \
    cmake .. -DDOWNLOAD_BOOST=1 -DWITH_BOOST=$MYSQL_COMPLETE_HOME/boost \
      -DWITH_SSL=$MYSQL_COMPLETE_INSTALLED \
      -DCURSES_LIBRARY=$MYSQL_COMPLETE_INSTALLED/lib/libncurses.a \
      -DCURSES_INCLUDE_PATH=$MYSQL_COMPLETE_INSTALLED/include \
      -DCMAKE_C_FLAGS="-I$MYSQL_COMPLETE_INSTALLED/include/ncurses -DHAVE_TERMCAP_H=1" \
      -DCMAKE_C_FLAGS_RELWITHDEBINFO="-I$MYSQL_COMPLETE_INSTALLED/include/ncurses -O2 -g -DNDEBUG -DHAVE_TERMCAP_H=1" \
      -DCMAKE_INSTALL_PREFIX=$MYSQL_COMPLETE_INSTALLED/mysql

cd "mysql-server-v5.7/bld" && \
    make && \
    make install


