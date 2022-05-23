#!/usr/bin/env bash
# Symlink again

for key in */; do
    echo "$key"
    if [ $key == "template/" ]; then
        continue
    fi
    if [ $key == "editorial/" ]; then
        continue
    fi
    cd $key/journal
    ## Remove old links
    rm Makefile
    rm article.py
    rm header.tex
    rm rescience.cls
    rm -rf roboto
    rm -rf source-code-pro
    rm -rf source-sans-pro
    rm -rf source-serif-pro
    rm -rf yaml-to-latex.py
    ## Re-link the symbolic links
    ln -s ../../template/Makefile .
    ln -s ../../template/article.py .
    ln -s ../../template/header.tex .
    ln -s ../../template/rescience.cls .
    ln -s ../../template/roboto .
    ln -s ../../template/source-code-pro .
    ln -s ../../template/source-sans-pro .
    ln -s ../../template/source-serif-pro .
    ln -s ../../template/yaml-to-latex.py .
    cd ../..
done
