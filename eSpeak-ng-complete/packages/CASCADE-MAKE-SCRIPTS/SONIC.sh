#!/bin/bash

# These should match up with the name of the archive
# e.g. for 'lib-example-2.5.32'; package=lib-example, version=-2.5.32
package=sonic
version=-67ed70f

# Gets and stores the path to this script, relative from the working directory
progname=$0

source ../cascade-make/lib/cascade-lib.bash "$@"

prefix=$ESPEAK_NG_HOME_INSTALLED

export CFLAGS="$CFLAGS -I$prefix/include"
export CPPFLAGS="$CPPFLAGS -I$prefix/include"
export CXXFLAGS="$CXXFLAGS -I$prefix/include"
export LDFLAGS="$LDFLAGS -L$prefix/lib"
export LD_LIBRARY_PATH="$prefix/lib"

# $force_untar - set to/pass in '1' to always perform an extraction
# $auto_untar - set to '0' to disable automatic untarring
opt_run_untar $force_untar $auto_untar $package $version ".tar.xz"

# Set any of $compile, $install etc. to '0' to disable the corresponding make functions
opt_run_make $compile $package $version -j$ESPEAK_NG_MAKE_JOBS
opt_run_make $install $package $version "install" -j$ESPEAK_NG_MAKE_JOBS PREFIX=$prefix
opt_run_make $clean $package $version "clean" -j$ESPEAK_NG_MAKE_JOBS
opt_run_make $distclean $package $version "distclean" -j$ESPEAK_NG_MAKE_JOBS

opt_run_tarclean $tarclean $package $version
