" Plugin that improved vim spelling.
" Version 1.0.0
" Author kamykn
" License VIM LICENSE

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! floating_menu#open()
	execute '!' . g:floating_menu_plugin_path . "/src/src"
	return 1
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
