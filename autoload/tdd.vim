let g:tdd_autorun = []

" Launches tests for a file
" Files configured to always run (tdd_autorun) are ran first
" Optionally launches prerun command first, and optionally clears output
function! tdd#launch(file) "{{{
    if g:tdd_test_command == ''
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
        call tdd#tmux_send(l:run)
    endif
endfunction "}}}

" Finds the test file for a given file
" Delegates to user-defined function defined by g:tdd_map_callback
function! tdd#map_file(file) "{{{
    execute "let g:tdd_mapped = " . g:tdd_map_callback . "('" . a:file . "')"
    return g:tdd_mapped
endfunction "}}}

" Default file mapper when nothing is configured
" Warns user
function! tdd#map_file_undefined(file) "{{{
    echo "Not configured; let g:tdd_map_callback = 'YourFunction'"
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

" Sets the tmux target pane
" Tmux expects 'session:window.panel'
function! tdd#tmux_set_target(target) "{{{
    let g:tdd_tmux_target = a:target
endfunction "}}}

" Toggles auto-restarting before running tests
function! tdd#toggle_prerun() "{{{
    let g:tdd_prerun = !g:tdd_prerun
endfunction "}}}

" Removes all auto-test files at once
function! tdd#autotest_empty() "{{{
    let g:tdd_autorun = []
endfunction "}}}

" Sends a command over Tmux
function! tdd#tmux_send(cmd) "{{{
    let l:panes = tdd#tmux_count_panes()
    " TODO better error handling; this is assuming we're using .1
    if l:panes > 1 || strlen(g:tdd_tmux_target)
        call system('tmux send-keys -t ' . tdd#tmux_get_target() . ' "' . a:cmd . '" Enter')
    endif
endfunction "}}}

" Counts the number of panes in Tmux
function! tdd#tmux_count_panes() "{{{
    return len(split(system('tmux list-panes'), "\n"))
endfunction "}}}

" Gets the tmux target to use
" Attempts to fallback on current window's second (bottom, typically) pane
function! tdd#tmux_get_target() "{{{
    if strlen(g:tdd_tmux_target)
        return g:tdd_tmux_target
    endif
    let l:windows = split(system('tmux list-windows'), "\n")
    for windowinfo in l:windows
        if windowinfo =~ ".*active.*"
            return "0:" . windowinfo[0] . ".1"
        endif
    endfor
endfunction "}}}
