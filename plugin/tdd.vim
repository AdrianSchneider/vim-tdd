" tdd.vim - TDD Helpers
" Author: Adrian Schneider <http://adrianschneider.ca>
" Version: 1.0

" Command to run tests with [command] [filename]
let g:tdd_test_command = ''

" Automatically clear test screen before testing
let g:tdd_clear = 1

" Toggles pre-run before test command runs
let g:tdd_prerun = 0

" Sets command to run before tests (ie, restart server)
let g:tdd_prerun_command = ''

" Sets command to run on failure
let g:tdd_fail_command = 'beep'

" Sets the default pane to use for testing
let g:tdd_tmux_pane = 1

" Or, explicitly specify target overriding above
let g:tdd_tmux_target = '' " session:window.pane

" Sets the file mapper (file or test file -> test file)
let g:tdd_map_callback = ''

" Open test in split
nmap <leader>ts :call tdd#open_split(tdd#map_file(expand('%:.')))<cr>

" Add this file to auto-test
nmap <leader>tt :call tdd#autotest_toggle(expand('%:.'))<cr>

" Empty auto-test list of files
nmap <leader>t- :call tdd#autotest_empty()<cr>

" Run test inside vim
nmap <leader>ti :call tdd#inline(tdd#map_file(expand('%:.')))<cr>

autocmd BufWritePost * execute "call tdd#launch(tdd#map_file(expand('%s:.')))"
