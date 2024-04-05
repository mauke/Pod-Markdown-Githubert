# NAME

Pod::Markdown::Githubert - convert POD to Github-flavored Markdown

# SYNOPSIS

```perl
use Pod::Markdown::Githubert ();

my $parser = Pod::Markdown::Githubert->new;
$parser->output_string(\my $markdown);
$parser->parse_string_document($pod_string);

# see Pod::Markdown docs for the full API
```

# DESCRIPTION

Lorem ipsum $dolor + 42 - sit(amet, consectetur); $adipiscing elit, sed do
eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
veniam, `$quis = nostrud() / $exercitation` ullamco laboris nisi ut aliquip ex
ea commodo consequat.

Pod::Markdown::Githubert is a module for converting documents in POD format
(see [perlpod](https://perldoc.perl.org/perlpod)) to Github-flavored Markdown. It is a subclass of
[Pod::Markdown](https://metacpan.org/pod/Pod%3A%3AMarkdown) (which see for API documentation) that adds the following
Github-specific enhancements and fixes:

- Internal links (of the form `L</foo>`) are converted to something that
hopefully matches how Github generates HTML ids for Markdown headings. In
short, internal links to a section of the current page should just work when
rendered on Github.
- Github-specific Markdown code can be embedded literally using a
`=for github-markdown` paragraph or
`=begin github-markdown ... =end github-markdown` section.

    In other words, if you want to render e.g. a badge, but only on Github, not all
    Markdown renderers, put it in a `=for github-markdown` paragraph.

- External links to module documentation normally point to
[https://metacpan.org/](https://metacpan.org/). But that doesn't work for some of the manual pages
included with Perl because they are only generated when perl is built (such as
[perlapi](https://perldoc.perl.org/perlapi)), so this module redirects all `perlXYZ` links to
[https://perldoc.perl.org/](https://perldoc.perl.org/), which has the full set.
- Verbatim paragraphs are translated to fenced code blocks (surrounded by
```` ``` ````) with normalized indentation (meaning it doesn't matter whether the
paragraph is indented by 1 space, 4 spaces, or 23 spaces in the POD source; it
will generated the same Markdown).
- Code blocks containing ```` ``` ```` are rendered correctly, as are code blocks in
nested structures (such as list items) even when a numbered list item starts
with a code block.
- Syntax highlighting can be enabled by tagging each code block with its
language. As this module translates a POD document, it keeps a global "current
language" setting, which is applied to every verbatim paragraph. Initially the
"current language" is empty, which just produces ordinary ```` ``` ```` code blocks.

    A `=for highlighter language=FOO` paragraph sets the "current language" to
    _FOO_. (More specifically, you can put multiple _KEY=VALUE_ options in a
    `=for highlighter` paragraph, but this module only looks at the `language`
    option.) If you only want to set the "current language" to _FOO_, you can also
    write `=for highlighter FOO` (that is, `language` is the default option).

    The "current language" is applied to all following verbatim paragraphs and
    produces ```` ```FOO ```` tagged code blocks:

    ```pod
    =for highlighter language=perl

        my $dog = "spot";

    ... other stuff ...

        my $car = "cdr";

    =for highlighter language=html

        <p>Hello!</p>
    ```

    produces the following Markdown code:

    ````markdown
    ```perl
    my $dog = "spot";
    ```

    ... other stuff ...

    ```perl
    my $car = "cdr";
    ```

    ```html
    <p>Hello!</p>
    ```
    ````

# SEE ALSO

[Pod::Markdown](https://metacpan.org/pod/Pod%3A%3AMarkdown), [perlpod](https://perldoc.perl.org/perlpod)

# AUTHOR

Lukas Mai, `<lmai at web.de>`

# COPYRIGHT & LICENSE

Copyright 2023 Lukas Mai.

This module is free software; you can redistribute it and/or modify it under
the terms of either: the GNU General Public License as published by the Free
Software Foundation; or the Artistic License.

See [https://dev.perl.org/licenses/](https://dev.perl.org/licenses/) for more information.
