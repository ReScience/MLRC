#!/usr/bin/env bash

MODE=zenodo


for key in */; do
	if [ $key == "template/" ]; then
        continue
    fi
    if [ $key == "editorial/" ]; then
        continue
    fi
    ./build_one.sh $key
    echo "Publishing ${key}"
    ./../articles/publish.py --$MODE --metadata $key/journal/metadata.yaml --pdf $key/journal/article.pdf
done
