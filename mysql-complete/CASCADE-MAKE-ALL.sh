#!/bin/bash

./CASCADE-MAKE-PACKAGES-ALL.sh \
    && echo "****" \
    && echo "* Compiling up MySql v5.7" \
    && echo "****" \
    && ./CASCADE-MAKE-MYSQL57.sh
