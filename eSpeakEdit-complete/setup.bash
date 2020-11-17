#!/bin/bash

package_desc="eSpeak-NG and eSpeakEdit"

full_setup=`pwd`/${BASH_SOURCE}
fulldir=${full_setup%/*}
fulldir=${fulldir%/.}

ESPEAK_OS=`uname -s | tr '[A-Z]' '[a-z]'`

if [ "x$ESPEAK_HOME" = "x" ] ; then
  export ESPEAK_HOME=$fulldir
  export ESPEAK_HOME_INSTALLED=$ESPEAK_HOME/$ESPEAK_OS

  export PATH=$ESPEAK_HOME_INSTALLED/bin:$PATH

  if [ "x$LD_LIBRARY_PATH" = "x" ] ; then
    export LD_LIBRARY_PATH=$ESPEAK_HOME_INSTALLED/lib
  else
    export LD_LIBRARY_PATH=$ESPEAK_HOME_INSTALLED/lib:$LD_LIBRARY_PATH
  fi
  # Following used on a Mac
  if [ "x$DYLD_FALLBACK_LIBRARY_PATH" = "x" ] ; then
    export DYLD_FALLBACK_LIBRARY_PATH=$ESPEAK_HOME_INSTALLED/lib
  else
    export DYLD_FALLBACK_LIBRARY_PATH=$ESPEAK_HOME_INSTALLED/lib:$DYLD_FALLBACK_LIBRARY_PATH
  fi

  echo "+Your environment is now setup for $package_desc"
else
  echo "+Your environment is already setup for $package_desc"
fi
