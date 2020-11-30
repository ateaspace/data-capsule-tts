#!/bin/bash

source ../cascade-make/lib/cascade-lib.bash $*

for d in MAKE M4 AUTOCONF AUTOMAKE LIBTOOL PKG-CONFIG AUTOCONF-ARCHIVE ZLIB LIBPNG JPEG FREETYPE IMLIB2 GIBLIB XORG-MACROS LIBXTRANS XORGPROTO LIBXCBPROTO LIBXAU LIBXCB X11 LIBXFIXES LIBXCOMPOSITE SCROT ; do
    print_info "Running CASCADE-MAKE-SCRIPTS/$d.sh"

    ./CASCADE-MAKE-SCRIPTS/$d.sh $*

    if [ $? != 0 ] ; then
	print_error "Error encountered running CASCADE-MAKE/$d.sh"
	exit 1
    fi
done
