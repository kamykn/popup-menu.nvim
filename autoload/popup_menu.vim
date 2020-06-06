scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

let s:popup_menu_plugin_path = expand('<sfile>:p:h:h')

function! s:winid2tabnr(win_id) abort
	return win_id2tabwin(a:win_id)[1]
endfunction

function! s:on_exit(code, popup_win_id, Callback) abort
	let &laststatus = s:laststatus
	let &scrolloff = s:scrolloff
	let &shellslash = s:shellslash

	let l:stdout = getline(1)

	" delete buffer #2
	let l:buf_id = bufnr('%')
	call nvim_win_close(a:popup_win_id, v:false)
	execute 'bdelete! ' . l:buf_id

	if a:code == 0
		call a:Callback(l:stdout)
	else
		echoerr l:stdout
		return
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

	if s:bin_path == v:null
		echoerr "Binary path not found."
		return
	endif

	let l:choices = a:1
	let l:Callback = a:2
	let l:win_opt = a:0 >= 3 ? a:3 : {}

	let l:buf_id = nvim_create_buf(v:false, v:true)
	let l:popup_win_id = nvim_open_win(l:buf_id, v:false, s:init_win_opt(l:choices, l:win_opt))
	let l:win = s:winid2tabnr(l:popup_win_id)

	" window focus
	execute l:win . 'windo :'
	let s:laststatus = &laststatus
	let s:scrolloff = &scrolloff
	let s:sidescrolloff = &sidescrolloff
	set laststatus=0
	set scrolloff=0
	set sidescrolloff=0

	let l:color_settings = [
				\ synIDattr(hlID('Pmenu'), 'bg', 'cterm'),
				\ synIDattr(hlID('Pmenu'), 'fg', 'cterm'),
				\ synIDattr(hlID('PmenuSel'), 'bg', 'cterm'),
				\ synIDattr(hlID('PmenuSel'), 'fg', 'cterm'),
				\ ]

	try
		" windows support (only this buffer)
		let s:shellslash = &shellslash
		set shellslash

		let l:ext = ''
		if s:bin_path == 'bin/win-amd64' || s:bin_path == 'bin/win-386'
			let l:ext = '.exe'
		endif

		let cmd = '"' . s:popup_menu_plugin_path . '/' . s:bin_path . '/tui-select' . l:ext . '" ' . s:get_shell_args_str(l:color_settings) . ' ' . s:get_shell_args_str(l:choices)
		call termopen(cmd, {
					\ 'on_exit': {id, code, event -> s:on_exit(code, l:popup_win_id, l:Callback)},
					\ })

		" set buffer name
		file pmenu-nvim
		startinsert
	catch
		call nvim_win_close(l:popup_win_id, v:true)
		echomsg 'error occurred:' . v:exception
	endtry
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

	" windowsで極力外部コマンドを実行したくないのでここで判定できればここで
	if has('win32')
		let l:path = 'bin/win-386'
	elseif has('win64')
		let l:path = 'bin/win-amd64'
	else
		let l:archi_info = trim(system('"' . s:popup_menu_plugin_path . '/script/archi_info.sh"'))
		if l:archi_info != '' && (
				\ l:archi_info == 'darwin-amd64'  ||
				\ l:archi_info == 'darwin-386'    ||
				\ l:archi_info == 'linux-arm5'    ||
				\ l:archi_info == 'linux-arm6'    ||
				\ l:archi_info == 'linux-arm7'    ||
				\ l:archi_info == 'linux-amd64'   ||
				\ l:archi_info == 'linux-386'     ||
				\ l:archi_info == 'freebsd-amd64' ||
				\ l:archi_info == 'freebsd-386'   ||
				\ l:archi_info == 'openbsd-amd64' ||
				\ l:archi_info == 'openbsd-386'   ||
				\ l:archi_info == 'win-386'   ||
				\ l:archi_info == 'win-amd64'
				\ )
			let l:path = 'bin/' . l:archi_info
		endif
	endif

	return l:path
endfunction

" select buffer
let s:bin_path = s:get_bin_path()

let &cpo = s:save_cpo
unlet s:save_cpo
