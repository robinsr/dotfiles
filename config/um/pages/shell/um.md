# um -- Create custom man pages to remember stuff
{:data-section="shell"}
{:data-date="February 17, 2024"}
{:data-extra="Um Pages"}

## SYNOPSIS

`um` [`OPTIONS`] [*ARGUMENT*...]

## DESCRIPTION

All block elements like paragraphs, blockquotes, lists, ... work as they
do with normal kramdown documents.

Use code spans for `code`, `--options` and `user input`, emphasis for
*variables*, *argument names* and *file names*, and **strong emphasis**
for things that should stand out.

## EXAMPLE OPTIONS

`-o`
`--option`
: Description of option

`--key`=*value*
: Another option with a *value*

## USING UM


> um e grep

Opens the *grep* page (`.config/um/pages/grep`) in the configured editor 

## SYNTAX TEST


### Horizontal Rule

Might appear below here

***

---

~~~

End of hz rule test


### Tables

| A simple | table |
| with multiple | lines |


### Links


This is a link: [link-text](link-url)


This is an empty link: [link-text]()


This is a link with no text: [](link-url)



