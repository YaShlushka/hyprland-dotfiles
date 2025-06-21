call plug#begin('~/.local/share/nvim/plugged')

Plug 'https://github.com/trope/vim-commentary' " комментарии
Plug 'https://github.com/preservim/nerdtree' "дерево файлов
Plug 'https://github.com/vim-airline/vim-airline' " красивая нижняя панель
Plug 'https://github.com/trope/vim-surround' " удобная работа со скобками и кавычками
Plug 'https://github.com/jiangmiao/auto-pairs' " автодополнение ({[ и т.д.
Plug 'https://github.com/folke/tokyonight.nvim' " тема tokyonight
Plug 'https://github.com/ryanoasis/vim-devicons' " иконки
Plug 'https://github.com/vim-airline/vim-airline-themes' " темы для vim-airline

call plug#end()

set number
set encoding=UTF-8
set shiftwidth=3
set tabstop=3

syntax on

nnoremap <C-t> :NERDTreeToggle<CR>
autocmd FileType nerdtree nnoremap <buffer> <2-LeftMouse> :call NERDTreeDoubleClick()<CR>

function! NERDTreeDoubleClick()
	let node = g:NERDTreeFileNode.GetSelected()
	if empty(node)
		return
	endif

	if node.path.isDirectory
		call node.activate() " папка раскрывается
	else
		execute 'tabnew' node.path.str()
	endif
endfunction

let g:airline_theme = 'deus'

" vim surround

vnoremap <silent> ( <Esc>`>a)<Esc>`<i(<Esc>a

vnoremap <silent> { <Esc>`>a}<Esc>`<i{<Esc>a

vnoremap <silent> [ <Esc>`>a]<Esc>`<i[<Esc>a

vnoremap <silent> " <Esc>`>a"<Esc>`<i"<Esc>a

vnoremap <silent> ' <Esc>`>a'<Esc>`<i'<Esc>a

"autoairs

augroup AutoPairsFileTypes
	autocmd!
	autocmd FileType c,cpp,h,hpp,css,cs,python,lua,javascript,typescript,rust,go,php,ruby,sh,zsh let b:autopairs_enabled = 1
	autocmd FileType text,markdown let b:autopairs_anebled = 0
augroup END

" выделение на ctrl+a

nnoremap<C-a> ggVG
inoremap <C-a> <Esc>ggVG

" удаление на backspace при выделении

vnoremap <BS> d

" Включить поддержку буфера обмена (clipboard)
set clipboard=unnamedplus  " Использует системный буфер (требует `xclip` или `wl-clipboard`)

" Копирование в системный буфер по Ctrl+C (в Visual режиме)
vnoremap <C-c> "+y
set clipboard=unnamedplus

lua << EOF
require('tokyonight').setup({
	style = 'moon', -- варианты night, storm, moon, day
	transparent = false, -- прозрачный фон
	terminal_colors = true,
})
vim.cmd('colorscheme tokyonight')
EOF
