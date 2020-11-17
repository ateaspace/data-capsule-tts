#!/bin/bash

package=tiff
#version=-3.9.4
version=-4.0.10

progname=$0

source ../cascade-make/lib/cascade-lib.bash $*

prefix=$ESPEAK_HOME_INSTALLED

# Need to configure with jpeg-8 library and include directories,
# else configure of tiff will look for libjpeg.so.62 and end up compiling against that
# http://www.imagemagick.org/discourse-server/viewtopic.php?f=2&t=18566
opt_run_untar $force_untar $auto_untar $package $version
opt_run_configure $force_config $auto_config $package $version $prefix --with-jpeg-lib-dir=$ESPEAK_HOME_INSTALLED/lib --with-jpeg-include-dir=$ESPEAK_HOME_INSTALLED/include #--disable-shared

opt_run_make $compile $package $version
opt_run_make $install $package $version "install"
opt_run_make $clean $package $version "clean"
opt_run_make $distclean $package $version "distclean"

opt_run_tarclean $tarclean $package $version
