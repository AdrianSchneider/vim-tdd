" dir for tests
if !exists("g:tdd_js_dir")
    let g:tdd_js_dir = 'tests'
endif

" patterns to match testable files
if !exists("g:tdd_js_patterns")
    let g:tdd_js_patterns = ['^tests']
endif

" Basic mapper for javascript
" lib/to/filename.js to test/path/to/filename.js
" Only catches files matching g:tdd_js_patterns
function! tdd#lang#javascript#map(file) "{{{
    for prefix in g:tdd_js_patterns
        if a:file =~ prefix
            return a:file
        endif
    endfor
    return g:tdd_js_dir . '/' . a:file
endfunction "}}}
