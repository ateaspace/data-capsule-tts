#!/bin/bash

# https://invisible-island.net/datafiles/release/ncurses.tar.gz

store_pwd="$PWD"

cd .. && source ./SETUP.bash
cd "$store_pwd"


package_version=ncurses-5.9

if [ ! -f $package_version.tar.gz ] ; then
    wget "https://ftp.gnu.org/pub/gnu/ncurses/$package_version.tar.gz"
fi

if [ ! -d $package_version ] ; then
    echo "****"
    echo "* Untarring $package_version and applying patch"
    echo "****"

    tar xvzf $package_version.tar.gz \
	&& ./APPLY-PATCH.sh
fi

export CFLAGS="-fPIC"

cd $package_version \
    && ./configure --prefix=$MARIADB_COMPLETE_INSTALLED --without-cxx-binding --disable-shared \
    && make \
    && make install


