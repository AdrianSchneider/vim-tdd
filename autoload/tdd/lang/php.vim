if !exists("g:tdd_php_testdir")
    let g:tdd_php_testdir = 'tests'
endif

" Basic mapper which converts
" src/Path/To/Class.php to test/Path/To/ClassTest.php
function! tdd#lang#php#map(file) "{{{
    " already have the test
    if a:file =~ "Test\.php$"
        return a:file
    endif

    let l:parts = split(a:file, '/')
    let l:out = []

    for part in parts
        if part == 'src' || part == 'lib'
            let part = g:tdd_php_testdir
        endif
        call add(l:out, part)
    endfor

    return join(l:out, '/')[:-5] . 'Test.php'
endfunction "}}}
