scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! s:test_callback(selected) abort
	enew
	execute ":normal i" . a:selected
endfunction

function! test#floating_menu#test() abort
	call floating_menu#open({selected -> s:test_callback(selected)}, ['aaa', 'bbbbbb', 'c', 'dddd', 'eeeeeeeeeeeee'])
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
