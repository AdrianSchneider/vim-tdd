# Overview
This plugin aids test-driven development by allowing you to run tests in tmux panes without getting in the way. This is by no means a full solution, but should provide a framework to create a workflow that fits your needs.

# Installation

Pathogen:

    cd ~/.vim/bundle
    git clone git://github.com/AdrianSchneider/vim-tdd.git

Vundle:

    Bundle 'AdrianSchneider/vim-tdd'

# Features
- run tests synchronously in vim, or asynchronously through tmux
- run tests manually or automatically on save
- open (and create) test in split
- add other related files to test list
- auto detect bottom tmux pane, or override with config

# Language Configuration
Basic PHP and Javascript support is included. Each language must configure `g:tdd_test_command`, and `g:tdd_map_callback`. See included ones as an example.

# Basic Usage

`<leader>ts` opens test in split  
`<leader>tt` add current file to auto-test list  
`<leader>t-` empty auto-test list  
`<leader>ti` test file directly in vim

# Documentation
Run `:help tdd` to see more advanced usage and configuration options.
