scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! s:test_callback(selected) abort
	enew
	execute ":normal i" . a:selected
endfunction

function! test#floating_menu#test() abort
	let l:list = ['aaa', 'bbbbbb', 'c', 'dddd', 'eeeeeeeeeeeee']
	call floating_menu#open(l:list, {selected -> s:test_callback(selected)}, {})
endfunction

function! test#floating_menu#test_args() abort
	let l:list = ['aaa', 'bbbbbb', 'c', 'dddd', 'eeeeeeeeeeeee']
	call floating_menu#open(l:list,
				\ {selected -> s:test_callback(selected)},
				\ {
				\ 	'relative': 'editor',
				\ 	'width': 30,
				\ 	'height': 7,
				\ 	'col': 5,
				\ 	'row': 5
				\ })
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
