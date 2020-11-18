#!/bin/bash

if [ -d cascade-make ] ; then
  source cascade-make/lib/cascade-lib.bash $*
fi

if [ -z $ESPEAK_NG_HOME ] ; then
  source setup.bash
fi

if [ -z $PKG_CONFIG_PATH ] ; then
    export PKG_CONFIG_PATH="$ESPEAK_NG_HOME_INSTALLED/lib/pkgconfig:$PKG_CONFIG_PATH"
else
    export PKG_CONFIG_PATH="$ESPEAK_NG_HOME_INSTALLED/lib/pkgconfig"
fi

# Determines the default number of jobs that each make process should run in parallel
if [ -z $ESPEAK_NG_MAKE_JOBS ] ; then
  export ESPEAK_NG_MAKE_JOBS=7
fi
