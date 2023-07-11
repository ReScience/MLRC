#!/usr/bin/env sh

repo=$1

cd $repo/
chmod +x yaml-to-latex.py
# ./yaml-to-latex.py -i metadata.yaml -o metadata.tex
make clean
make > out.log
