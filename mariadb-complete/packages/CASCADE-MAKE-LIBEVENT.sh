#!/bin/bash

store_pwd="$PWD"

cd .. && source ./SETUP.bash
cd "$store_pwd"


package=libevent
version=-2.1.12-stable
package_version="$package$version"

download_url="https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/$package_version.tar.gz"


if [ ! -f $package_version.tar.gz ] ; then
    wget "$download_url"
fi

if [ ! -d $package_version ] ; then
    tar xvzf $package_version.tar.gz 
fi

export CFLAGS="-I$MARIADB_COMPLETE_INSTALLED/include $CFLAGS"
export CXXFLAGS="-I$MARIADB_COMPLETE_INSTALLED/include $CXXFLAGS"
export LDFLAGS="-L$MARIADB_COMPLETE_INSTALLED/lib $LDFLAGS"

cd $package_version \
    && ./configure --prefix=$MARIADB_COMPLETE_INSTALLED \
    && make \
    && make install


