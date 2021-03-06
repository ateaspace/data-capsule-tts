#!/bin/bash

# Use our custom espeak with Maori support
package=mi-espeak-ng
version=-1.50

# Gets the path to this script, relative from the working directory
progname=$0

source ../cascade-make/lib/cascade-lib.bash $*

prefix=$ESPEAK_NG_HOME_INSTALLED

export CFLAGS="$CFLAGS -I$ESPEAK_NG_HOME_INSTALLED/include"
export CPPFLAGS="$CPPFLAGS -I$ESPEAK_NG_HOME_INSTALLED/include"
export CXXFLAGS="$CXXFLAGS -I$ESPEAK_NG_HOME_INSTALLED/include"
export LDFLAGS="$LDFLAGS -L$ESPEAK_NG_HOME_INSTALLED/lib"
export LD_LIBRARY_PATH="$ESPEAK_NG_HOME_INSTALLED/lib"

# Temporarily disable untarring while we work on adding the Maori language
# opt_run_untar $force_untar $auto_untar $package $version

# $force_autogen - set to '1' to always perform auto-generation
# $auto_autogen - set to '0' to disable automatic autogen
opt_run_autogen $force_autogen $auto_autogen $package $version

opt_run_configure $force_config $auto_config $package $version $prefix #\
#  --disable-shared # Use this if other software is having issues linking against this library

opt_run_make $compile $package $version
opt_run_make $install $package $version "install"
opt_run_make $clean $package $version "clean"
opt_run_make $distclean $package $version "distclean"

# Temporarily disable tarclean while we work on adding the Maori language
# opt_run_tarclean $tarclean $package $version
