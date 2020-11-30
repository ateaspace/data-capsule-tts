#!/bin/bash

package=pkg-config
version=-0.24

progname=$0

source ../cascade-make/lib/cascade-lib.bash $*

prefix=$ESPEAK_HOME_INSTALLED

export CFLAGS="$CFLAGS -I$ESPEAK_HOME_INSTALLED/include"
export CXXFLAGS="$CXXFLAGS -I$ESPEAK_HOME_INSTALLED/include"
export LDFLAGS="$LDFLAGS -L$ESPEAK_HOME_INSTALLED/lib"
export DYLD_LIBRARY_PATH=

opt_run_untar $force_untar $auto_untar $package $version

# On Mac: if there's an error about
# "#error GNU libiconv not in use but included iconv.h is from libiconv"
# then prepend --with-libiconv before --with-internal-glib for darwin too

# On a CentOS build encountered an error related to dtrace 
# (potentially related to static/dynamic libraries and whether the '-dev' header
#  files are included)
# Solution is to disable dtrace with 
#    --disable-dtrace
# In 'glib' in gnomelib-ext  a similar error occurred relating to 'systemtap'.  If this was
# to occur here, then presumably the related fix of '--disable-systemtap'
# would suffice.
# Potentially related link to all this (from the glib:CASCADE-MAKE comment)
#    https://gitlab.gnome.org/GNOME/glib/issues/653

if [ "x$PACKAGE_OS" = "xdarwin" ] ; then
    LIBS=-lintl opt_run_configure $force_config $auto_config $package $version $prefix \
	--with-internal-glib # --disable-shared
else
    opt_run_configure $force_config $auto_config $package $version $prefix \
		      --with-libiconv --with-internal-glib --disable-dtrace # --disable-shared
fi

opt_run_make $compile $package $version
opt_run_make $install $package $version "install"
opt_run_make $clean $package $version "clean"
opt_run_make $distclean $package $version "distclean"

opt_run_tarclean $tarclean $package $version
