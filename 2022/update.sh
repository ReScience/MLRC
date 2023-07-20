#!/usr/bin/env sh

repo=$1

python update_metadata.py --folder_name $repo

cd $repo/

## Build
chmod +x yaml-to-latex.py
# ./yaml-to-latex.py -i metadata.yaml -o metadata.tex
make clean
make > out.log

cd ..
