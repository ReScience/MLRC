#!/bin/bash

MODE=zenodo
inp=$1
echo $inp

# Prepublish article
# if [ $inp = 'editorial' ]; then
#     echo "Editorial processing"
#     ./../articles/process.py --$MODE --metadata editorial/metadata.yaml --pdf editorial/article.pdf
# else
#     echo "Paper $inp processing"
#     loc=$inp/journal/
#     ./../articles/process.py --$MODE --metadata $loc/metadata.yaml --pdf $loc/article.pdf

# fi

# Publish articles

if [ $inp = 'editorial' ]; then
    echo "Editorial processing"
    ./../articles/publish.py --$MODE --metadata editorial/metadata.yaml --pdf editorial/article.pdf
else
    echo "Paper $inp processing"
    loc=$inp/journal/
    ./../articles/publish.py --$MODE --metadata $loc/metadata.yaml --pdf $loc/article.pdf

fi


