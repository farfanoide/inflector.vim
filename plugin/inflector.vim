" if exists('g:loaded_inflector')
"   finish
" endif
"
" let g:loaded_inflector = 1

function! Sanitize(str)
    if a:str =~ '\s'
        let l:separator = '\s'
    elseif a:str =~ '_\|-\|\.'
        let l:separator = '_\|-\|\.'
    else
        let l:separator = '[A-Z]\?[a-z]*\zs'
    endif
    return map(split(a:str, l:separator), 'tolower(v:val)')
endfunction

function! Constantize(str)
    return join(map(Sanitize(a:str), 'toupper(v:val)'), '_')
endfunction

function! Camelize(str)
    return join(map(Sanitize(a:str), 'Capitalize(v:val)'), '')
endfunction

function! Capitalize(word)
    return substitute(tolower(a:word), '\w', '\=toupper(submatch(0))', '')
endfunction

function! Titleize(str)
    return join(map(Sanitize(a:str), 'Capitalize(v:val)'))
endfunction

function! Privatize(str)
    return a:str =~ '^_' ? a:str : '_' . a:str
endfunction

function! Underscore(str)
    return join(Sanitize(a:str), '_')
endfunction

function! Dasherize(str)
    return join(Sanitize(a:str), '-')
endfunction

function! Dotify(str)
    return join(Sanitize(a:str), '.')
endfunction

" TODO: check l:inflection is inside l:inflection.keys
" TODO: add aliases? ie: dot == . == d == dotify
" TODO: write examples of mappings
" TODO: add support to auto add mappings

function! Inflect(type, ...)
    " Save stuff
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    " get inflection type
    echom 'Select Inflection (.,_,-,c,C,d,p,t):'
    let l:inflection = nr2char(getchar())
    let l:inflections = {
                \ '.': function('Dotify'),
                \ '-': function('Dasherize'),
                \ '_': function('Underscore'),
                \ 'C': function('Constantize'),
                \ 'c': function('Camelize'),
                \ 'd': function('Dotify'),
                \ 'p': function('Privatize'),
                \ 't': function('Titleize'),
                \ }

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gvy"
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    else
        silent exe "normal! `[v`]y"
    endif

    " call inflector
    let l:result = l:inflections[l:inflection](@@)

    " set result in clipboard
    call setreg('@', l:result, getregtype('@'))

    " replace old text with result
    normal! `[v`]p
    let &selection = sel_save
    let @@ = reg_save
    " clear command line
    echom ''
endfunction
