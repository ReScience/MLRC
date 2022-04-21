# Machine Learning Reproducibility Challenge (MLRC) 2021 Accepted Papers

This repository serves as the editorial venue for [ML Reproducibility Challenge 2021](https://paperswithcode.com/rc2021) accepted papers. If your paper is accepted to the challenge, you must follow the instructions to submit your camera ready paper by **May 4th, 2022, Wednesday EOD**.

## Instructions for Camera ready

ReScience editorial process consists of porting the existing latex sources into ReScience template, and then adding necessary information relevant for final publication. Authors of RC2021 accepted papers are requested to submit their camera-ready papers as outlined in the steps below. The project structure of this repository is organized as:
 
 - 2021/
   - `<paper_citekey>` <-- OpenReview citekey of the accepted paper at RC2020. List of accepted papers in [`accepted.bib`](/accepted.bib)
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

**Note**: We also use [Git LFS](https://git-lfs.github.com/) to upload and store the compiled pdfs. You need to run this once in your local terminal to setup LFS uploads: `git lfs install`.


### Step 1: Setup report folder

- Fork this repository and clone it locally (**Note**: clone recursively using `--recurse-submodules` or `--recursive` flag)
- Find your `<paper_citekey>` from [accepted.bib](/2021/accepted.bib). It is the key after `@inproceedings`.
- In [2021](/2021) directory, setup your report folder using the `<paper_citekey>`. For example, if your citekey is `ahmed2022re`, then run the [setup.sh](/2021/setup.sh) with the argument:

``` bash
cd 2021/
./setup.sh ahmed2022re
```

  This will create the folder `ahmed2022re` and two subfolders, `openreview` and `journal` along with the boilerplate code.

- Test building your report using [build_all.sh](/2021/build_all.sh) script. This assumes you have the correct texlive distributions installed.

``` bash
cd 2021/
./build_all.sh
```

  You can find the logs in your terminal, as well as saved in `2021/<paper_citekey>/journal/build.log` file.
  
- Open the compiled pdf. It will be located at: `2021/<paper_citekey>/journal/article.pdf`.

### Step 2: Organize your latex code

Now we need to organize your contents a bit so as to make life easier for the editors! (:bulb: When setting up the folder in Step 1, we already add boilerplate for the following steps to help you understand the import process.)

- Add the latex content of your paper in the `openreview` folder of your paper citekey. (You can check your correct folder from [accepted.bib](/2021/accepted.bib))
- Use the `packages.tex` in your `openreview` folder to add all your import lines in Latex. ([Reference](https://github.com/ReScience/NeurIPS-2019/blob/master/ferlesReZeroShotKnowledge/openreview/packages.tex)). Import this file in your main tex file.
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


- [Optional] Test that the `openreview` compilation is working. Since the contents of `openreview` is isolated, you can test this in the [Overleaf template](https://www.overleaf.com/read/bmzfqzrkdnfg) directly. 
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
- `domain` should contain "ML Reproducibility Challenge 2021"
- In `review` section, paste the url to the OpenReview forum of your paper.
- Leave the fields `contributors`, `dates`, `article` and `journal` fields blank, as those will be populated by the Area Chairs / ReScience editors.

:bulb: You can test your metatdata is correct by running this Python Script:

``` bash
python check_yaml.py
```


### Step 5: Submit a PR

To submit your report, open a Pull Request (PR) to main branch. Our Area Chairs will then review and accept the submission, and proceed towards obtaining the journal metadata. Even if you have completed the report partially due to compilation issues, we ****strongly recommend**** to open your Pull Requests early to 1. get quicker help from our Area Chairs, and 2. take advantage of Github Actions for auto compilation.

### :bulb: Continuous Integration

This repository is also setup to use Github Actions to automatically compile the reports. After you submit your Pull Request, the CI will run the compilation step, check for errors, and then upload the compiled pdfs as "Artifacts" in the [workflow run](https://github.com/ReScience/MLRC/actions?query=event%3Apull_request) for the commit.

### Troubleshooting

While compiling you might face latex issues / errors. In such events, first inspect the log carefully for any offending blocks. If you are unsure, submit your PR anyway, and open an issue linking to your PR, where you attach the logs. To capture the log, pipe the `make` output to a file and add it to the PR (`make > build.log`). Our AC's will gladly help to you fix the issues! Also, do consult the [codebase](2020/) of our last iteration or [previously closed issues](https://github.com/ReScience/MLRC/issues?q=is%3Aissue+is%3Aclosed) to narrow down any specific latex issues you are facing.

#### :warning: Common Compilation Issues

- Please do not import `xcolor` in your `packages.tex`, as rescience.cls already imports this package
- Please remove the import of `fontenc` from your `packages.tex`. ReScience uses custom fonts, which breaks when fontenc is loaded on top of it. (Check [#4](https://github.com/ReScience/RC-2020/issues/4) for more discussion)


## MLRC2020

Files and latex sources for MLRC 2020 edition is now moved to [2020](2020/) folder.

## Contact

- Koustuv Sinha (@koustuvsinha) [Mail](mailto:koustuv.sinha@mail.mcgill.ca)
