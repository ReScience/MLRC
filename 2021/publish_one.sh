#!/usr/bin/env bash
MODE=zenodo
key=$1

echo "Publishing ${key}"
./../articles/publish.py --$MODE --metadata $key/journal/metadata.yaml --pdf $key/journal/article.pdf
