" Plugin that improved vim spelling.
" Version 1.0.0
" Author kamykn
" License VIM LICENSE

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! s:winid2tabnr(win_id) abort
  return win_id2tabwin(a:win_id)[1]
endfunction

function! s:on_exit(code, floating_win_id, callback) abort
	if a:code == 0
		let l:stdout = getline(1)
		call nvim_win_close(a:floating_win_id, v:true)
		call a:callback(l:stdout)
	endif
endfunction

function! s:max_word_length(choices) abort
	let l:len = 1

	for l:choice in a:choices
		let l:len = max([l:len, strlen(l:choice)])
	endfor

	return l:len
endfunction

function! floating_menu#open(callback, choices) abort
	if has('nvim')
		let l:buf = nvim_create_buf(v:false, v:true)
		let l:opts = {
			\ 'relative': 'cursor',
			\ 'width': s:max_word_length(a:choices),
			\ 'height': len(a:choices),
			\ 'col': 0,
			\ 'row': 1,
			\ 'style': 'minimal'
			\ }
		let l:floating_win_id = nvim_open_win(l:buf, v:false, l:opts)
		let l:win = s:winid2tabnr(l:floating_win_id)

		" window focus
		execute l:win . 'windo :'
		setlocal laststatus=0
		setlocal scrolloff=0

		call termopen(g:floating_menu_plugin_path . "/src/src " . join(a:choices, ' '), {
			\ 'on_exit': {id, code, event -> s:on_exit(code, l:floating_win_id, a:callback)}
			\ })
		startinsert
	endif
endfunction

function! s:test_callback(selected) abort
	enew
	execute ":normal i" . a:selected
endfunction

function! floating_menu#test() abort
	call floating_menu#open({selected -> s:test_callback(selected)}, ['aaa', 'bbbbbb', 'c', 'dddd', 'eeeeeeeeeeeee'])
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
