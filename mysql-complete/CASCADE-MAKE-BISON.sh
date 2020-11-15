
source ./SETUP.bash

package_version=bison-3.7

if [ ! -d $package_version ] ; then
    tar xvzf $package_version.tar.gz 
fi

cd $package_version \
    && ./configure --prefix=$MYSQL_COMPLETE_INSTALLED \
    && make \
    && make install


