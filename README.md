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

TODO:
-----

- [x] Create functions for common inflections
- [x] Create text multiplexer (one way is done via `Sanitize`)
- [ ] explain the idea of 'text multiplexer'
- [ ] check how to run the functions with text objects/motions as input
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
