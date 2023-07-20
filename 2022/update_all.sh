#!/usr/bin/env sh

COMMENT="update article metadata"

for repo in {1..9}
do
    echo $repo
    git checkout 2022_$repo
    ./update.sh $repo
    git add $repo
    git commit -m "$COMMENT $repo"
    git push -u origin 2022_${repo}
    git checkout main

done

for repo in {10..27}
do
    echo $repo
    git checkout 2022_paper_$repo
    ./update.sh $repo
    git add $repo
    git commit -m "$COMMENT $repo"
    git push -u origin 2022_paper_${repo}
    git checkout main
done

for repo in {28..45}
do
    echo $repo
    git checkout 2022_$repo
    ./update.sh $repo
    git add $repo
    git commit -m "$COMMENT $repo"
    git push -u origin 2022_${repo}
    git checkout main
done
