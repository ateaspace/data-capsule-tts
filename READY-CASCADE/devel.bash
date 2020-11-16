#!/bin/bash

if [ -d cascade-make ] ; then
  source cascade-make/lib/cascade-lib.bash $*
fi

if [ -z $EXAMPLE_HOME ] ; then
  source setup.bash
fi

if [ -z $PKG_CONFIG_PATH ] ; then
    export PKG_CONFIG_PATH="$EXAMPLE_HOME_INSTALLED/lib/pkgconfig:$PKG_CONFIG_PATH"
else
    export PKG_CONFIG_PATH="$EXAMPLE_HOME_INSTALLED/lib/pkgconfig"
fi


