#!/usr/bin/env python3

import yaml
import glob


def check_ne(store, key, storename):
    assert key in store, f"{storename} must contain a `{key}` field"
    assert (
        len(str(store[key])) > 0
    ), f"{storename} entry cannot have an empty `{key}` field"


def check_title(meta):
    check_ne(meta, "title", "Metadata")
    assert meta["title"].startswith("[Re] ") or meta["title"].startswith(
        "[¬Re] "
    ), "title in metadata should start with `[Re]` or `[¬Re]`"


def check_authors(meta):
    check_ne(meta, "authors", "Metadata")
    assert type(meta["authors"]) == list, "authors field in metadata should be a list"
    assert len(meta["authors"]) >= 1, "authors field should contain at least one author"
    has_contact_author = False
    for author in meta["authors"]:
        check_ne(author, "name", "Metadata.authors")
        check_ne(author, "orcid", "Metadata.authors")
        check_ne(author, "email", "Metadata.authors")
        check_ne(author, "affiliations", "Metadata.authors")
        if "*" in str(author["affiliations"]):
            if not has_contact_author:
                has_contact_author = True
            else:
                raise AssertionError("Only one contact author needs to be specified")
    assert (
        has_contact_author
    ), "Any one author needs to be specified as contact author by a `*`"


def check_affiliations(meta):
    check_ne(meta, "affiliations", "Metadata")
    assert (
        len(meta["affiliations"]) >= 1
    ), "Metadata should contain at least one affiliation"
    for aff in meta["affiliations"]:
        check_ne(aff, "code", "Metadata.affiliations")
        check_ne(aff, "name", "Metadata.affiliations")
        # check_ne(aff, "address", "Metadata.affiliations")


def check_keywords(meta):
    check_ne(meta, "keywords", "Metadata")
    assert "rescience c" in meta["keywords"], "Keywords should contain `rescience c`"
    assert (
        "machine learning" in meta["keywords"]
    ), "Keywords should contain `machine learning`"


def check_code(meta):
    check_ne(meta, "code", "Metadata")
    code_items = {k: v for d in meta["code"] for k, v in d.items()}
    check_ne(code_items, "url", "Metadata->code")
    check_ne(code_items, "swh", "Metadata->code")


def check_replication(meta):
    check_ne(meta, "replication", "Metadata")
    rep_items = {k: v for d in meta["replication"] for k, v in d.items()}
    check_ne(rep_items, "cite", "Metadata->replication")
    check_ne(rep_items, "url", "Metadata->url")


def check_abstract(meta):
    check_ne(meta, "abstract", "Metadata")


def check_domain_type(meta):
    check_ne(meta, "type", "Metadata")
    assert meta["type"] == "Replication", "Metadata.type should be replication"
    check_ne(meta, "domain", "Metadata")
    assert (
        meta["domain"] == "ML Reproducibility Challenge 2021"
    ), "Metadata.domain should be ML Reproducibility Challenge 2021"


def check_language(meta):
    check_ne(meta, "language", "Metadata")


def check_review(meta):
    check_ne(meta, "review", "Metadata")
    rev_items = {k: v for d in meta["review"] for k, v in d.items()}
    check_ne(rev_items, "url", "Metadata->review")
    assert rev_items["url"].startswith(
        "https://openreview.net"
    ), "Metadata.review should point to the OpenReview forum"


if __name__ == "__main__":
    metadata_files = glob.glob("**/journal/metadata.yaml")
    metadata_files = [x for x in metadata_files if "template" not in x]
    assert len(metadata_files) >= 1, "No metadata file found"
    for mfile in metadata_files:
        if "editorial" in mfile:
            print("Skipping check for editorial")
            continue
        print(f"Validating {mfile} ...")
        meta = yaml.safe_load(open(mfile))
        check_title(meta)
        check_authors(meta)
        check_affiliations(meta)
        check_keywords(meta)
        check_code(meta)
        check_replication(meta)
        check_abstract(meta)
        check_domain_type(meta)
        check_language(meta)
        check_review(meta)
        print("Done, check complete, file ok.")
