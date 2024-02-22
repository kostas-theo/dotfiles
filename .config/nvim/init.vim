let mapleader =","

let data_dir = stdpath('config')
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'NLKNguyen/papercolor-theme'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" was like this, tried to fix due to failing in arch
" https://github.com/junegunn/vim-plug/issues/1070
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf', { 'do': 'yes \| ./install --xdg' }
Plug 'junegunn/fzf.vim'
"Plug 'tpope/vim-sleuth'
call plug#end()

" colors
"
set background=dark
colorscheme PaperColor

" settings
"

set number relativenumber "relative line numbers on the LHS
set clipboard+=unnamedplus "alias the unnamed register to the '+' register which is the X Window clipboard
set ignorecase "ignore case while searching
"set tabstop=2 "number of spaces per tab
"no longer required thanks to sleuth set shiftwidth=0 "required to enforce tabstop as default number of spaces for indentation
"no longer required thanks to sleuth set expandtab "required to enforce tabstop as default number of spaces for indentation

" Use spaces instead of tabs
set expandtab
" Be smart when using tabs
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set mouse=a "ability to click to direct prompt

filetype on "detect files based on type
filetype plugin on "when a file is edited its plugin file(s) are loaded
filetype indent on "enables maintaining specific indentation per filetype
autocmd BufWritePre * %s/\s\+$//e "automatically deletes all trailing whitespace on save.

" coc.nvim default settings
"
set hidden "if hidden is not set, TextEdit might fail.
set cmdheight=2 "Better display for messages
set updatetime=300 "Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c "don't give |ins-completion-menu| messages.
set signcolumn=yes "always show signcolumns
