" tdd.vim - TDD Helpers
" Author: Adrian Schneider <http://adrianschneider.ca>
" Version: 1.0

if !exists("g:tdd_skip_mappings")
    nmap <leader>ti :TddInline<cr>
    nmap <leader>ts :TddSplit<cr>
    nmap <leader>tt :TddToggle<cr>
    nmap <leader>t- :TddEmpty<cr>
endif

if !exists("g:tdd_skip_onsave")
    autocmd BufWritePost * TddTest
endif

" Commands
command! -nargs=0 TddTest   call tdd#launch(expand('%:.'))
command! -nargs=0 TddSplit  call tdd#open_split(expand('%:.'))
command! -nargs=0 TddInline call tdd#inline(expand('%:.'))
command! -nargs=1 TddTarget call tdd#tmux#set_target(<f-args>)
command! -nargs=0 TddToggle call tdd#autotest_toggle(expand('%:.'))
command! -nargs=0 TddEmpty  call tdd#autotest_empty()

" Command to run tests with [command] [filename]
if !exists("g:tdd_test_command")
    let g:tdd_test_command = ''
endif
"
" Sets the file mapper (file or test file -> test file)
if !exists("g:tdd_map_callback")
    let g:tdd_map_callback = ''
endif

" Automatically clear test screen before testing
if !exists("g:tdd_clear")
    let g:tdd_clear = 1
endif

" Toggles pre-run before test command runs
if !exists("g:tdd_prerun")
    let g:tdd_prerun = 0
endif

" Sets command to run before tests (ie, restart server)
if !exists("g:tdd_prerun_command")
    let g:tdd_prerun_command = ''
endif

" Sets command to run on failure
if !exists("g:tdd_fail_command")
    let g:tdd_fail_command = 'beep'
endif

" Sets the default pane to use for testing
if !exists("g:tdd_tmux_pane")
    let g:tdd_tmux_pane = 1
endif

" Or, explicitly specify target overriding above
if !exists("g:tdd_tmux_target")
    let g:tdd_tmux_target = '' " session:window.pane
endif

