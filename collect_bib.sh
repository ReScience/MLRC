#!/bin/bash

collect() {
    doi=$(yq e '(.article.[] | select(.doi) | .[])' metadata.yaml)
    echo $doi | tr / _
}


inp=$1
echo $inp

if [ $inp = 'editorial' ]; then
    echo "Editorial processing"
    cd editorial/
    doi=$(collect)
    cd ..
    git checkout $doi
    cat $doi/article.bib >> all_articles.bib
    echo -e "\n" >> all_articles.bib
    git checkout main
else
    echo "Paper $inp processing"
    cd $inp/journal/
    doi=$(collect)
    cd ../..
    git checkout $doi
    cat $doi/article.bib >> all_articles.bib
    echo -e "\n" >> all_articles.bib
    git checkout main
fi
