#!/bin/bash

# Use our custom espeak with Maori support
package=espeak-ng
version=-1.50

# Gets the path to this script, relative from the working directory
progname=$0

source ../cascade-make/lib/cascade-lib.bash $*

prefix=$ESPEAKEDIT_NG_HOME_INSTALLED

export CFLAGS="$CFLAGS -I$ESPEAKEDIT_NG_HOME_INSTALLED/include"
export CPPFLAGS="$CPPFLAGS -I$ESPEAKEDIT_NG_HOME_INSTALLED/include"
export CXXFLAGS="$CXXFLAGS -I$ESPEAKEDIT_NG_HOME_INSTALLED/include"
export LDFLAGS="$LDFLAGS -L$ESPEAKEDIT_NG_HOME_INSTALLED/lib"
export LD_LIBRARY_PATH="$ESPEAKEDIT_NG_HOME_INSTALLED/lib"

opt_run_untar $force_untar $auto_untar $package $version

# $force_autogen - set to '1' to always perform auto-generation
# $auto_autogen - set to '0' to disable automatic autogen
opt_run_autogen $force_autogen $auto_autogen $package $version

opt_run_configure $force_config $auto_config $package $version $prefix #\
#  --disable-shared # Use this if other software is having issues linking against this library

# eSpeak language building does not support parallelism. Hence no -j flags here
opt_run_make $compile $package $version
opt_run_make $install $package $version "install"
opt_run_make $clean $package $version "clean"
opt_run_make $distclean $package $version "distclean"

opt_run_tarclean $tarclean $package $version
