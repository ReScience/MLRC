#!/usr/bin/env sh

repo=$1

cd $repo/
chmod +x yaml-to-latex.py
# ./yaml-to-latex.py -i metadata.yaml -o metadata.tex
make clean
make > out.log

## git
# cd ..
# git add $repo
# git commit -m "Add paper $repo"
# git push -u origin 2022_${repo}
# gh pr create --title "[2022] Paper $repo" --body-file ../.github/PULL_REQUEST_TEMPLATE.md
# git checkout main
