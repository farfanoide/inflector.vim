Inflector.vim
=============

[![Build Status](https://travis-ci.org/farfanoide/inflector.vim.svg?branch=master)](https://travis-ci.org/farfanoide/inflector.vim)

This might at some point become a plugin, right now it's just a little project
to learn vimscript.

The idea is to have a set of functions that present similar functionality as
[ActiveSupport::Inflector][inflector] and make it easier to go from something
like 'some_var' to 'SOME_VAR' or 'SomeVar' to 'some_var', etc.

Why?
----
Because it seems simple enough for a first approach into vimscript and because
available options require either python or ruby.

Usage:
------

Add some mappings to your vimrc:

```vim
nmap <silent> gI :set opfunc=Inflect<CR>g@
vmap <silent> gI :<C-U>call Inflect(visualmode(), 1)<CR>
```

Done, now you can `gI` some text (stands for `go Inflect`).
with those mappings you can call the Inflect function in normal mode passing it
a text object or a motion, ie: `gIiW`, or `gI/searchsomething`. Inflector will
ask you for the type of conversion you want to apply.

Available inflections:
----------------------

- Dotify (invoked with .):

    ```vim
    {cursor}some text to work
    " gI$. results in:
    some.text.to.work
    ```

- Dasherize (invoked with -):

    ```vim
    {cursor}some text to work
    " gI$- results in:
    some-text-to-work
    ```

- Constantize (invoked with C):

    ```vim
    {cursor}some text to work
    " gI$C results in:
    SOME_TEXT_TO_WORK
    ```

- Camelize (invoked with t):

    ```vim
    {cursor}some text to work
    " gI$c results in:
    SomeTextToWork
    ```

- Titleize (invoked with t):

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

- Privatize (invoked with p):

    ```vim
    {cursor}some_var
    " gI$p results in:
    _some_var
    ```

TODO:
-----

- [x] Create functions for common inflections
- [x] Create text multiplexer (one way is done via `Sanitize`)
- [ ] rename camelize to Pascalize and add camelize
- [x] check how to run the functions with text objects/motions as input (:h map-operator)
- [ ] explain the idea of 'text multiplexer'
- [x] check how to enable autoloading of the plugin
- [x] use autoloading to setup travis ci
- [ ] add vim help
- [ ] write installation instructions
- [ ] write usage

Tests
-----

So far, tests are ran via [Vader][vader], open
[inflector.vader](./test/inflector.vader) and run `:Vader`

[inflector]: http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html
[vader]: https://github.com/junegunn/vader.vim
