set bg=light
set go=a
set mouse=a
set nohlsearch
set visualbell
set clipboard+=unnamedplus
set ruler
set rulerformat=%=%h%m%r%w\ %(%c%V%),%l/%L\ %P

" a - terse messages (like [+] instead of [Modified]
" t - truncate file names
" I - no intro message when starting vim fileless
" T - truncate long messages to avoid having to hit a key
"set shortmess=atTI

" display the number of (characters|lines) in visual mode, also cur command
set showcmd

" current mode in status line
set showmode

" max items in popup menu
"set pumheight=8

" show number column
set number
set numberwidth=3

" show fold column, fold by markers
"set foldcolumn=1
"set foldmethod=marker

" indicate when a line is wrapped by prefixing wrapped line with '> '
set showbreak=>\

" always show tab line
set showtabline=2

" highlight search matches
" https://github.com/lucasoman/Conf/blob/fa5d88d9cf0eb56569e76d60960dcafbfac1534b/.vimrc
set hlsearch
" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Spell-check set to <leader>o, 'o' for 'orthography':
	"map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" Defaults copied from https://github.com/LukeSmithxyz/voidrice/blob/archi3/.config/nvim/init.vim
