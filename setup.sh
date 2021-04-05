#!/bin/bash
# Setup the accepted folders and dummy contents
# WARNING: only run once initially to set everything up

KEYS=$(cat accepted.bib | sed -n "s/[^{]*@inproceedings{\([^,]*\).*/\1/p")
for key in $KEYS; do
    echo "Setting up folder ${key}"
    mkdir -p $key/openreview
    mkdir -p $key/journal
    touch $key/.gitkeep
    touch $key/openreview/.gitkeep
    touch $key/journal/.gitkeep

    ## Make the symbolic links
    cd $key/journal
    ln -s ../../template/Makefile .
    ln -s ../../template/article.py .
    ln -s ../../template/header.tex .
    ln -s ../../template/rescience.cls .
    ln -s ../../template/roboto .
    ln -s ../../source-code-pro .
    ln -s ../../source-sans-pro .
    ln -s ../../source-serif-pro .
    ln -s ../../yaml-to-bibtex.py . 
    ln -s ../../yaml-to-latex.py . 
    ln -s ../../yaml-to-markdown.py .

    # Copy editable files
    cp ../../template/metadata.yaml .
    cp ../../template/metadata.tex .
    cp ../../template/content.tex .
    cp ../../template/article.tex .
    cp ../../template/bibliography.bib .
    cp ../../template/README.md .

    echo "Done for folder ${key}"
    cd ../..
done
