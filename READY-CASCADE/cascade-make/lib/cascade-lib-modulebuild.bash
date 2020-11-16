#!/bin/bash

opt_modulebuild_configure()
{
  local force_config=$1; shift
  local auto_config=$1; shift
  local package=$1; shift
  local version=$1; shift
  local prefix=$1; shift
  local perlversion=$1; shift

  local buildfile_path="$package$version/Build"
  if [ -e $buildfile_path ] ; then
    force_config=0
  fi

  if [ $force_config = "1" ] ; then
    echo "[pushd $package$version]"
    ( cd $package$version ; \
      perl -I "$prefix/lib/perl/$perlversion" Build.PL --install_base "$prefix" --install_path lib="$prefix/lib/perl/$perlversion" --install_path arch="$prefix/lib/perl/$perlversion" $@)
    if [ $? != 0 ] ; then
        echo "      Error encountered running *configure* stage of $progname"
        exit 1
    fi
    echo "[popd]"
  else
    if [ $auto_config = "1" ] ; then
      echo "Found top-level for ${progname%.*} => no need to run perl configure"
    fi
  fi
}


opt_modulebuild_make()
{
  local type=$1; shift
  local package=$1; shift
  local version=$1; shift
  local opt_target=""

  if [ ! -z "$1" ] ; then
    opt_target=$1; shift
  fi

  if [ $type = "1" ] ; then
    ( cd $package$version ; \
      ./Build $opt_target $@)

    if [ $? != 0 ] ; then
        echo "      Error encountered running *Build $target* stage of $progname"
        exit 1
    fi
  fi
}

