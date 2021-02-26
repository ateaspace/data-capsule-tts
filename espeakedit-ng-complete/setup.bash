#!/bin/bash

package_desc="espeakedit_ng"

full_setup=`pwd`/${BASH_SOURCE}
fulldir=${full_setup%/*}
fulldir=${fulldir%/.}

PACKAGE_OS=`uname -s | tr '[A-Z]' '[a-z]'`

if [ "x$ESPEAKEDIT_NG_HOME" = "x" ] ; then
  export ESPEAKEDIT_NG_HOME=$fulldir
  export ESPEAKEDIT_NG_HOME_INSTALLED=$ESPEAKEDIT_NG_HOME/$PACKAGE_OS

  export PATH=$ESPEAKEDIT_NG_HOME_INSTALLED/bin:$PATH

  if [ "x$LD_LIBRARY_PATH" = "x" ] ; then
    export LD_LIBRARY_PATH=$ESPEAKEDIT_NG_HOME_INSTALLED/lib
  else
    export LD_LIBRARY_PATH=$ESPEAKEDIT_NG_HOME_INSTALLED/lib:$LD_LIBRARY_PATH
  fi
  # Following used on a Mac
  if [ "x$DYLD_FALLBACK_LIBRARY_PATH" = "x" ] ; then
    export DYLD_FALLBACK_LIBRARY_PATH=$ESPEAKEDIT_NG_HOME_INSTALLED/lib
  else
    export DYLD_FALLBACK_LIBRARY_PATH=$ESPEAKEDIT_NG_HOME_INSTALLED/lib:$DYLD_FALLBACK_LIBRARY_PATH
  fi

  echo "Your environment is now setup for $package_desc"
else
  echo "Your environment is already setup for $package_desc"
fi
