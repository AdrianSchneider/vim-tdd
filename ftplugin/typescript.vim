" Use built in mapper
let g:tdd_map_callback = 'tdd#lang#javascript#map'

" Use mocha, installed by npm
let g:tdd_test_command = 'mocha --compilers ts:ts-node/register,tsx:ts-node/register '
