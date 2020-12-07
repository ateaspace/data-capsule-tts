package_version=ncurses-5.9
cur_dir="$(pwd)"
install_dir="$cur_dir/packages"

if [ ! -d $install_dir ] 
then
    mkdir $install_dir
    echo "Created packages directory | $install_dir"
fi

if [ ! -f $package_version.tar.gz ]
then
    wget "https://ftp.gnu.org/pub/gnu/ncurses/$package_version.tar.gz"
fi

if [ ! -d $package_version ]
then
    echo "****"
    echo "* Untarring $package_version and applying patch"
    echo "****"

    tar xvzf $package_version.tar.gz --directory $install_dir

    echo "Applying patch: MKlib_gen.sh.patch"

    cd $install_dir/ncurses-5.9/ncurses/base \
    && patch < $install_dir/ncurse MKlib_gen.sh.patch

fi

export CFLAGS="-fPIC"

cd $package_version \
    && ./configure --prefix=$install_dir --without-cxx-binding --disable-shared \
    && make \
    && make install


