#!/usr/bin/env bash

# Get all bib file for final website push

MAIN_BIB=published.bib
OUTP_BIB=tmp.bib

touch $MAIN_BIB

for key in */; do
    if [ $key == "template/" ]; then
        continue
    fi
    SOURCE_BIB=$key/journal/metadata.yaml
    ./../articles/yaml-to-bibtex.py -i $SOURCE_BIB -o $OUTP_BIB
    cat $OUTP_BIB >> $MAIN_BIB
    echo "" >> $MAIN_BIB
    echo "" >> $MAIN_BIB
done
rm $OUTP_BIB
