#!/bin/bash

package=bison
version=-2.4.3

progname=$0

source ../cascade-make/lib/cascade-lib.bash $*

prefix=$ESPEAK_HOME_INSTALLED

export CFLAGS="$CFLAGS -I$ESPEAK_HOME_INSTALLED/include"
export CPPFLAGS="$CPPFLAGS -I$ESPEAK_HOME_INSTALLED/include"
export CXXFLAGS="$CXXFLAGS -I$ESPEAK_HOME_INSTALLED/include"
export LDFLAGS="$LDFLAGS -L$ESPEAK_HOME_INSTALLED/lib -L/usr/lib/x86_64-linux-gnu/"
export LD_LIBRARY_PATH="$ESPEAK_HOME_INSTALLED/lib"

opt_run_untar $force_untar $auto_untar $package $version
opt_run_configure $force_config $auto_config $package $version $prefix

# Get the absolute paths to the original and patch files
bison_file=`( realpath "${package}${version}/lib/stdio.in.h" )`
patch_file=`( realpath "es-bison/lib/stdio.in.h.patch" )`

if [ ! -e "${package}${version}/completed.patching" ] ; then
    patch -u "${bison_file}" -i "${patch_file}" || exit 1
    touch "${package}${version}/completed.patching"
fi

opt_run_make $compile $package $version
opt_run_make $install $package $version "install"
opt_run_make $clean $package $version "clean"
opt_run_make $distclean $package $version "distclean"

opt_run_tarclean $tarclean $package $version
