
source ./SETUP.sh

wget "https://www.openssl.org/source/openssl-1.1.1h.tar.gz"
tar xvzf openssl-1.1.1h.tar.gz
cd openssl-1.1.1h/
./config --prefix=$MYSQL_COMPLETE_INSTALLED
make
make install


wget "https://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz"
tar xvzf ncurses-5.9.tar.gz

# Apply patch to fix up MKlib_gen.sh within ncurses
./APPLY-PATCH.sh

cd ncurses-5.9/
./configure --prefix=$MYSQL_COMPLETE_INSTALLED --without-cxx-binding
make
make install

# To compile up mysql, need 'bison' on your PATH,
# however to compile up bison that needs 'm4' 


wget "https://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.gz"
tar xvzf m4-1.4.18.tar.gz
cd m4-1.4.18/
./configure --prefix=$MYSQL_COMPLETE_INSTALLED
make
make install
cd ..


wget "https://ftp.gnu.org/gnu/bison/bison-3.7.tar.gz"
tar xvzf bison-3.7.tar.gz
cd bison-3.7/
make
make install



# https://dev.mysql.com/doc/mysql-sourcebuild-excerpt/8.0/en/installing-source-distribution.html

git clone https://github.com/mysql/mysql-server.git mysql-server-v5.7

cd mysql-server-v5.7 \
  && git branch -r \
  && cd ..

cd mysql-server-v5.7 \
 && git checkout 5.7

mkdir bld \
  && cd bld/


cmake .. -DDOWNLOAD_BOOST=1 -DWITH_BOOST=$MYSQL_COMPLETE_HOME/boost \
  -DWITH_SSL=$MYSQL_COMPLETE_INSTALLED \
  -DCURSES_LIBRARY=$MYSQL_COMPLETE_INSTALLED/lib/libncurses.a \
  -DCURSES_INCLUDE_PATH=$MYSQL_COMPLETE_INSTALLED/include


make
make install DESTDIR="$MYSQL_COMPLETE_INSTALLED"
