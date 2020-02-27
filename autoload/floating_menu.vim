" Plugin that improved vim spelling.
" Version 1.0.0
" Author kamykn
" License VIM LICENSE

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! s:exec_menu(command, on_exit, callback) abort
	if has('nvim')
		enew
		call termopen(a:command, {'on_exit': {id, code, event -> a:on_exit(code, a:callback)}})
		startinsert
	endif
endfunction

function! s:on_exit(code, callback) abort
	if a:code == 0
		let l:stdout = getline(1)
		" buffer閉じる
		call feedkeys("\<CR>")
		call a:callback(l:stdout)
	endif
endfunction

function! floating_menu#open(callback) abort
	let l:command = g:floating_menu_plugin_path . "/src/src aaa bbb ccc ddd"
	call s:exec_menu(l:command, {code, callback -> s:on_exit(code, callback)}, a:callback)
endfunction

function! s:test_callback(stdout) abort
	enew
	execute ":normal i" . a:stdout
endfunction

function! floating_menu#test() abort
	call floating_menu#open({stdout -> s:test_callback(stdout)})
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
