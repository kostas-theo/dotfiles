set runtimepath^=~/.vim runtimepath+=~/.vim/after
call plug#begin('~/.vim/plugged')
Plug 'NLKNguyen/papercolor-theme'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
set tabstop=2 "number of spaces per tab
set shiftwidth=0 "required to enforce tabstop as default number of spaces for indentation
set expandtab "required to enforce tabstop as default number of spaces for indentation
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

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient (coc)
let g:go_def_mapping_enabled = 0
