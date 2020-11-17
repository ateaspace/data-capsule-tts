#!/bin/bash

package=libx11-libX11
version=-1.6.0

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

if [ -d "${package}${version}" ] && [ ! -f "${package}${version}/configure" ]
then
    pushd "${package}${version}/"
    ./autogen.sh || exit 1
    popd
fi

opt_run_configure $force_config $auto_config $package $version $prefix

opt_run_make $compile $package $version
opt_run_make $install $package $version "install"
opt_run_make $clean $package $version "clean"
opt_run_make $distclean $package $version "distclean"
