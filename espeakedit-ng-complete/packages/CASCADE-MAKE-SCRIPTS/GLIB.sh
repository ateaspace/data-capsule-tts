#!/bin/bash

# These should match up with the name of the archive
# e.g. for 'lib-example-2.5.32'; package=lib-example, version=-2.5.32
package=glib
version=-2.67.0

# Gets and stores the path to this script, relative from the working directory
progname=$0

source ../cascade-make/lib/cascade-lib.bash "$@"

prefix=$ESPEAKEDIT_NG_HOME_INSTALLED

export CFLAGS="$CFLAGS -I$ESPEAKEDIT_NG_HOME_INSTALLED/include"
export CPPFLAGS="$CPPFLAGS -I$ESPEAKEDIT_NG_HOME_INSTALLED/include"
export CXXFLAGS="$CXXFLAGS -I$ESPEAKEDIT_NG_HOME_INSTALLED/include"
export LDFLAGS="$LDFLAGS -L$ESPEAKEDIT_NG_HOME_INSTALLED/lib"
export LD_LIBRARY_PATH="$ESPEAKEDIT_NG_HOME_INSTALLED/lib"

# So that we can build glib before pkg-config
# export ZLIB_LIBS="-L${ESPEAKEDIT_NG_HOME_INSTALLED}/lib -L${ESPEAKEDIT_NG_HOME_INSTALLED}/lib -lz"
# export ZLIB_CFLAGS="-I${ESPEAKEDIT_NG_HOME_INSTALLED}/include"

# $force_untar - set to/pass in '1' to always perform an extraction
# $auto_untar - set to '0' to disable automatic untarring
opt_run_untar $force_untar $auto_untar $package $version ".tar.xz"

build_subdir="_build"

# $force_config - set to '1' to always configure the package
# $auto_config - set to '0' to disable automatic configuration
opt_run_meson_configure $force_config $auto_config $package $version $build_subdir $prefix #"-Diconv=external"

# Set any of $compile, $install etc. to '0' to disable the corresponding make functions
opt_run_ninja $compile $package $version $build_subdir
opt_run_ninja $install $package $version $build_subdir "install"

opt_run_tarclean $tarclean $package $version
