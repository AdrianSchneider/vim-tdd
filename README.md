# Overview
This plugin aids test-driven development by allowing you to run tests in tmux panes without getting in the way. It also provides a framework for configuring your test workflow in your language of choice. This is by no means a full solution, but should provide a framework to create a workflow that fits your needs.

# Installation

Pathogen:

    cd ~/.vim/bundle
    git clone git://github.com/AdrianSchneider/vim-tdd.git

Vundle:

    Bundle 'AdrianSchneider/vim-tdd'

# Features
- run tests on save, show results in another pane
- open (and create) test in split
- add other related files to test list
- auto detect tmux pane, or override with config

# Language Configuration
Basic PHP and Javascript support is included. Each language must configure `g:tdd_test_command`, and `g:tdd_map_callback`. See included ones as an example.

# Basic Usage

`<leader>ts` opens test in split
`<leader>tt` add current file to auto-test list
`<leader>t-` empty auto-test list

# Documentation
Run `:help tdd` to view more.
