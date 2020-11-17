#!/bin/bash

package=perl
version=-5.18.4

progname=$0

source ../cascade-make/lib/cascade-lib.bash $*

prefix=$ESPEAK_HOME_INSTALLED

export CFLAGS="$CFLAGS -I$ESPEAK_HOME_INSTALLED/include"
export CPPFLAGS="$CPPFLAGS -I$ESPEAK_HOME_INSTALLED/include"
export CXXFLAGS="$CXXFLAGS -I$ESPEAK_HOME_INSTALLED/include"
export LDFLAGS="$LDFLAGS -L$ESPEAK_HOME_INSTALLED/lib"
export LD_LIBRARY_PATH="$ESPEAK_HOME_INSTALLED/lib"

opt_run_tarclean $tarclean $package $version
opt_run_untar $force_untar $auto_untar $package $version

# Get the path to the libm files, because this verion of perl cannot find them on most modern systems
#echo "Please enter the path to your libm libraries"
#read -p "libm path:" libm_path

pushd "${package}${version}"
pwd
./Configure -des -Dprefix="${prefix}" # -Dlibs='-lm'"
popd

opt_run_make $compile $package $version
opt_run_make $install $package $version "install"
opt_run_make $clean $package $version "clean"
opt_run_make $distclean $package $version "distclean"
