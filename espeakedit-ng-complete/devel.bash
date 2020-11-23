#!/bin/bash

if [ -d cascade-make ] ; then
  source cascade-make/lib/cascade-lib.bash $*
fi

if [ -z $ESPEAKEDIT_NG_HOME ] ; then
  source setup.bash
fi

if [ -z $PKG_CONFIG_PATH ] ; then
    export PKG_CONFIG_PATH="$ESPEAKEDIT_NG_HOME_INSTALLED/lib/pkgconfig:$PKG_CONFIG_PATH"
else
    export PKG_CONFIG_PATH="$ESPEAKEDIT_NG_HOME_INSTALLED/lib/pkgconfig"
fi

# Determines the default number of jobs that each make process should run in parallel
if [ -z $ESPEAKEDIT_NG_MAKE_JOBS ] ; then
  export ESPEAKEDIT_NG_MAKE_JOBS=7
fi

# Source local pip executables
export PATH="${PATH}:$HOME/.local/bin"
