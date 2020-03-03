scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

" 実行パス
let s:popup_menu_plugin_path = expand('<sfile>:p:h:h')

function! s:winid2tabnr(win_id) abort
  return win_id2tabwin(a:win_id)[1]
endfunction

function! s:on_exit(code, popup_win_id, Callback) abort
	if a:code == 0
		let l:stdout = getline(1)
		call nvim_win_close(a:popup_win_id, v:true)
		call a:Callback(l:stdout)
	endif
endfunction

function! s:max_word_length(choices) abort
	let l:len = 1

	for l:choice in a:choices
		let l:len = max([l:len, strlen(l:choice)])
	endfor

	return l:len
endfunction

function! s:init_win_opt(choices, win_opt) abort
	return {
		\ 'relative': s:get_key_with_default(a:win_opt, 'relative', 'cursor'),
		\ 'width':    s:get_key_with_default(a:win_opt, 'width', s:max_word_length(a:choices)),
		\ 'height':   s:get_key_with_default(a:win_opt, 'height',   len(a:choices)),
		\ 'col':      s:get_key_with_default(a:win_opt, 'col',      0),
		\ 'row':      s:get_key_with_default(a:win_opt, 'row',      1),
		\ 'style':    s:get_key_with_default(a:win_opt, 'style',    'minimal')
		\ }
endfunction

function! s:get_key_with_default(win_opt, key_name, default_value) abort
	return has_key(a:win_opt, a:key_name) ? a:win_opt[a:key_name] : a:default_value
endfunction

" a:1 = choices: list of strings
" a:2 = Callback: popup menu callback
" a:3 = win_opt: nvim_open_win() window options
function! popup_menu#open(...) abort
	" check args count
	if !has('nvim') || a:0 < 2
		return
	endif

	let l:choices = a:1
	let l:Callback = a:2
	let l:win_opt = a:0 >= 3 ? a:3 : {}

	let l:buf = nvim_create_buf(v:false, v:true)
	let l:popup_win_id = nvim_open_win(l:buf, v:false, s:init_win_opt(l:choices, l:win_opt))
	let l:win = s:winid2tabnr(l:popup_win_id)

	" window focus
	execute l:win . 'windo :'
	setlocal laststatus=0
	setlocal scrolloff=0

	let l:color_settings = [
				\ synIDattr(hlID('Pmenu'), 'bg', 'cterm'),
				\ synIDattr(hlID('Pmenu'), 'fg', 'cterm'),
				\ synIDattr(hlID('PmenuSel'), 'bg', 'cterm'),
				\ synIDattr(hlID('PmenuSel'), 'fg', 'cterm'),
				\ ]

	let cmd = '"' . s:popup_menu_plugin_path . '/' . s:get_bin_path() . '/tui-select" ' . s:get_shell_args_str(l:color_settings) . ' ' . s:get_shell_args_str(l:choices)
	call termopen(cmd, {
		\ 'on_exit': {id, code, event -> s:on_exit(code, l:popup_win_id, l:Callback)}
		\ })
	startinsert
endfunction

function! s:get_shell_args_str(choices) abort
	let l:choices = ''

	for l:choice in a:choices
		let l:choices = l:choices . ' ' . shellescape(l:choice)
	endfor

	return l:choices
endfunction

function! s:get_bin_path() abort
	let l:path = v:null

	if has('mac')
		let l:path = 'bin/darwin-amd64'
	elseif has ('linux')
		let l:path = 'bin/linux-amd64'
	endif

	if l:path == v:null
		echoerr "Binary not found."
	endif

	return l:path
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
