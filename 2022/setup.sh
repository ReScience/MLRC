#!/usr/bin/env sh

repo=$1

cd $repo/

## Remove template files
rm Makefile
rm article.py
rm header.tex
rm rescience.cls
rm -rf roboto
rm -rf source-code-pro
rm -rf source-sans-pro
rm -rf source-serif-pro
rm yaml-to-latex.py
rm yaml-to-markdown.py
rm yaml-to-bibtex.py

## Make the symbolic links
ln -s ../template/Makefile .
ln -s ../template/article.py .
ln -s ../template/header.tex .
ln -s ../template/rescience.cls .
ln -s ../template/roboto .
ln -s ../template/source-code-pro .
ln -s ../template/source-sans-pro .
ln -s ../template/source-serif-pro .
ln -s ../template/yaml-to-latex.py .
ln -s ../template/yaml-to-bibtex.py .
ln -s ../template/yaml-to-markdown.py .

## Git
# git checkout -b 2022_$repo
