#!/bin/bash
# collect bib files for final website PR

rm all_articles.bib

./collect_bib.sh editorial/

KEYS="albanis2021on/ arvind2021reproducibility/ baanders2021reproducibility/ garg2021re/ harrison2021learning/ holdijk2021re/ kim2021re/ li2021reimplementation/ liiv2021a/ menon2021re/ mentes2021re/ mizrahi2021re/ mohtashami2021reproducibility/ p2021embedkgqa/ reijnaers2021re/ rijsdijk2021reproducing/ rodas2021rehamiltonian/ schneider2021re/ sheverdin2021reproducibility/ sundar2021reproducibility/ verhoef2021reproducibility/ verhoeven2021replication/ verma2021explaining/" 

for key in $KEYS; do
    ./collect_bib.sh $key
done
