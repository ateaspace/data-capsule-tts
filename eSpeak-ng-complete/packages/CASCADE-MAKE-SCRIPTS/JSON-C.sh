#!/bin/bash

# These should match up with the name of the archive
# e.g. for 'lib-example-2.5.32'; package=lib-example, version=-2.5.32
package=json-c-json-c
version=-0.15-20200726

# Gets and stores the path to this script, relative from the working directory
progname=$0

source ../cascade-make/lib/cascade-lib.bash "$@"

export CFLAGS="$CFLAGS -I$ESPEAK_NG_HOME_INSTALLED/include"
export CPPFLAGS="$CPPFLAGS -I$ESPEAK_NG_HOME_INSTALLED/include"
export CXXFLAGS="$CXXFLAGS -I$ESPEAK_NG_HOME_INSTALLED/include"
export LDFLAGS="$LDFLAGS -L$ESPEAK_NG_HOME_INSTALLED/lib"
export LD_LIBRARY_PATH="$ESPEAK_NG_HOME_INSTALLED/lib"

# $force_untar - set to/pass in '1' to always perform an extraction
# $auto_untar - set to '0' to disable automatic untarring
opt_run_untar $force_untar $auto_untar $package $version

opt_run_cmake $compile $package $version "json-c_build" "${ESPEAK_NG_HOME_INSTALLED}"
opt_run_cmake $install $package $version "json-c_build" $ESPEAK_NG_MAKE_JOBS "install"
opt_run_cmake $clean $package $version "json-c_build" $ESPEAK_NG_MAKE_JOBS "clean"
opt_run_cmake $distclean $package $version "json-c_build" $ESPEAK_NG_MAKE_JOBS "distclean"

# Set any of $compile, $install etc. to '0' to disable the corresponding make functions
#opt_run_make $compile $package $version $ESPEAK_NG_MAKE_JOBS
#opt_run_make $install $package $version $ESPEAK_NG_MAKE_JOBS "install"
#opt_run_make $clean $package $version $ESPEAK_NG_MAKE_JOBS "clean"
#opt_run_make $distclean $package $version $ESPEAK_NG_MAKE_JOBS "distclean"

opt_run_tarclean $tarclean $package $version
