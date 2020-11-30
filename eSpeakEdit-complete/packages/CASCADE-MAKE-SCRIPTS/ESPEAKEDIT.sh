#!/bin/bash

package=es-espeakedit
version=-1.48.03

progname=$0

source ../cascade-make/lib/cascade-lib.bash $*

prefix=$ESPEAK_HOME_INSTALLED

export CFLAGS="$CFLAGS -I$ESPEAK_HOME_INSTALLED/include"
export CPPFLAGS="$CPPFLAGS -I$ESPEAK_HOME_INSTALLED/include"
export CXXFLAGS="$CXXFLAGS -I$ESPEAK_HOME_INSTALLED/include"
export LDFLAGS="$LDFLAGS -L$ESPEAK_HOME_INSTALLED/lib"
export LD_LIBRARY_PATH="$ESPEAK_HOME_INSTALLED/lib"

opt_run_untar $force_untar $auto_untar $package $version

# Get the absolute paths to the original and patch files
#edit_path=`( realpath "${package}${version}/" )`
#patch_file=`( realpath "es-espeakedit/espeakedit.patch" )`

#if [ ! -e "${package}${version}/completed.patching" ] ; then
#    patch -ruN -d "${edit_path}" < "${patch_file}" || exit 1
#    touch "${package}${version}/completed.patching"
#fi
# opt_run_configure $force_config $auto_config $package $version $prefix

if [ -d "${package}${version}/src" ] ; then
    ( cd "${package}${version}/src" ; \
        make )

    if [ $? != 0 ] ; then
        echo "    Could not make espeakedit"
        exit 1
    fi
fi

if [ -e "${package}${version}/src/espeakedit" ] ; then
    cp "${package}${version}/src/espeakedit" "$ESPEAK_HOME_INSTALLED/bin"
fi

# opt_run_make $compile $package $version
# opt_run_make $install $package $version "install"
# opt_run_make $clean $package $version "clean"
# opt_run_make $distclean $package $version "distclean"

 opt_run_tarclean $tarclean $package $version
