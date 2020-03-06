# popup-menu.nvim

<img src="https://github.com/kamykn/popup-menu.nvim/blob/master/img/top.png?raw=true" width=680>

## 1 Installation
**vim-plug**

```vim
Plug 'kamykn/popup-menu.nvim'
```

**NeoBundle**
```vim
NeoBundle 'kamykn/popup-menu.nvim'
```

## 2 Usage
### 2.1 Simple usage

```vim
" This is a sample callback function
function! s:callback(selected) abort
	echo a:selected
endfunction

let list = ['aaa', 'bbb', 'ccc', 'ddd', 'eee']
call popup_menu#open(list, {selected -> s:my_callback(selected)})
```

### 2.2 Floating window options
It can use 3rd argument as same settings as [nvim_open_win()](https://neovim.io/doc/user/api.html#nvim_open_win()).

```vim
call popup_menu#open(
		\ list,
		\ {selected -> s:my_callback(selected)},
		\ {
		\ 	'relative': 'editor',
		\ 	'width': 30,
		\ 	'height': 7,
		\ 	'col': 5,
		\ 	'row': 5
		\ })
```

### 2.3 Sample using Vim8 popup_menu()

```vim
" list for popup menu.
let list = [apple, banana, orange]

if exists('*popup_menu')
    " Vim
    let callback_fn = {win_id, index -> s:my_callback_idx(index)}
    call popup_menu(list, #{
        \ callback: callback_fn,
        \ ...
        \ })
elseif has('nvim') && exists('g:loaded_popup_menu_plugin')
    " Neovim
    " g:loaded_popup_menu_plugin is defined by popup-menu.nvim.
    let callback_fn = {selected_str -> s:my_callback_str(selected_str)}
    call popup_menu#open(list, callback_fn)
else
    " Old vim/neovim
    let index = inputlist(...)
    call s:my_callback_idx(index)
endif
```

### 2.4 Style
The style is same as `PMenu` and `PMenuSel`.
However, only `ctermbg` and `ctermfg` are used.

```vim
hi Pmenu ctermfg=254 ctermbg=237 cterm=NONE guifg=#e1e1e1 guibg=#383838 gui=NONE
hi PmenuSel ctermfg=135 ctermbg=239 cterm=NONE guifg=#b26eff guibg=#4e4e4e gui=NONE
```
