#!/bin/bash

echo  "Running diff -u on MKlib_gen.sh.NEW and ncurses-5.9/ncurses/base/MKlib_gen.sh"

cp MKlib_gen.sh.NEW ncurses-5.9/ncurses/base/. \
   && cd ncurses-5.9/ncurses/base \
   && diff -u MKlib_gen.sh MKlib_gen.sh.NEW > ../../../MKlib_gen.sh.patch

echo "Generated MKlib_gen.sh.patch"
