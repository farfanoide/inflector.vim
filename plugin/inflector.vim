" if exists('g:loaded_inflector')
"   finish
" endif
" let g:loaded_inflector = 1

function! Sanitize(str)
    if a:str =~ '\s\|[._\-]'
        let l:separator = '\s\|[._\-]'
    else
        let l:separator = '[A-Z]\?[a-z]*\zs'
    endif
    return map(split(a:str, l:separator), 'tolower(v:val)')
endfunction

function! Constantize(str)
    return join(map(Sanitize(a:str), 'toupper(v:val)'), '_')
endfunction

function! Pascalize(str)
    return join(map(Sanitize(a:str), 'Capitalize(v:val)'), '')
endfunction

function! Camelize(str)
    return substitute(Pascalize(a:str), '^\w', '\=tolower(submatch(0))', '')
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

function! s:Inflect(type, ...)
    " Save stuff
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    " get inflection type
    echom 'Select Inflection (.,_,-,c,C,d,p,t):'
    let l:inflection = nr2char(getchar())

    " return early on invalid inflection
    if  l:inflection !~# '[._\-cCdpt]'
        echom 'Invalid option' | return
    endif

    let l:inflections = {
                \ '.': function('Dotify'),
                \ '-': function('Dasherize'),
                \ '_': function('Underscore'),
                \ 'C': function('Constantize'),
                \ 'c': function('Camelize'),
                \ 'd': function('Dotify'),
                \ 'p': function('Privatize'),
                \ 'P': function('Pascalize'),
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

" export plugin mappings
nnoremap <silent> <Plug>(Inflect) :set opfunc=<SID>Inflect<Enter>g@
vnoremap <silent> <Plug>(Inflect) :<C-U>call <SID>Inflect(visualmode(), 1)<Enter>
