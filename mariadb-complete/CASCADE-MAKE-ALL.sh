#!/bin/bash

cd packages && ./CASCADE-MAKE-PACKAGES-ALL.sh && cd ..

if [ $? = 0 ] ; then
    echo "****"
    echo "* Compiling up MySql v5.7"
    echo "****"
    ./CASCADE-MAKE-MYSQL57.sh
fi
