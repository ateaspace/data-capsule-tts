
source ./SETUP.bash

package_version=m4-1.4.18

if [ ! -d $package_version ] ; then
    tar xvzf $package_version.tar.gz 
fi

cd $package_version \
    && ./configure --prefix=$MYSQL_COMPLETE_INSTALLED \
    && make \
    && make install


