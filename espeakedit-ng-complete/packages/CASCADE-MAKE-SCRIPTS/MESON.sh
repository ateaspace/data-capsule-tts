#!/bin/bash

# These should match up with the name of the archive
# e.g. for 'lib-example-2.5.32'; package=lib-example, version=-2.5.32
package=meson
version=-0.56.0

# Gets and stores the path to this script, relative from the working directory
progname=$0

source ../cascade-make/lib/cascade-lib.bash "$@"

# $force_untar - set to/pass in '1' to always perform an extraction
# $auto_untar - set to '0' to disable automatic untarring
opt_run_untar $force_untar $auto_untar $package $version # Include an optional extension parameter here, e.g. '.tar.gz'

meson_install_path="${ESPEAKEDIT_NG_HOME_INSTALLED}/bin/${package}"
echo "Install: ${install}"

if [ $install == "1" ] && [ ! -e "${meson_install_path}" ] ; then
    cp -r "${package}${version}" "${ESPEAKEDIT_NG_HOME_INSTALLED}/bin/${package}/"
    mv "${meson_install_path}/meson.py" "${meson_install_path}/meson"
    export PATH="${meson_install_path}:${PATH}"
    print_info "Meson installed to ${meson_install_path}"
fi

opt_run_tarclean $tarclean $package $version