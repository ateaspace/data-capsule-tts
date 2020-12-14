#!/bin/bash



store_pwd="$PWD"

cd .. && source ./SETUP.bash
cd "$store_pwd"


package=ncurses
version=-6.2
package_version=$package$version

# Site currently places the latest stable version as the following generic URL
# At the tim of writing this was 6.2
download_url="https://invisible-island.net/datafiles/release/ncurses.tar.gz"


if [ ! -f $package_version.tar.gz ] ; then
#    wget "https://ftp.gnu.org/pub/gnu/ncurses/$package_version.tar.gz"
    wget --no-check-certificate -O ncurses-6.2.tar.gz "$download_url"
fi

if [ ! -d $package_version ] ; then
#    echo "****"
#    echo "* Untarring $package_version and applying patch"
#    echo "****"

    tar xvzf $package_version.tar.gz
    
#	&& ./APPLY-PATCH.sh
fi

export CFLAGS="-fPIC"

#    && ./configure --prefix=$MARIADB_COMPLETE_INSTALLED --without-cxx-binding --disable-shared \

		   
cd $package_version \
    && ./configure --prefix=$MARIADB_COMPLETE_INSTALLED --disable-shared \
    && make \
    && make install


