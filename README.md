# popup-menu.nvim

<img src="https://github.com/kamykn/popup-menu.nvim/blob/master/img/top.png?raw=true" width=680>

## 1 Installation
**vim-plug**

```
Plug 'kamykn/popup-menu.nvim'
```

**NeoBundle**
```
NeoBundle 'kamykn/popup-menu.nvim'
```

## 2 Usage
### 2.1 Simple usage

```
" This is a sample callback function
function! s:callback(selected) abort
	echo a:selected
endfunction

let l:list = ['aaa', 'bbb', 'ccc', 'ddd', 'eee']
call popup_menu#open(l:list, {selected -> s:my_callback(selected)})
```

### 2.2 Floating window options
It can use 3rd args as same settings as `nvim_open_win()`.

```
call popup_menu#open(
		\ l:list,
		\ {selected -> s:my_callback(selected)},
		\ {
		\ 	'relative': 'editor',
		\ 	'width': 30,
		\ 	'height': 7,
		\ 	'col': 5,
		\ 	'row': 5
		\ })
```

### 2.3 Style
The style is same as `PMenu` and `PMenuSel`.
However, only `ctermbg` and `ctermfg` are used.

```
hi Pmenu ctermfg=254 ctermbg=237 cterm=NONE guifg=#e1e1e1 guibg=#383838 gui=NONE
hi PmenuSel ctermfg=135 ctermbg=239 cterm=NONE guifg=#b26eff guibg=#4e4e4e gui=NONE
```
