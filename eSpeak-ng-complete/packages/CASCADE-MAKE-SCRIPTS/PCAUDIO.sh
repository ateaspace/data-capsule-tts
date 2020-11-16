#!/bin/bash

# These should match up with the name of the archive
# e.g. for 'lib-example-2.5.32'; package=lib-example, version=-2.5.32
package=pcaudiolib
version=-1.1

# Gets the path to this script, relative from the working directory
progname=$0

source ../cascade-make/lib/cascade-lib.bash $*

prefix=$ESPEAK_NG_HOME_INSTALLED

export CFLAGS="$CFLAGS -I$ESPEAK_NG_HOME_INSTALLED/include"
export CPPFLAGS="$CPPFLAGS -I$ESPEAK_NG_HOME_INSTALLED/include"
export CXXFLAGS="$CXXFLAGS -I$ESPEAK_NG_HOME_INSTALLED/include"
export LDFLAGS="$LDFLAGS -L$ESPEAK_NG_HOME_INSTALLED/lib"
export LD_LIBRARY_PATH="$ESPEAK_NG_HOME_INSTALLED/lib"

# $force_untar - set to/pass in '1' to always perform an extraction
# $auto_untar - set to '0' to disable automatic untarring
opt_run_untar $force_untar $auto_untar $package $version # Include an optional extension parameter here, e.g. '.tar.gz'

# $force_autogen - set to '1' to always perform auto-generation
# $auto_autogen - set to '0' to disable automatic autogen
opt_run_autogen $force_autogen $auto_autogen $package $version

opt_run_configure $force_config $auto_config $package $version $prefix #\
#  --disable-shared # Use this if other software is having issues linking against this library

opt_run_make $compile $package $version
opt_run_make $install $package $version "install"
opt_run_make $clean $package $version "clean"
opt_run_make $distclean $package $version "distclean"

opt_run_tarclean $tarclean $package $version
