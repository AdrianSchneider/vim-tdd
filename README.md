# Overview
This plugin aids test-driven development by allowing you to run tests in tmux panes without getting in the way. It also provides a framework for configuring your test workflow in your language of choice.

# Installation
This plugin is pathogen and Vundle compatible.

# Features
- easily open (and create) test in split
- add other related files to auto-test
- use configured tmux pane, defaulting to best-guess

# Configuration
- tmux target
- auto clear before testing?
- pre-run command (ex: restart server)
- fail command (defaults to beep)

# Language Configuration
- test runner (ex: 'bin/phpunit')
- file mapper (callback which converts filename to test filename)

# Basic Usage

`<leader>ts` opens test in split
`<leader>tt` add current file to auto-test list
`<leader>t-` empty auto-test list
