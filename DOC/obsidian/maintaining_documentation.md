# Maintain this documentation

The Markdown handbook is maintained in the Obsidian vault at `DOC/obsidian`. Open that folder as a vault in Obsidian; its `README.md` is the handbook entry point. The `glossary` and `images` folders belong to the vault. Natural Docs generates the API reference into `DOC/api` from the source comments under `PIT`. Configuration remains in `ND`; generated working data is not handbook content. `ND/Languages.txt` explicitly maps the repository's PL/SQL extensions to SQL so generation works without machine-wide custom settings.

## Build the API reference

From the repository root, with Natural Docs installed:

```sh
NaturalDocs -p ND
```

`ND/Project.txt` selects `../PIT` as input and `../DOC/api` as HTML output, relative to the configuration directory. Use `NaturalDocs -p ND -r` when a complete rebuild is required. Review generation errors before publishing the result. Source comments may include internal details or incomplete descriptions; verify behavior against the implementation when changing the handbook.

The separate legacy PL/SQL-generated HTML under `PIT/Doc` is not the handbook or its current API build destination.

## Add or revise a chapter

Keep English and the existing direct, explanatory voice. Explain a use case, show the current public API and make the result clear. Verify signatures, defaults and behavior in source, including version-specific implementations where relevant. Do not carry an older description forward merely because it already appears in generated HTML.

Add navigation from the handbook index and related chapters. Preserve useful filenames when possible. Code examples with application-specific `MSG` constants require the corresponding definitions; identify that prerequisite instead of suggesting the constants are built in.

## Link glossary terms

Each glossary term has its own file under `glossary/`. Link the first occurrence in prose on each page to that file. Headings, code, existing links and implementation-path labels are excluded so that examples remain copyable and headings stay readable. Subsequent prose occurrences on the same page remain plain text. On a term's own page, do not link the term to itself.

When adding a term, update the glossary index and the term rules in the documentation checker. The checker reports an unlinked first occurrence, broken local paths, missing anchors and mismatched path casing. Use `python3 tools/check_documentation.py --fix-glossary` to insert missing first-mention links.

## Check the handbook

```sh
python3 tools/check_documentation.py
```

The checker scans the root README and Markdown handbook, including links to generated API files and source references. It does not execute SQL examples or validate the database installation. Review examples against package specifications and use an Oracle test installation for behavior changes.

---

[Handbook](README.md) · [Glossary](glossary/README.md) · [Previous chapter](interface_changes.md)
