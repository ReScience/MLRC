# RC-2020 Accepted Papers

This repository serves as the editorial venue for [ML Reproducibility Challenge 2020](https://paperswithcode.com/rc2020) accepted papers.

## Instructions for Camera ready

ReScience editorial process consists of porting the existing latex sources into ReScience template, and then adding necessary information relevant for final publication. Authors of RC2020 accepted papers are requested to submit their camera-ready papers as outlined in the steps below. The project structure of this repository is organized as:

- `<paper_citekey>` <-- OpenReview citekey of the accepted paper at RC2020. List of accepted papers in `accepted.bib`
  - `openreview`  <-- location for the source files submitted to openreview
  - `journal`  <-- location of [ReScience C Template](https://github.com/ReScience/template) files


### Step 0: Setup your development environment for Latex

Some of you may have used Overleaf to write and submit your papers. We recommend to setup the Latex development pipeline locally in your system for full control over the editorial process. If you use a Mac, then use the following Homebrew formula:

``` sh
brew cask install mactex
```

For Ubuntu/Debian:

``` sh
apt-get install texlive
```

For Windows: [Download Tex Live](https://www.tug.org/texlive/acquire-netinstall.html) from source.


### Step 1: Copy the camera-ready latex content in `openreview` folder

- Fork this repository and clone it locally
- Add the latex content of your paper in the `openreview` folder of your paper citekey. (You can check your correct folder from [accepted.bib](accepted.bib))

### Step 2: Organize your latex code

Now we need to organize your contents a bit so as to make life easier for the editors!

- Make a new file `packages.tex` in your `openreview` folder, where you add all your import lines in Latex. ([Reference](https://github.com/ReScience/NeurIPS-2019/blob/master/ferlesReZeroShotKnowledge/openreview/packages.tex)). Import this file in your main tex file.
- Convert your main content in a `content.tex` file in the `openreview` folder, and import it in your `main.tex` file. Feel free to re-organize your latex code in different files, as long as everything can be imported in `content.tex`. Your `main.tex` file could look like following:

    ``` tex
    \documentclass{article}[12pt]
    \input{packages.tex}
    \title{Your title}
    \author{Your authors}
    \begin{document}
    \maketitle
    \input{content.tex}
    \end{document}
    ```


- [Optional] Test that the `openreview` compilation is working. Since the contents of `openreview` is isolated, you can test this in the [Overleaf template](https://www.overleaf.com/project/5f4e72de7681920001b208f9) directly. 
- Now, head over to the `journal` folder in your paper folder, and edit the `content.tex` such that it is importing the correct `../openreview/content.tex` file. Your `content.tex` file could look like this:

    ``` tex 
    \input{../openreview/content.tex}
    ```

    **Note**: It is possible to face compilation issues in imports if you have extra packages/commands. In such case, feel free to copy your main tex contents in the `content.tex` appropriately.

- Edit the `article.tex` file to include your `packages.tex` file before `\begin{document}`. ([Reference](https://github.com/ReScience/NeurIPS-2019/blob/master/ferlesReZeroShotKnowledge/journal/article.tex#L3))
- If you have an appendix, import it in `article.tex` after `\printbibliography` line. ([Reference](https://github.com/ReScience/NeurIPS-2019/blob/master/ferlesReZeroShotKnowledge/journal/article.tex#L14))

### Step 3: Edit the metadata

In the `journal` folder you will find a `metadata.yaml` file. This file is crucial to fill correctly for the journal to publish your paper correctly. Here is a [reference metadata.yaml file](https://github.com/ReScience/NeurIPS-2019/blob/master/ferlesReZeroShotKnowledge/journal/metadata.yaml) from our last iteration.

- Add the `title` of your paper. The paper title should start with `[Re] `.
- Add the author information in `authors`. This is a yaml list, so just copy paste the following block for all your authors:

``` yaml
- name: John Doe
  orcid: <your ORCID id>
  email: <your email>
  affiliations:
```

- Make sure to get your [ORCID id](https://orcid.org/).
- In the `affiliations` section, add the list of affiliations you have in your author list. At the same time, add the `code` of the affiliations in the `authors` section in a comma separated format. Add a `*` for contact author.
- In the `code` section, provide the `url` to your Github.
- Again, in the `code` section, provide the link to Software Heritage Foundation archival link to your code in `swh`. To get your SWH identifier, [provide the link to your code](https://archive.softwareheritage.org/save/) in Software Heritage Archive, which will queue it for archival. You can follow the [progress](https://archive.softwareheritage.org/save/#requests) of your request, and once the status changes to "succeeded", you can click on the URL link to arrive at the archived page of your code. From this page, click on the "Permalinks" side-button, and copy the code beginning with `swh`. Place this code in the yaml file under `swh`. ([Reference](https://github.com/ReScience/NeurIPS-2019/blob/master/ferlesReZeroShotKnowledge/journal/metadata.yaml#L46)])
- In the `replication` section, add the necessary information about the paper you reproduced.
- Provide your abstract in the `abstract` field (including double quotes)
- `domain` should contain "ML Reproducibility Challenge 2020"
- In `review` section, paste the url to the OpenReview forum of your paper.
- Leave the fields `contributors`, `dates`, `article` and `journal` fields blank, as those will be populated by the Area Chairs / ReScience editors.

### Step 4: Compile locally

In the `journal` folder of your paper, first remove the default `metadata.tex` file. Then, run `make` to compile. You should get the output `article.pdf` to be nicely formatted in the ReScience styles.

### Step 5: Submit a PR

Once your compilation is ready, open a Pull Request (PR) to the repository with your files. Our Area Chairs will then review and accept the submission, and proceed towards obtaining the journal metadata.

### Troubleshooting

While compiling you might face latex issues / errors. In such events, first inspect the log carefully for any offending blocks. If you are unsure, submit your PR anyway, and open an issue linking to your PR, where you attach the logs. Our AC's will gladly help to you fix the issues! Also, do consult the [codebase](https://github.com/ReScience/NeurIPS-2019) of our last iteration to narrow down any specific latex issues you are facing.

## For Editors

- To build all folders, run `./build_all.sh`

## Contact

- Koustuv Sinha (@koustuvsinha) [Mail](mailto:koustuv.sinha@mail.mcgill.ca)
