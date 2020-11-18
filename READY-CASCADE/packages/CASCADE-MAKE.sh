#!/bin/bash

source ../cascade-make/lib/cascade-lib.bash $*

for d in EXAMPLE_NORMAL EXAMPLE_AUTOGEN ; do
    print_info "Running CASCADE-MAKE-SCRIPTS/$d.sh"

    ./CASCADE-MAKE-SCRIPTS/$d.sh $*

    if [ $? != 0 ] ; then
	print_error "Error encountered running CASCADE-MAKE/$d.sh"
	exit 1
    fi
done
