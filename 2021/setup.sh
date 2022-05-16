#!/bin/bash
# Setup the accepted folders and dummy contents
# WARNING: only run once initially to set everything up
# WARNING: deletes the folder before re-init

read -r -d '' CONTENT <<EOF
\section{Reproducibility Summary}

Add your summary here. No need to worry about fitting it in a single page now.

\subsection{Submission Checklist}

Double check the file \texttt{journal/metadata.yaml} to contain the following information:

\begin{itemize}
\item Title should start with "\texttt{[Re]}"
\item Author information, along with ORCID id
\item Author affiliations
\item Code URL, Software Heritage Foundation link
\item Abstract
\item Review URL (the OpenReview URL of your report)
\end{itemize}

\subsection{Continuous Integration}

We use Github Actions CI to check your submission and compile the pdf file subsequently.
You can also run the tests locally by running \texttt{python check\_yaml.py}, and then running \texttt{./build.sh} to compile Latex.

\clearpage

\section{Content}
Copy your Openreview content here.

This is an example citation \cite{Sinha:2021}.

EOF

read -r -d '' JOURNAL_CONTENT <<EOF
\input{../openreview/content.tex}
EOF



read -r -d '' PACKAGES <<EOF
% Import packages here
\usepackage[utf8]{inputenc} % allow utf-8 input
\usepackage{hyperref}
EOF

