#!/bin/bash

store_pwd="$PWD"

cd .. && source ./SETUP.bash
cd "$store_pwd"

package_version=openssl-1.1.1h

if [ ! -f $package_version.tar.gz ] ; then
    wget "https://www.openssl.org/source/$package_version.tar.gz"
fi


if [ ! -d $package_version ] ; then
    tar xvzf $package_version.tar.gz 
fi

cd $package_version \
    && ./config --prefix=$MARIADB_COMPLETE_INSTALLED \
    && make \
    && make install


