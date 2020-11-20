#!/bin/bash

# These should match up with the name of the archive
# e.g. for 'lib-example-2.5.32'; package=lib-example, version=-2.5.32
package=json-c-json-c
version=-0.15-20200726

# Gets and stores the path to this script, relative from the working directory
progname=$0

source ../cascade-make/lib/cascade-lib.bash "$@"

export CFLAGS="$CFLAGS -I$ESPEAKEDIT_NG_HOME_INSTALLED/include"
export CPPFLAGS="$CPPFLAGS -I$ESPEAKEDIT_NG_HOME_INSTALLED/include"
export CXXFLAGS="$CXXFLAGS -I$ESPEAKEDIT_NG_HOME_INSTALLED/include"
export LDFLAGS="$LDFLAGS -L$ESPEAKEDIT_NG_HOME_INSTALLED/lib"
export LD_LIBRARY_PATH="$ESPEAKEDIT_NG_HOME_INSTALLED/lib"

# $force_untar - set to/pass in '1' to always perform an extraction
# $auto_untar - set to '0' to disable automatic untarring
opt_run_untar $force_untar $auto_untar $package $version

build_folder="json-c_build"
opt_run_cmake_configure $force_config $auto_config $package $version $build_folder "${ESPEAKEDIT_NG_HOME_INSTALLED}"

opt_run_make $compile $package $version $build_folder -j$ESPEAKEDIT_NG_MAKE_JOBS
opt_run_cmake $install $package $version $build_folder "install" -j$ESPEAKEDIT_NG_MAKE_JOBS
opt_run_cmake $clean $package $version $build_folder "clean" -j$ESPEAKEDIT_NG_MAKE_JOBS
opt_run_cmake $distclean $package $version $build_folder "distclean" -j$ESPEAKEDIT_NG_MAKE_JOBS

opt_run_tarclean $tarclean $package $version
