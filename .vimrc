set number relativenumber "relative line numbers on the LHS
syntax on "syntax highlighting
set clipboard+=unnamedplus "alias the unnamed register to the '+' register which is the X Window clipboard
set ignorecase "ignore case while searching
set tabstop=2 "number of spaces per tab
set shiftwidth=0 "required to enforce tabstop as default number of spaces for indentation
set expandtab "required to enforce tabstop as default number of spaces for indentation
set mouse=a "ability to click to direct prompt
autocmd BufWritePre * %s/\s\+$//e "automatically deletes all trailing whitespace on save.

