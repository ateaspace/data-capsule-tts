
source ./SETUP.bash

if [ ! -d libedit-20191231-3.1 ] ; then
  tar xvzf libedit-20191231-3.1.tar.gz
fi


export CFLAGS="-fPIC -I$MYSQL_COMPLETE_INSTALLED/include -I$MYSQL_COMPLETE_INSTALLED/include/ncurses"

export LDFLAGS="-L$MYSQL_COMPLETE_INSTALLED/lib"

cd libedit-20191231-3.1 \
    && ./configure --prefix=$MYSQL_COMPLETE_INSTALLED \
    && make \
    && make install


