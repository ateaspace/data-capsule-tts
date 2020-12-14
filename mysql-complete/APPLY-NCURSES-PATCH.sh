#!/bin/bash

echo "Applying patch: MKlib_gen.sh.patch"

cd ncurses-5.9/ncurses/base \
   && patch < ../../../MKlib_gen.sh.patch

