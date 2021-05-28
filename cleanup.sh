#!/bin/bash

cleanup_dir() {
    rm article.aux
    rm article.bbl
    rm article.blg
    rm article.fdb_latexmk
    rm article.fls
    rm article.out
    rm article.log
    rm article.run.xml
    rm article.bcf
}

inp=$1
echo $inp
if [ $inp = 'editorial' ]; then
    echo "Editorial processing"
    cd editorial/
    cleanup_dir
else
    echo "Paper $inp processing"
    cd $inp/journal/
    cleanup_dir
fi
