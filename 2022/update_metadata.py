#!/usr/bin/env python3

import os
from fire import Fire
from pathlib import Path
import requests

zenodo_tokens = {
    "sandbox": os.environ.get("ZENODO_SANDBOX_TOKEN", ""),
    "production": os.environ.get("ZENODO_TOKEN", ""),
}
zenodo_url = {"sandbox": "sandbox.zenodo.org", "production": "zenodo.org"}


def reserve_doi(server, token):
    """Reserve a new DOI on Zenodo"""

    headers = {"Content-Type": "application/json"}
    url = f"https://{server}/api/deposit/depositions"
    response = requests.post(
        url, params={"access_token": token}, json={}, headers=headers
    )
    if response.status_code != 201:
        raise IOError("%s: " % response.status_code + str(response))
    data = response.json()
    return data["id"], data["metadata"]["prereserve_doi"]["doi"]


def reserve_zenodo_info(server="sandbox"):
    server_url = zenodo_url[server]
    token = zenodo_tokens[server]
    article_id, article_doi = reserve_doi(server_url, token)
    article_url = f"https://{server_url}/record/{article_id}/files/article.pdf"
    return article_id, article_doi, article_url


def load_metadata(folder_name):
    mfile = Path(str(folder_name)) / "metadata.yaml"
    lines = []
    with open(mfile) as fp:
        for line in fp:
            lines.append(line)
    return lines


def save_metadata(mlines, folder_name):
    mfile = Path(str(folder_name)) / "metadata.yaml"
    with open(mfile, "w") as fp:
        for line in mlines:
            fp.write(line)


def update_line(lines, search, dest):
    dt_line = [i for i, line in enumerate(lines) if search in line]
    assert len(dt_line) == 1, f"Found {len(dt_line)} matches"
    lines[dt_line[0]] = dest
    return lines


def update_article(lines, doi="", url=""):
    article_start = [i for i, line in enumerate(lines) if line.startswith("article:")]
    article_end = [i for i, line in enumerate(lines) if line.startswith("journal:")]
    assert len(article_start) == 1
    assert len(article_end) == 1
    article_start = article_start[0]
    article_end = article_end[0] - 2
    doi_line = [
        i
        for i, line in enumerate(lines)
        if (i > article_start and i < article_end and "doi:" in line)
    ]
    assert len(doi_line) == 1
    doi_line = doi_line[0]
    url_line = [
        i
        for i, line in enumerate(lines)
        if (i > article_start and i < article_end and "url:" in line)
    ]
    assert len(url_line) == 1
    url_line = url_line[0]

    lines[doi_line] = f"  - doi: {doi}\n"
    lines[url_line] = f"  - url: {url}\n"
    return lines


CONT_LINES = [
    "  - name:",
    "    orcid:\n",
    "    role: editor\n",
    "  - name:\n",
    "    orcid:\n",
    "    role: reviewer\n",
    "  - name:\n",
    "    orcid:\n",
    "    role: reviewer\n",
]

EDITOR_LIST = ["Koustuv Sinha", "Maurits Bleeker", "Samarth Bhargav"]


def update_contributors(lines, delim=",\\\\ "):
    contributors_start = [
        i for i, line in enumerate(lines) if line.startswith("contributors:")
    ]
    assert len(contributors_start) == 1
    contributors_start = contributors_start[0] + 1
    contributors_end = contributors_start + len(CONT_LINES)
    lines[contributors_start:contributors_end] = CONT_LINES
    editors_names = delim.join(EDITOR_LIST)
    lines[contributors_start] = f"  - name: {editors_names}\n"
    return lines


def run(
    folder_name="",
    received_date="February 4, 2023",
    accepted_date="April 19, 2023",
    published_date="July 20, 2023",
    article_number=0,
    volume=9,
    issue=2,
    zenodo=False,
    zenodo_server="sandbox",
):
    mlines = load_metadata(folder_name)
    if folder_name != "editorial":
        mlines = update_line(mlines, "received:", f"  - received:  {received_date}\n")
        mlines = update_line(mlines, "accepted:", f"  - accepted:  {accepted_date}\n")
        mlines = update_line(mlines, "number:", f"  - number: {folder_name}\n")
    else:
        mlines = update_line(mlines, "number:", f"  - number: {article_number}\n")
    mlines = update_line(mlines, "published:", f"  - published:  {published_date}\n")
    mlines = update_line(mlines, "volume:", f"  - volume: {volume}\n")
    mlines = update_line(mlines, "issue:", f"  - issue: {issue}\n")

    mlines = update_contributors(mlines)

    if zenodo:
        # Update DOI
        ## fetch from Zenodo

        article_id, article_doi, article_url = reserve_zenodo_info(zenodo_server)
        mlines = update_article(mlines, doi=article_doi, url=article_url)

    # update file
    save_metadata(mlines, folder_name)


if __name__ == "__main__":
    Fire(run)
