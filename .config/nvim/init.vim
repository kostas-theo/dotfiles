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

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" coc extensions
let g:coc_global_extensions = [
      \'coc-yaml',
      \'coc-tsserver',
      \'coc-go',
      \'coc-json',
      \]
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient (coc)
let g:go_def_mapping_enabled = 0
" custom fzf search window
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset':0.5, 'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
" more natural splitting
set splitright
set splitbelow
" custom fzf.vim Rg function which disables quoting the arguments
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --hidden --color=always --smart-case -- '.(len(<q-args>) > 0 ? <q-args> : '""'), 1,
  \   fzf#vim#with_preview(), <bang>0)
" use rg as grep program
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m
" custom mappings
nmap <leader>O :Files<CR>
nmap <leader>F :Rg<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-j> <C-w>w

" --------------------------------------------------------
" COC-VIM TAB SETTINGS START
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
" use <tab> to trigger completion and navigate to the next complete item
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" use <cr> (return) to confirm coc selection
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" use <s-tab> to highlight previous suggestion
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" COC-VIM TAB SETTINGS END
" --------------------------------------------------------
