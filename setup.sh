#!/bin/bash
# Setup the accepted folders and dummy contents
# WARNING: only run once initially to set everything up
# WARNING: deletes the folder before re-init

KEYS=$(cat accepted.bib | sed -n "s/[^{]*@inproceedings{\([^,]*\).*/\1/p")
for key in $KEYS; do
    echo "Setting up folder ${key}"
    rm -rf $key
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
    ln -s ../../template/source-code-pro .
    ln -s ../../template/source-sans-pro .
    ln -s ../../template/source-serif-pro .
    ln -s ../../template/yaml-to-bibtex.py . 
    ln -s ../../template/yaml-to-latex.py . 
    ln -s ../../template/yaml-to-markdown.py .

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
