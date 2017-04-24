if exists('g:loaded_inflector')
  finish
endif

let g:loaded_inflector = 1

function! s:Sanitize(str)
    if a:str =~ '\s\|[._\-/]'
        let l:separator = '\s\|[._\-/]'
    else
        let l:separator = '[A-Z]\?[a-z]*\zs'
    endif
    return map(split(a:str, l:separator), 'tolower(v:val)')
endfunction

function! s:Normalize(str)
    return join(s:Sanitize(a:str))
endfunction

function! s:Constantize(str)
    return join(map(s:Sanitize(a:str), 'toupper(v:val)'), '_')
endfunction

function! s:Pascalize(str)
    return join(map(s:Sanitize(a:str), 's:Capitalize(v:val)'), '')
endfunction

function! s:Camelize(str)
    return substitute(s:Pascalize(a:str), '^\w', '\=tolower(submatch(0))', '')
endfunction

function! s:Capitalize(word)
    return substitute(tolower(a:word), '\w', '\=toupper(submatch(0))', '')
endfunction

function! s:Titleize(str)
    return join(map(s:Sanitize(a:str), 's:Capitalize(v:val)'))
endfunction

function! s:Privatize(str)
    return a:str =~ '^_' ? a:str : '_' . a:str
endfunction

function! s:Underscore(str)
    return s:SplitJoin(a:str, '_')
endfunction

function! s:Dasherize(str)
    return s:SplitJoin(a:str, '-')
endfunction

function! s:Dotify(str)
    return s:SplitJoin(a:str, '.')
endfunction

function! s:Slashify(str)
    return s:SplitJoin(a:str, '/')
endfunction

function! s:SplitJoin(str, separator)
    return join(s:Sanitize(a:str), a:separator)
endfunction

function! s:FreeBallIt(str)
    echom 'Choose the character to use:'
    let l:separator = nr2char(getchar())

    return join(s:Sanitize(a:str), l:separator)
endfunction

function! s:Inflect(type, ...)
    " save state
    let l:saved_selection = &selection
    let l:saved_register = @@
    let l:winview = winsaveview()

    let l:inflections = {
                \ '.': 's:Dotify',
                \ '-': 's:Dasherize',
                \ '_': 's:Underscore',
                \ '/': 's:Slashify',
                \ 'C': 's:Constantize',
                \ 'c': 's:Camelize',
                \ 'n': 's:Normalize',
                \ 'p': 's:Privatize',
                \ 'P': 's:Pascalize',
                \ 't': 's:Titleize',
                \ 'f': 's:FreeBallIt',
                \ }

    " get inflection type
    echom 'Select Inflection (' . join(keys(l:inflections)) . '):'
    let l:inflection = nr2char(getchar())

    " return early on invalid inflection
    if ! has_key(l:inflections, l:inflection)
        echom 'Invalid option' | return
    endif

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gvy"
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    else
        silent exe "normal! `[v`]y"
    endif

    " call inflector
    let l:InflectionFunction = function(l:inflections[l:inflection])
    let l:result = l:InflectionFunction(@@)

    " set result in clipboard
    call setreg('@', l:result, getregtype('@'))

    " replace old text with result
    normal! `[v`]p

    " restore previous state
    let @@ = l:saved_register
    call winrestview(l:winview)

    " clear command line
    echom ''
endfunction

" export plugin mappings
nnoremap <silent> <Plug>(Inflect) :set opfunc=<SID>Inflect<Enter>g@
vnoremap <silent> <Plug>(Inflect) :<C-U>call <SID>Inflect(visualmode(), 1)<Enter>

" Create user mappings
if exists('g:inflector_mapping')
    execute 'nmap ' . g:inflector_mapping .  ' <Plug>(Inflect)'
    execute 'vmap ' . g:inflector_mapping .  ' <Plug>(Inflect)'
endif
