" dir for tests
let g:tdd_js_dir = 'test'

" patterns to match testable files
let g:tdd_js_patterns = ['^test']

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
