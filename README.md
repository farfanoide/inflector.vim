Inflector.vim
=============

[![Build Status](https://travis-ci.org/farfanoide/inflector.vim.svg?branch=master)](https://travis-ci.org/farfanoide/inflector.vim)

This might at some point become a real plugin, right now it's just a little
project to learn vimscript.

The idea is to have a set of functions that present similar functionality as
[ActiveSupport::Inflector][inflector] and make it easier to go from something
like 'some_var' to 'SOME_VAR' or 'SomeVar' to 'some_var', etc.

Why?
----
Because it seems simple enough for a first approach into vimscript and because
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

Inflector does not ship with any mappings, to use it you have to add some to
your vimrc, for example:

```vim
" Set them manually
nmap gI <Plug>(Inflect)
vmap gI <Plug>(Inflect)
```

Alternatively you can set `g:inflector_mapping` and both normal and visual
mappings will be created automatically.

```vim
let g:inflector_mapping = 'gI'
```

Done, now you can `gI` some text (stands for `go Inflect`).
with those mappings you can call the Inflect function in normal mode passing it
a text object or a motion, ie: `gIiW`, or `gI/searchsomething`. Inflector will
ask you for the type of conversion you want to apply.

Available inflections:
----------------------

- Dotify (invoked with `.`):

    ```vim
    {cursor}some text to work
    " gI$. results in:
    some.text.to.work
    ```

- Dasherize (invoked with `-`):

    ```vim
    {cursor}some text to work
    " gI$- results in:
    some-text-to-work
    ```

- Constantize (invoked with `C`):

    ```vim
    {cursor}some text to work
    " gI$C results in:
    SOME_TEXT_TO_WORK
    ```

- Camelize (invoked with `c`):

    ```vim
    {cursor}some text to work
    " gI$c results in:
    someTextToWork
    ```
- Pascalize (invoked with `P`):

    ```vim
    {cursor}some text to work
    " gI$c results in:
    SomeTextToWork
    ```

- Titleize (invoked with `t`):

    ```vim
    {cursor}some text to work
    " gI$t results in:
    Some Text To Work
    ```

- Underscore (invoked with `_`):

    ```vim
    {cursor}some text to work
    " gI$_ results in:
    some_text_to_work
    ```

- Privatize (invoked with `p`):

    ```vim
    {cursor}some_var
    " gI$p results in:
    _some_var
    ```

TODO:
-----

- [x] Create functions for common inflections
- [x] Create text multiplexer (one way is done via `Sanitize`)
- [x] check how to run the functions with text objects/motions as input (:h map-operator)
- [x] export plugin mappings
- [x] add support to auto generate mappings, ie: let g:inflector_mapping = 'gI'
- [ ] add tests for mappings
- [ ] scope functions to script while keeping tests running http://stackoverflow.com/questions/15595505/unit-testing-vim-script-local-functions-with-vimrunner
- [ ] rename camelize to Pascalize and add camelize
- [x] check how to enable autoloading of the plugin
- [x] use autoloading to setup travis ci
- [ ] explain the idea of 'text multiplexer'
- [ ] add vim help
- [ ] write installation instructions
- [ ] write usage
- [ ] add repeat support

Tests
-----

So far, tests are ran via [Vader][vader], open
[inflector.vader](./test/inflector.vader) and run `:Vader`

[inflector]: http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html
[vader]: https://github.com/junegunn/vader.vim
[vim-plug]: https://github.com/junegunn/vim-plug
[vundle]: https://github.com/VundleVim/Vundle.vim
[dein]: https://github.com/Shougo/dein.vim
