" Checking camel case words spelling.
" Version 1.0.0
" Author kamykn
" License VIM LICENSE

scriptencoding utf-8

if exists('g:loaded_floating_menu')
    finish
endif
let g:loaded_floating_menu = 1

let s:save_cpo = &cpo
set cpo&vim

" for Unit Test
if !exists('g:floating_menu_plugin_path')
    let g:floating_menu_plugin_path = expand('<sfile>:p:h:h')
endif

let &cpo = s:save_cpo
unlet s:save_cpo
