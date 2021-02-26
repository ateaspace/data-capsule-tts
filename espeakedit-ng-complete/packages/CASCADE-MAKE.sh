#!/bin/bash

source ../cascade-make/lib/cascade-lib.bash $*

# Gobject-introspection | for d in MAKE CMAKE M4 AUTOCONF AUTOMAKE LIBTOOL PKG-CONFIG ZLIB GETTEXT OPENSSL LIBFFI PYTHON NINJA MESON JPEG LIBPNG LIBTIFF FREETYPE GPERF FONTCONFIG BISON FLEX GOBJECT-INTROSPECTION GLIB XORG-MACROS LIBXTRANS XORGPROTO LIBXCBPROTO LIBXAU LIBXCB X11 PIXMAN CAIRO PANGO ATK LIBSNDFILE LIBATOMIC_OPS SPEEXDSP JSON-C PULSEAUDIO PCAUDIO ESPEAK-NG PORTAUDIO SOX ; do
for d in MAKE CMAKE M4 AUTOCONF AUTOMAKE LIBTOOL ZLIB OPENSSL LIBFFI PYTHON2 PYTHON PKG-CONFIG GETTEXT NINJA MESON LIBSNDFILE LIBATOMIC_OPS SPEEXDSP JSON-C PULSEAUDIO PCAUDIO PORTAUDIO SOX JPEG LIBPNG LIBTIFF FREETYPE GPERF FONTCONFIG GLIB XORG-MACROS LIBXTRANS XORGPROTO LIBXCBPROTO LIBXAU LIBXCB X11 PIXMAN CAIRO PANGO LIBXML ITSTOOL SHARED-MIME-INFO GDK-PIXBUF ATK BISON LIBXKB LIBXRENDER LIBXEXT LIBXRANDR LIBXFIXES LIBXI EXPAT DBUS LIBXTST AT-SPI2-CORE AT-SPI2-ATK LIBEPOXY LIBOGG LIBVORBIS GTK+ LIBCANBERRA WXWIDGETS ESPEAK-NG ESPEAKEDIT ; do
#for d in MAKE CMAKE M4 AUTOCONF AUTOMAKE LIBTOOL ZLIB OPENSSL LIBFFI PYTHON2 PYTHON PKG-CONFIG NINJA MESON GLIB JPEG LIBPNG LIBTIFF LIBXML ITSTOOL ; do # SHARED-MIME-INFO GDK-PIXBUF ; do
    print_info "Running CASCADE-MAKE-SCRIPTS/$d.sh"

    . ./CASCADE-MAKE-SCRIPTS/$d.sh $*

    if [ $? != 0 ] ; then
	    print_error "Error encountered running CASCADE-MAKE/$d.sh"
	exit 1
    fi
done
