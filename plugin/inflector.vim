function! Constantize(str)
    return toupper(substitute(a:str, '\s', '_', 'g'))
endfunction

function! Camelize(str)
    return join(map(split(a:str, '\s'), 'Capitalize(v:val)'), '')
endfunction

function! Capitalize(word)
    return substitute(a:word, '\w', '\=toupper(submatch(0))', '')
endfunction

function! Titleize(str)
    return join(map(split(a:str, '\s'), 'Capitalize(v:val)'), ' ')
endfunction

function! Privatize(str)
    return a:str =~ '^_' ? a:str : '_' . a:str
endfunction

function! Underscore(str)
    return join(split(a:str, ' '), '_')
endfunction
