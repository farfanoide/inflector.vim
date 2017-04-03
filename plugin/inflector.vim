function! Sanitize(str)
    if a:str =~ '\s'
        let l:separator = '\s'
    elseif a:str =~ '_\|-'
        let l:separator = '_\|-'
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
