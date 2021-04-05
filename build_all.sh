#!/bin/bash
# Build all folders
# Should be run by the CI

KEYS=$(cat accepted.bib | sed -n "s/[^{]*@inproceedings{\([^,]*\).*/\1/p")
for key in $KEYS; do
    echo "Building ${key}"
    cd $key/journal/
    make clean
    make > build.log
    echo "Build complete"
    cd ../..
done
