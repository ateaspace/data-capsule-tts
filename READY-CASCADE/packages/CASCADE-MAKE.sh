#!/bin/bash

source ../cascade-make/lib/cascade-lib.bash $*

for d in EXAMPLE_NORMAL EXAMPLE_AUTOGEN ; do
    echo "    Running CASCADE-MAKE-SCRIPTS/$d.sh"

    ./CASCADE-MAKE-SCRIPTS/$d.sh $*

    if [ $? != 0 ] ; then
	echo "Error encountered running CASCADE-MAKE/$d.sh"
	exit 1
    fi
done
