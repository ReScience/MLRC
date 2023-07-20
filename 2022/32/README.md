# Document sources for the reproduction report of "If You Like Shapley Then You’ll Love the Core" 

This repository contains the LaTeX sources for our submission to the [ML Reproducibility Challenge 2022](https://paperswithcode.com/rc2022) reproducing the paper by Yan, Tom, and Ariel D. Procaccia, _"If You Like Shapley Then You’ll Love the Core". In Proceedings of the 35th AAAI Conference on Artificial Intelligence, 2021._

The contents follow the [ReScience C](https://rescience.github.io/) article template for submissions.

## Usage

If using overleaf for compilation, one has to enter `metadata.tex` manually.
For a submission, fill in information in
[metadata.yaml](./metadata.yaml), modify [content.tex](content.tex)
and type:

```bash
$ make 
```

This will produce an `article.pdf` using xelatex and provided font.

After acceptance, we need to complete [metadata.yaml](./metadata.yaml) with information provided by the editor and rebuild.

