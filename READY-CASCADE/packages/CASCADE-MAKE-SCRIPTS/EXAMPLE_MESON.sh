#!/bin/bash

# These should match up with the name of the archive
# e.g. for 'lib-example-2.5.32'; package=lib-example, version=-2.5.32
package=
version=-

# Gets and stores the path to this script, relative from the working directory
progname=$0

source ../cascade-make/lib/cascade-lib.bash "$@"

prefix=$EXAMPLE_HOME_INSTALLED

export CFLAGS="$CFLAGS -I$prefix/include"
export CPPFLAGS="$CPPFLAGS -I$prefix/include"
export CXXFLAGS="$CXXFLAGS -I$prefix/include"
export LDFLAGS="$LDFLAGS -L$prefix/lib"
export LD_LIBRARY_PATH="$prefix/lib"

# $force_untar - set to/pass in '1' to always perform an extraction
# $auto_untar - set to '0' to disable automatic untarring
opt_run_untar $force_untar $auto_untar $package $version ".tar.xz"

build_subdir="_build"

# $force_config - set to '1' to always configure the package
# $auto_config - set to '0' to disable automatic configuration
opt_run_meson_configure $force_config $auto_config $package $version $build_subdir $prefix

# Set any of $compile, $install etc. to '0' to disable the corresponding make functions
opt_run_ninja $compile $package $version $build_subdir
opt_run_ninja $install $package $version $build_subdir "install"

opt_run_tarclean $tarclean $package $version

