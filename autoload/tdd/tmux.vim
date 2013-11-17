" Sends a command over Tmux
" Stops silently if no pane or target is available
function! tdd#tmux#send(cmd) "{{{
    let l:panes = tdd#tmux#count_panes()
    if l:panes > 1 || strlen(g:tdd_tmux_target)
        call system('tmux send-keys -t ' . tdd#tmux#get_target() . ' "' . a:cmd . '" Enter')
    endif
endfunction "}}}

" Sets the tmux target pane
" Tmux expects 'session:window.panel'
function! tdd#tmux#set_target(target) "{{{
    let g:tdd_tmux_target = a:target
endfunction "}}}

" Gets the tmux target to use
" Uses configured tmux pane when available, otherwise defaults to 
" current window's g:tdd_tmux_pane (defaulting to 1)
function! tdd#tmux#get_target() "{{{
    if strlen(g:tdd_tmux_target)
        return g:tdd_tmux_target
    endif
    return tdd#tmux#get_session() . ":" . tdd#tmux#get_window() . '.' . g:tdd_tmux_pane
endfunction "}}}

" Gets the current window id from tmux
function! tdd#tmux#get_window() "{{{
    return tdd#tmux#trim(system('tmux display-message -p "#I"'))
endfunction "}}}

" Gets the current session id from tmux
function! tdd#tmux#get_session() "{{{
    return tdd#tmux#trim(system('tmux display-message -p "#S"'))
endfunction "}}}

" Gets the number of panes in current window
function! tdd#tmux#count_panes() "{{{
    return len(split(system('tmux list-panes'), "\n"))
endfunction "}}}

" Trim whitespace from str
function! tdd#tmux#trim(str) "{{{
    return substitute(a:str, '\n$', '', '')
endfunction "}}}
