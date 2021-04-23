make clean
rm metadata.tex
make
biber article
rm metadata.tex
latexmk -pdf -pdflatex="xelatex -interaction=nonstopmode" -use-make article.tex
