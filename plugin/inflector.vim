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
    return join(s:Sanitize(a:str), '_')
endfunction

function! s:Dasherize(str)
    return join(s:Sanitize(a:str), '-')
endfunction

function! s:Dotify(str)
    return join(s:Sanitize(a:str), '.')
endfunction

function! s:Slashify(str)
    return join(s:Sanitize(a:str), '/')
endfunction


function! s:Inflect(type, ...)
    " save state
    let l:saved_selection = &selection
    let l:saved_register = @@
    let l:winview = winsaveview()

    let l:inflections = {
                \ '.': function('s:Dotify'),
                \ '-': function('s:Dasherize'),
                \ '_': function('s:Underscore'),
                \ '/': function('s:Slashify'),
                \ 'C': function('s:Constantize'),
                \ 'c': function('s:Camelize'),
                \ 'n': function('s:Normalize'),
                \ 'p': function('s:Privatize'),
                \ 'P': function('s:Pascalize'),
                \ 't': function('s:Titleize'),
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
    let l:result = l:inflections[l:inflection](@@)

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
