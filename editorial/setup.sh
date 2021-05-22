#!/bin/bash

ln -s ../template/Makefile .
ln -s ../template/article.py .
ln -s ../template/header.tex .
ln -s ../template/rescience.cls .
ln -s ../template/roboto .
ln -s ../template/source-code-pro .
ln -s ../template/source-sans-pro .
ln -s ../template/source-serif-pro .
ln -s ../template/yaml-to-bibtex.py . 
ln -s ../template/yaml-to-latex.py . 
ln -s ../template/yaml-to-markdown.py .

# Copy editable files
cp ../template/metadata.yaml .
cp ../template/metadata.tex .
cp ../template/content.tex .
cp ../template/article.tex .
cp ../template/bibliography.bib .
cp ../template/README.md .