read -r -d '' BIBFILE <<EOF
@article{Sinha:2021,
  author = {Sinha, Koustuv and Dodge, Jesse and Luccioni, Sasha and Forde, Jessica Zosa and Stojnic, Robert and Pineau, Joelle},
  title = {{ML Reproducibility Challenge 2020}},
  journal = {ReScience C},
  year = {2021},
  month = may,
  volume = {7},
  number = {2},
  pages = {1},
  doi = {10.5281/zenodo.4833117},
  url = {https://zenodo.org/record/4833117/files/article.pdf},
  type = {Editorial},
  keywords = {machine learning, neurips, reproducibility challenge}
}
EOF

read -r -d '' APPENDIX <<EOF
\newpage
\section*{Appendix}
\subsection{More details}
This is an \textit{extended appendix}.
EOF

read -r -d '' ARTICLE <<EOF
\documentclass{rescience}
\input{../openreview/packages.tex}
\begin{document}
\input{header.tex}
\input{../openreview/content.tex}

\setlength\bibitemsep{0pt}
\printbibliography

\input{../openreview/appendix.tex}

\end{document}
EOF

read -r -d '' METADATA <<EOF
# To be filled by the author(s) at the time of submission
# -------------------------------------------------------

# Title of the article:
#  - For a successful replication, it should be prefixed with "[Re]"
#  - For a failed replication, it should be prefixed with "[¬Re]"
#  - For other article types, no instruction (but please, not too long)
# Change the default title
title: "[Re] A report in MLRC 2021"

# List of authors with name, orcid number, email and affiliation
# Affiliation "*" means contact author (required even for single-authored papers)
authors:
  - name: John Doe
    orcid: 0000-0000-000-000
    email: johndoe@gmail.com
    affiliations: 1,*

  - name: Foo Bar
    orcid: 0000-0000-000-001
    email: foobar@gmail.com
    affiliations: 1      # * is for contact author

# List of affiliations with code (corresponding to author affiliations), name
# and address. You can also use these affiliations to add text such as "Equal
# contributions" as name (with no address).
affiliations:
  - code:    1
    name:    Hogwarts University
    address: Hogsmeade, UK


# List of keywords (adding the programming language might be a good idea)
keywords:  rescience c, machine learning, deep learning, python, pytorch

# Code URL and DOI/SWH (url is mandatory for replication, doi after acceptance)
# You can get a DOI for your code from Zenodo, or an SWH identifier from
# Software Heritage.
#   see https://guides.github.com/activities/citable-code/
code:
  - url: https://github.com/
  - doi: 00.0000/zenodo.0000000
  - swh: swh:1:dir:aaaaaaaaaaaaaaaaaaaaaaaaaaaaa

# Data URL and DOI (optional if no data)
data:
  - url:
  - doi:

# Information about the original article that has been replicated
replication:
 - cite: "Yoshua Bengio, Yann Lecun, Geoffrey Hinton. All you need is AGI (ICML 2042)."
 - bib:  bengio2042
 - url:  https://arxiv.org/pdf/xxxx.pdf
 - doi:  # Regular digital object identifier

# Don't forget to surround abstract with double quotes
abstract: "AGI is not all you need."

# Bibliography file (yours)
bibliography: bibliography.bib

# Type of the article
# Type can be:
#  * Editorial
#  * Letter
#  * Replication
type: Replication

# Scientific domain of the article (e.g. Computational Neuroscience)
#  (one domain only & try to be not overly specific)
domain: ML Reproducibility Challenge 2021

# Coding language (main one only if several)
language: Python


# To be filled by the author(s) after acceptance
# -----------------------------------------------------------------------------

# For example, the URL of the GitHub issue where review actually occured
review:
  - url: https://openreview.net/forum?id=forum_id

contributors:
  - name: Koustuv Sinha
    orcid:
    role: editor
  - name: Anonymous Reviewers
    orcid:
    role: reviewer
  - name:
    orcid:
    role: reviewer


# This information will be provided by the editor
dates:
  - received:  February 4, 2022
  - accepted:  April 11, 2022
  - published: May 15, 2022


# This information will be provided by the editor
article:
  - number: 0 # Article number will be automatically assigned during publication
  - doi: 10.0000/zenodo.0000000   # DOI from Zenodo
  - url: https://zenodo.org/record/0000000/files/article.pdf   # Final PDF URL (Zenodo or rescience website?)

# This information will be provided by the editor
journal:
  - name:   "ReScience C"
  - issn:   2430-3658
  - volume: 9
  - issue:  1
EOF

KEYS=$(cat accepted.bib | sed -n "s/[^{]*@inproceedings{\([^,]*\).*/\1/p")
key="$1"

if [[ ! "${KEYS[*]}" =~ "${key}" ]]; then
    echo "$key is not a valid bibkey. Please check accepted.bib for the correct key."
else
    echo "Setting up folder ${key}"
    if [ -d "$key" ]; then
        echo "Directory ${key} exists. If you want to create the boilerplate from scratch, delete the folder first."
        exit
    fi
    ## Create sample openreview folder
    echo "Creating openreview folder ..."
    mkdir -p $key/openreview
    touch $key/.gitkeep
    touch $key/openreview/.gitkeep
    touch $key/openreview/content.tex
    echo "$CONTENT" >> $key/openreview/content.tex
    touch $key/openreview/packages.tex
    echo "$PACKAGES" >> $key/openreview/packages.tex
    touch $key/openreview/appendix.tex
    echo "$APPENDIX" >> $key/openreview/appendix.tex

    ## Create sample journal folder
    echo "Creating journal folder ..."
    mkdir -p $key/journal
    touch $key/journal/.gitkeep
    cd $key/journal
    ## Make the symbolic links
    ln -s ../../template/Makefile .
    ln -s ../../template/article.py .
    ln -s ../../template/header.tex .
    ln -s ../../template/rescience.cls .
    ln -s ../../template/roboto .
    ln -s ../../template/source-code-pro .
    ln -s ../../template/source-sans-pro .
    ln -s ../../template/source-serif-pro .
    ln -s ../../template/yaml-to-latex.py .

    # Copy editable files
    cp ../../template/metadata.yaml .
    cp ../../template/metadata.tex .
    cp ../../template/content.tex .
    cp ../../template/article.tex .
    cp ../../template/bibliography.bib .
    cp ../../template/README.md .
    echo "$ARTICLE" > article.tex
    echo "$METADATA" > metadata.yaml
    echo "$BIBFILE" > bibliography.bib
    echo "Done creating folder ${key}"
    cd ../..
fi
