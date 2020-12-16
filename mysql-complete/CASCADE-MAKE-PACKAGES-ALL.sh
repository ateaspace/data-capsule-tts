
if [ ! -d openssl-1.1.1h ] ; then
    ./CASCADE-MAKE-OPENSSH.sh
    status = $?
    if [ $status != 0 ] ; then
	echo "Failed to build openssh" >&2
	exit $status
    fi
fi

./CASCADE-MAKE-NCURSES.sh \
    && ./CASCADE-MAKE-M4.sh \
    && ./CASCADE-MAKE-BISON.sh
