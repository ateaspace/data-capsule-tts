
source ./SETUP.bash

package_version=m4-1.4.18

if [ ! -f $package_version.tar.gz ] ; then
    wget "https://ftp.gnu.org/gnu/m4/$package_version.tar.gz"
fi

if [ ! -d $package_version ] ; then
    tar xvzf $package_version.tar.gz 
fi

cd $package_version \
    && ./configure --prefix=$MYSQL_COMPLETE_INSTALLED \
    && make \
    && make install


