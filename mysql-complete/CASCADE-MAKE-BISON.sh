
source ./SETUP.bash

package_version=bison-3.7

if [ ! -f $package_version.tar.gz ] ; then
    wget "https://ftp.gnu.org/gnu/bison/$package_version.tar.gz"
fi

if [ ! -d $package_version ] ; then
    tar xvzf $package_version.tar.gz 
fi

cd $package_version \
    && ./configure --prefix=$MYSQL_COMPLETE_INSTALLED \
    && make \
    && make install


