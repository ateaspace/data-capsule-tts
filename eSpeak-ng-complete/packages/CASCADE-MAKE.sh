#!/bin/bash

source ../cascade-make/lib/cascade-lib.bash $*

for d in MAKE CMAKE M4 AUTOCONF AUTOMAKE LIBTOOL PKG-CONFIG LIBSNDFILE LIBATOMIC_OPS SPEEXDSP JSON-C GETTEXT PULSEAUDIO PCAUDIO SONIC ESPEAK-NG ; do
    print_info "Running CASCADE-MAKE-SCRIPTS/$d.sh"

    ./CASCADE-MAKE-SCRIPTS/$d.sh $*

    if [ $? != 0 ] ; then
	print_error "Error encountered running CASCADE-MAKE/$d.sh"
	exit 1
    fi
done
