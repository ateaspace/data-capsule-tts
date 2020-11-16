#!/bin/bash

# Make sure that the OS component of the install directory is set
if test -z $PACKAGE_OS ; then
    PACKAGE_OS=`uname -s | tr '[A-Z]' '[a-z]'`
    # check for running bash under Cygwin
    if test "`echo $PACKAGE_OS | sed 's/cygwin//'`" != "$PACKAGE_OS" ;
    then
        PACKAGE_OS=windows
    fi
    # check for running bash under MinGW/MSys
    if test "`echo $PACKAGE_OS | sed 's/mingw//'`" != "$PACKAGE_OS" ;
    then
        PACKAGE_OS=windows
    fi
    if test ! -z $crossOS ; then
        # Override derived value with value explicitly provided in crossOS
        PACKAGE_OS=$crossOS
    fi

    echo "PACKAGE_OS was not set.  Setting it to '$PACKAGE_OS'"
    export PACKAGE_OS
fi

if test $# -gt "0" ; then
    if test -z ${1##GEXT*} ; then

    ext=$1 ; shift
    reldir=$1 ; shift

    eval package_home=`echo \\$$ext`
    if test -z "$package_home" ; then
        if test -f $reldir/setup.bash ; then
            echo "Environment variable $ext for package extension not set"
            echo "Sourcing $reldir/setup.bash"
            source $reldir/setup.bash
      
            eval package_home=`echo \\$$ext`
        else
            echo "Did not detect $reldir/setup.bash, Skipping"
        fi
        fi
    fi
fi

# Extracts a tar package
run_untar()
{
    local package=$1
    local version=$2
    local ext=$3

    tar_args="";

    if [ $ext = ".tar.gz" ] ; then
        tar_args="xvzf"
    elif [ $ext = ".tgz" ] ; then
        tar_args="xvzf"
    elif [ $ext = ".tar.bz2" ] ; then
        tar_args="xvjf"
    elif [ $ext = ".tar.bz" ] ; then
        tar_args="xvjf"
    elif [ $ext = ".tar.xz" ] ; then
        tar_args="xvJf"
    elif [ $ext = ".tar" ] ; then
        tar_args="xvf"
    else 
        echo "Warning: Unrecognized extension: $ext"
        echo "Assuming tarred, gzipped file"
        tar_args="xvjf"
    fi


    echo tar $tar_args $package$version$ext 
    tar $tar_args $package$version$ext

    if [ $? != 0 ] ; then
        echo "      Error encountered running *untar* stage of $progname"
        exit 1
    fi
}

# Attempts to remove the folder generated when extracting a tar
opt_run_tarclean()
{
    local type=$1
    local package=$2
    local version=$3

    if [ $type = "1" ] ; then

        local dir=$package$version
        if [ -d $dir ] ; then
        echo /bin/rm -rf $dir
        /bin/rm -rf $dir

        if [ $? != 0 ] ; then
            echo "    Error encountered running *tarclean* stage of $progname"
            exit 1
        fi
        else 
        echo "Unable to find directory $dir"
        fi
    fi
}

# Compresses the provided files/directories into an archive, assuming they are relative from the package home directory
# $1 - The distribution to package for (simply used for naming purposes)
toplevel_make_dist()
{
    local distos=$1 ; shift
    local dirname=`basename $package_home` 

    # This was "#*"
    local checklist="$@"
    local distlist=""

    for d in $checklist ; do
        if [ -e $d ] ; then
        distlist="$distlist $dirname/$d"
        fi
    done

    pushd ..

    tar cvzf $dirname-$distos.tar.gz $distlist

    popd
}

# Creates a default 'release' distribution archive
# $1 - the distro to release for (simply used for naming purposes)
default_toplevel_make_dist()
{
    local distos=$1 ; shift
    local dirname=`basename $package_home` 

    local checklist="setup.bash $PACKAGE_OS $*"
    toplevel_make_dist $distos $checklist
}

# Makes a minimal release
toplevel_make_minimal()
{
    local distos=$1 ; shift
    local dirname=`basename $package_home` 

    local checklist="setup.bash $PACKAGE_OS/lib $PACKAGE_OS/bin $PACKAGE_OS/include $*"
    local distlist=""

    for d in $checklist ; do
        if [ -e $d ] ; then
            distlist="$distlist $dirname/$d"
        fi
    done

    pushd ..

    echo "@@@@ LIST: $distlist"

    local tarname="gnome-lib-minimal"

    if [ $distos = "linux" ] ; then
        tarname="$tarname-linux"

        arch=`uname -m`
        if [[ "$arch" == *"64"* ]]; then
            tarname="$tarname-x64";
        fi      
    elif [ $distos = "darwin" ] ; then
        if [ $OSTYPE != "darwin9.0" ] ; then
            tarname="$tarname-darwin-Lion-intel"
        else
            tarname="$tarname-darwin-intel"
        fi
    fi

    # copy all the files except $OS/lib/pkconfig/.fixed-prefix.awk across. The absence of that last file will ensure that gnome-lib-minimal
    # does not point to the path where it was compiled when compiling wvware against a gnome-lib-minimal in a GS2 located elsewhere
    # http://www.gnu.org/software/tar/manual/html_node/exclude.html and http://www.tldp.org/LDP/abs/html/comparison-ops.html
    # Also need to remove all the *.la files generated (in the OS/lib folder), as happens on darwin, since these contain fixed paths
    tar cvzf $tarname.tar.gz --exclude='.fixed-prefix.awk' --exclude='*.la' $distlist
    mv $tarname.tar.gz $dirname/.

    popd
}

# Extracts a tar archive if required
opt_run_untar()
{
    local force_untar=$1; shift
    local auto_untar=$1; shift
    local package=$1; shift
    local version=$1; shift

    local ext="";

    if [ ! -z "$1" ] ; then
        ext=$1
    else 
        ext=".tar.gz"
    fi

    if [ $force_untar = "1" ] ; then
        run_untar $package $version $ext
    elif [ $auto_untar = "1" ] ; then
        if [ -d $package$version ] ; then
        echo "Found untarred version of $package$version$ext => no need to untar"
        else
        run_untar $package $version $ext
        fi
    fi
}

# Runs a configuration script with the relevant prefix and any other desired arguments
opt_run_configure()
{
    local force_config=$1; shift
    local auto_config=$1; shift
    local package=$1; shift
    local version=$1; shift
    local prefix=$1; shift

    if [ $force_config = "1" ] ; then
        echo "[pushd $package$version]"
        ( cd $package$version ; \
            echo $CROSSCONFIGURE_VARS ./configure --prefix="$prefix" $CROSSCONFIGURE_ARGS $@ ;
            eval $CROSSCONFIGURE_VARS ./configure --prefix="$prefix" $CROSSCONFIGURE_ARGS $@ )
        if [ $? != 0 ] ; then
            echo "    Error encountered running *configure* stage of $progname"
            exit 1
        fi
        echo "[popd]"
    else
        if [ $auto_config = "1" ] ; then
        echo "Found make file for ${progname%.*} => no need to run ./configure"
        fi
    fi
}

# Runs an autogen.sh script
opt_run_autogen() {
    local force_autogen=$1; shift
    local auto_autogen=$1; shift
    local package=$1; shift
    local version=$1; shift

    if [ $force_autogen = "1" ] ; then
        echo "[pushd ${package}${version}]"
        ( cd "${package}${version}" ; \
            echo ./autogen.sh ;
            eval ./autogen.sh )
        if [ $? != 0 ] ; then
            echo "    Error encountered running *autogen* stage of $progname"
            exit 1
        fi
        echo "[popd]"
    else
        if [ $auto_autogen = "1" ] ; then
        echo "Found configuration file for ${progname%.*} => no need to run ./autogen.sh"
        fi
    fi
}


opt_run_perl_configure()
{
  local force_config=$1; shift
  local auto_config=$1; shift
  local package=$1; shift
  local version=$1; shift
  local prefix=$1; shift

  if [ $force_config = "1" ] ; then
    echo "[pushd $package$version]"
    ( cd $package$version ; \
      echo perl Makefile.PL PREFIX="$prefix" $CROSSCOMPILE $@ ;
      perl Makefile.PL PREFIX="$prefix" $CROSSCOMPILE $@)
    if [ $? != 0 ] ; then
        echo "    Error encountered running *configure* stage of $progname"
        exit 1
    fi
    echo "[popd]"
  else
    if [ $auto_config = "1" ] ; then
      echo "Found top-level for ${progname%.*} => no need to run perl configure"
    fi
  fi
}

# Runs make on the target
opt_run_make()
{
    # Set from the relevant $compile, $install etc. variables. Used to determine if we should run make
    local type=$1; shift
    local package=$1; shift
    local version=$1; shift
    local opt_target=""

    if [ ! -z "$1" ] ; then
        opt_target=$1; shift
    fi

    if [ $type = "1" ] ; then
        ( cd $package$version ; \
            make $opt_target $@)

        if [ $? != 0 ] ; then
            echo "    Error encountered running *make $target* stage of $progname"
            exit 1
        fi
    fi
}

# Runs make on the target. Requires a subdirectory as the fourth parameter
opt_run_cmake()
{
    # Set from the relevant $compile, $install etc. variables. Used to determine if we should run make
    local type=$1
    local package=$2
    local version=$3
    local subdir=$4
    local opt_target=""

    if [ ! -z "$5" ] ; then
        opt_target=$5
    fi

    if [ $type = "1" ] ; then
        ( cd $package$version/$subdir ; \
            make $opt_target)

        if [ $? != 0 ] ; then
            echo "    Error encountered running *make $target* stage of $progname"
            exit 1
        fi
    fi
}

# Removes the installation directory
run_installclean()
{
    local installation_dir="$package_home/$PACKAGE_OS"
    echo ""
    read -p "Delete $installation_dir [y/n]?" ans
    if [ $ans = "y" ] ; then
        /bin/rm -rf "$installation_dir"
    fi

    exit 0
}


print_usage()
{
    echo "$0 [untar|autogen|configure|compile|install|clean|distclean|tarclean|makedist|makeminimal]+"
    echo "  or"
    echo "$0 [installclean|help]"
    exit 0
}

# If set, forces the untar function to extract a tar regardless of whether it already has been
force_untar=0
# If unset, prevents the tar function from running unless it is forced to
auto_untar=0

# If set, forces the autogen function to run
force_autogen=0
# If unset, prevents the autogen function from running unless it is forced to
auto_autogen=0

# If set, forces the configure function to run configuration regardless of whether it detects a configure step or not
force_config=0
# If set, directs the configure function to run
auto_config=0

# If these are set, it allows the make function to run
compile=0
install=0
clean=0
distclean=0

tarclean=0
makedist=0
makeminimal=0

if [ $# -gt 0 ] ; then
  for cmd in "$@" ; do
    echo $cmd
    if   [ $cmd = "untar" ]        ; then force_untar=1
    elif [ "${cmd}" = "autogen" ]  ; then force_autogen=1
    elif [ $cmd = "configure" ]    ; then force_config=1
    elif [ $cmd = "compile" ]      ; then compile=1
    elif [ $cmd = "install" ]      ; then install=1
    elif [ $cmd = "clean" ]        ; then clean=1
    elif [ $cmd = "distclean" ]    ; then distclean=1
    elif [ $cmd = "tarclean" ]     ; then tarclean=1
    elif [ $cmd = "makedist" ]     ; then makedist=1
    elif [ $cmd = "makeminimal" ]  ; then makeminimal=1

    elif [ $cmd = "installclean" ] ; then run_installclean
    elif [ $cmd = "help" ]         ; then print_usage
    fi
  done
else
  # defaults
  auto_untar=1
  auto_autogen=1
  auto_config=1
  compile=1
  install=1
  clean=0
  distclean=0
  tarclean=0
  makedist=0
  makeminimal=0
fi

if [ $auto_config = "1" ] ; then
    if [ ! -e "${package}${version}/Makefile" ] &&  [ ! -e "${package}${version}/config.h" ] ; then
        force_config=1
    fi
fi

if [ $auto_autogen = "1" ] ; then
    if [ ! -e "${package}${version}/configure" ] && [ -e "${package}${version}/autogen.sh" ] ; then
        force_autogen=1
    fi
fi