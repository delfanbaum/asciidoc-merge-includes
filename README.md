# asciidoc-merge-includes

A tool to merge "included" asciidoc files, because sometimes you need to do that. 

I wrote the bulk of the code before realizing that a similar project already exists
([`asciidoc-merger`](https://github.com/vinceve/asciidoc-merger)). That project looks
great, although it doesn't have a CLI. If you need to merge things programmatically
I'd use that tool. If you just need to process a file here and there, this one might be
the ticket.

## Usage

```
Usage: asciidoc-merge-includes FILE(S) [options]

Options:
    -i, --in-placep                  Modify asciidoc files in place
    -v, --verbose                    Output processing information

Help options:
    -h, --help                       Shows help
```
