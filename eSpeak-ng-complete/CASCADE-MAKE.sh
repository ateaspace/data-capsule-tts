#!/bin/bash

source ./devel.bash

for d in packages ; do
    echo "Running $d/CASCADE-MAKE.sh"

    (cd $d ; ./CASCADE-MAKE.sh $*)

    if [ $? != 0 ] ; then
	echo "Error encountered running $d/CASCADE-MAKE.sh"
	exit 1
    fi
done

