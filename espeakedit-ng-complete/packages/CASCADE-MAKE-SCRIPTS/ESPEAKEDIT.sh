#!/bin/bash

# These should match up with the name of the archive
# e.g. for 'lib-example-2.5.32'; package=lib-example, version=-2.5.32
package=espeak-ng
version=-espeakedit

espeak_package=espeak-ng
espeak_version=-1.50

# Gets the path to this script, relative from the working directory
progname=$0

source ../cascade-make/lib/cascade-lib.bash $*

prefix=$ESPEAKEDIT_NG_HOME_INSTALLED
x64_libs="$prefix/lib/x86_64-linux-gnu"

export CFLAGS="$CFLAGS -I$prefix/include -Wno-narrowing"
export CPPFLAGS="$CPPFLAGS -I$prefix/include -Wno-narrowing"
export CXXFLAGS="$CXXFLAGS -I$prefix/include -Wno-narrowing"
export LDFLAGS="$LDFLAGS -L$prefix/lib -L$x64_libs"
export LD_LIBRARY_PATH="$prefix/lib:$x64_libs"

# $force_untar - set to/pass in '1' to always perform an extraction
# $auto_untar - set to '0' to disable automatic untarring
opt_run_untar $force_untar $auto_untar $package $version ".tar.xz"

cp -rn espeak-data "$package$version/"

# $force_autogen - set to '1' to always perform auto-generation
# $auto_autogen - set to '0' to disable automatic autogen
opt_run_autogen $force_autogen $auto_autogen $package $version

opt_run_configure $force_config $auto_config $package $version $prefix #\
#  --disable-shared # Use this if other software is having issues linking against this library

opt_run_make $compile $package $version -j$ESPEAKEDIT_NG_MAKE_JOBS
opt_run_make $install $package $version "install" -j$ESPEAKEDIT_NG_MAKE_JOBS
opt_run_make $clean $package $version "clean" -j$ESPEAKEDIT_NG_MAKE_JOBS
opt_run_make $distclean $package $version "distclean" -j$ESPEAKEDIT_NG_MAKE_JOBS

opt_run_tarclean $tarclean $package $version
