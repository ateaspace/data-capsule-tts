#!/bin/bash

source ../cascade-make/lib/cascade-lib.bash $*

for d in M4 AUTOCONF AUTOMAKE LIBTOOL PKG-CONFIG ALSA PCAUDIO ESPEAK-NG ; do
    echo "    Running CASCADE-MAKE-SCRIPTS/$d.sh"

    ./CASCADE-MAKE-SCRIPTS/$d.sh $*

    if [ $? != 0 ] ; then
	echo "Error encountered running CASCADE-MAKE/$d.sh"
	exit 1
    fi
done
