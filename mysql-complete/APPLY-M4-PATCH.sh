#!/bin/bash

echo "Applying patch: m4-1.4.18-glibc-change-work-around.patch"

patch -p0 < m4-1.4.18-glibc-change-work-around.patch
