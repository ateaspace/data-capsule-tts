#!/bin/bash

# These should match up with the name of the archive
# e.g. for 'lib-example-2.5.32'; package=lib-example, version=-2.5.32
package=ninja-linux
version=""

# Gets and stores the path to this script, relative from the working directory
progname=$0

source ../cascade-make/lib/cascade-lib.bash "$@"

if [ ! -f "ninja" ] ; then
    unzip "${package}${version}.zip"
    print_info "Ninja extracted"
fi

if [ -f "ninja" ] ; then
    cp "ninja" "${ESPEAK_NG_HOME_INSTALLED}/bin"
fi

