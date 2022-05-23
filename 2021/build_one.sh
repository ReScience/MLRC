#!/usr/bin/env bash

key=$1
echo "Building ${key}"
cd $key/journal/
echo $(pwd)
make clean
# Remove the existing metadata.tex for \codeSWH to be generated
# metadata.tex will be generated from metadata.yaml using yaml-to-latex.py
rm metadata.tex
make > build.log
echo "Build complete"
rm article.aux
rm article.bbl
rm article.blg
rm article.fdb_latexmk
rm article.fls
rm article.out
rm article.log
rm article.run.xml
rm article.bcf
cd ../..
