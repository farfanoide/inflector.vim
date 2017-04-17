Inflector.vim
=============

[![Build Status](https://travis-ci.org/farfanoide/inflector.vim.svg?branch=master)](https://travis-ci.org/farfanoide/inflector.vim)

This might at some point become a real plugin, right now it's just a little
project to learn vimscript.

The idea is to have a set of functions that present similar functionality as
[ActiveSupport::Inflector][inflector] and make it easier to go from something
like 'some_var' to 'SOME_VAR' or 'SomeVar' to 'some_var', etc.

![inflector.vim in action](https://www.dropbox.com/s/qkg7go15e1oeypl/inflector.vim.gif?dl=1 "inflector.vim plugin")

Why?
----

Because it seemed simple enough for a first approach into vimscript and because
available options require either python or ruby.

Installation:
-------------

Probably any plugin manager will work.

With [vim-plug][vim-plug]:

```vim
Plug 'farfanoide/inflector.vim'
```

With [Vundle][vundle]:

```vim
Plugin 'farfanoide/inflector.vim'
```

With [dein][dein]:

```vim
call dein#add('farfanoide/inflector.vim')
```

Usage:
------

Inflector does not ship with any mappings so in order to use it you have to add
some to your vimrc. To have the plugin create them for you, just set
`g:inflector_mapping`, for example:

```vim
let g:inflector_mapping = 'gI'
```

Or if you want, set them manually:

```vim
nmap gI <Plug>(Inflect)
vmap gI <Plug>(Inflect)
```

Done, now you can `gI` some text (stands for `go Inflect`).
With those mappings you can call the Inflect function in normal mode passing it
a text object or a motion, IE: `gIiW`, or `gI/searchsomething`. Inflector will
ask you for the type of conversion you want to apply.

Available inflections:
----------------------

The idea behind the plugin is to have a sort of `"Text Multiplexer"` which can
translate from any of the recognized patterns to any other, meaning: it should
be the able to go from `PascalCase` to `CONSTANT` or `camelCase` and viceversa.

This is done by having a common representation which currently is based on a
list so `SomeText` translates into `['some', 'text']` and from there it's
trivial to convert to any other representation.

| Inflection  |  Alias  |          Input           |  Command   |          Output          |
| ----------- | ------- | ------------------------ | ---------- | ------------------------ |
|   Dotify    |   `.`   |      someTextToWork      |  `gIiw.`   |    some.text.to.work     |
|  Dasherize  |   `-`   |    some_text_to_work     |  `gIiw-`   |    some-text-to-work     |
| Underscore  |   `_`   |    some text to work     |   `gI$_`   |    some_text_to_work     |
| FreeBallIt  |   `f`   |    some text to work     |  `gI$f&`   |    some&text&to&work     |
|  Camelize   |   `c`   |    Some Text To Work     |   `gI$c`   |      someTextToWork      |
| Constantize |   `C`   |    some text to work     |   `gI$C`   |    SOME_TEXT_TO_WORK     |
|  Pascalize  |   `P`   |    some.text.to.work     |  `gIiWP`   |      SomeTextToWork      |
|  Titleize   |   `t`   |    some text to work     |   `gI$t`   |    Some Text To Work     |
|  Normalize  |   `n`   |    SOME_TEXT_TO_WORK     |   `gI$n`   |    some text to work     |
|  Slashify   |   `/`   |    SOME_TEXT_TO_WORK     |   `gIiw/`  |    some/text/to/work     |
|  Privatize  |   `p`   |         some_var         |   `gI$p`   |        `_some_var`       |

> The only transformation that is handeled differently is `Privatize` which
> basically only checks if the text being tranfsformed already starts with a
> `_`.

Tests
-----

So far, tests are ran via [Vader][vader], open
[inflector.vader](./test/inflector.vader) and run `:Vader`

License:
--------

See the [LICENSE](LICENSE).

Contributing:
--------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

TODO:
-----

- [ ] add repeat support
- [ ] add vim help?


<!-- links -->
[inflector]: http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html
[vader]: https://github.com/junegunn/vader.vim
[vim-plug]: https://github.com/junegunn/vim-plug
[vundle]: https://github.com/VundleVim/Vundle.vim
[dein]: https://github.com/Shougo/dein.vim
<!-- end links -->
