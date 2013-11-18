let g:tdd_autorun = []

" Launches tests for a file
" Files configured to always run (tdd_autorun) are ran first
" Optionally launches prerun command first, and optionally clears output
" TODO map inside here?
function! tdd#launch(file) "{{{
    if g:tdd_test_command == '' || g:tdd_map_callback == ''
        return
    endif

    let l:testpath = a:file
    let l:testfiles = [l:testpath]
    let l:runfiles = []

    for i in g:tdd_autorun
        call add(l:testfiles, i)
    endfor

    for i in l:testfiles
        if filereadable(i)
            call add(l:runfiles, i)
        endif
    endfor

    if len(l:runfiles)
        let l:command_prefix = ''
        if g:tdd_prerun && !empty(g:tdd_prerun_command)
            let l:command_prefix = g:tdd_prerun_command . '; '
        endif
        if g:tdd_clear
            let l:command_prefix = l:command_prefix . 'clear; '
        endif

        if !empty(g:tdd_fail_command)
            let l:run = l:command_prefix . g:tdd_test_command . ' ' . join(l:runfiles, ' ') . ' || ' . g:tdd_fail_command
        else
            let l:run = l:command_prefix . g:tdd_test_command . ' ' .  join(l:runfiles, ' ')
        endif
        call tdd#tmux#send(l:run)
    endif
endfunction "}}}

" Test a single file directly in vim
" TODO refactor command building into priv method
function! tdd#inline(file) "{{{
    if g:tdd_test_command == ''
        echom "No test command defined"
        return
    endif
    if g:tdd_map_callback == ''
        echom "No mapping function defined"
        return
    endif

    let l:command_prefix = ''
    if g:tdd_prerun && !empty(g:tdd_prerun_command)
        let l:command_prefix = g:tdd_prerun_command . '; '
    endif
    if g:tdd_clear
        let l:command_prefix = l:command_prefix . 'clear; '
    endif

    let l:file = tdd#map_file(a:file)
    let l:run = l:command_prefix . g:tdd_test_command . ' ' . l:file

    execute "!" . l:run
endfunction "}}}

" Finds the test file for a given file
" Delegates to user-defined function defined by g:tdd_map_callback
function! tdd#map_file(file) "{{{
    execute "let g:tdd_mapped = " . g:tdd_map_callback . "('" . a:file . "')"
    return g:tdd_mapped
endfunction "}}}

" Opens a split with the file on the right
" If file does not exist, file and parent directories are automatically created
function! tdd#open_split(file) "{{{
    if filereadable(a:file)
        execute ':vs ' . a:file
        return
    endif

    let l:dir = system('dirname ' . a:file)
    call system('mkdir -p ' . l:dir)
    call system('touch ' . a:file)
    execute ':vs ' . a:file
endfunction "}}}

" Enables auto-testing for given file
function! tdd#autotest_add(file) "{{{
    call add(g:tdd_autorun, a:file)
endfunction "}}}

" Disables auto-testing for given file
function! tdd#autotest_remove(file) "{{{
    let l:new_autorun = []
    for i in g:tdd_autorun
        if i != a:file
            call add(l:new_autorun, a:file)
        endif
    endfor

    let g:tdd_autorun = l:new_autorun
endfunction "}}}

" Toggles auto-testing for given file
function! tdd#autotest_toggle(file) "{{{
    if index(g:tdd_autorun, a:file) == -1
        call tdd#autotest_add(a:file)
    else
        call tdd#autotest_remove(a:file)
    endif
endfunction "}}}

" Toggles auto-restarting before running tests
function! tdd#toggle_prerun() "{{{
    let g:tdd_prerun = !g:tdd_prerun
endfunction "}}}

" Removes all auto-test files at once
function! tdd#autotest_empty() "{{{
    let g:tdd_autorun = []
endfunction "}}}

