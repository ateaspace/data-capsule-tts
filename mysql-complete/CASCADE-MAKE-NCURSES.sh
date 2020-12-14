
source ./SETUP.bash

package_version=ncurses-5.9

if [ ! -f $package_version.tar.gz ] ; then
    wget "https://ftp.gnu.org/pub/gnu/ncurses/$package_version.tar.gz"
fi

if [ ! -d $package_version ] ; then
    echo "****"
    echo "* Untarring $package_version and applying patch"
    echo "****"

    tar xvzf $package_version.tar.gz \
	&& ./APPLY-NCURSES-PATCH.sh
fi

export CFLAGS="-fPIC"

cd $package_version \
    && ./configure --prefix=$MYSQL_COMPLETE_INSTALLED --without-cxx-binding --disable-shared \
    && make \
    && make install


