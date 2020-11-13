
source ./SETUP.bash

if [ ! -d ncurses-5.9 ] ; then
    echo "****"
    echo "* Untarring and applying patch"
    echo "****"

    tar xvzf ncurses-5.9.tar.gz \
	&& ./APPLY-PATCH.sh
fi

export CFLAGS="-fPIC"

cd ncurses-5.9 \
    && ./configure --prefix=$MYSQL_COMPLETE_INSTALLED --without-cxx-binding \
    && make \
    && make install


