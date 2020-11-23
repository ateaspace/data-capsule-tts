#!/bin/bash

# These should match up with the name of the archive
# e.g. for 'lib-example-2.5.32'; package=lib-example, version=-2.5.32
package=meson
version=-0.56.0

# Gets and stores the path to this script, relative from the working directory
progname=$0

source ../cascade-make/lib/cascade-lib.bash "$@"

if [ ! -x "$(command -v meson)" ] ; then
    pip3 install --user meson
    source export PATH="${PATH}:$HOME/.local/bin"
fi