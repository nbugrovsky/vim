call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" Regular Loading
Plug 'tpope/vim-fugitive'
Plug 'hashivim/vim-packer'
Plug 'hashivim/vim-terraform'
Plug 'townk/vim-autoclose'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'miyakogi/conoline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sickill/vim-monokai'
Plug 'bronson/vim-trailing-whitespace'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'hashivim/vim-vagrant', { 'for': 'ruby' }

" Initialize plugin system
call plug#end()
" map NERD Tree
map <C-n> :NERDTreeToggle<CR>
map <C-p> :CtrlP<CR>
" remap splits navigation
let mapleader = "\<Space>"
nnoremap <Leader>j <C-W><C-J>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>l <C-W><C-L>
nnoremap <Leader>h <C-W><C-H>

set nocompatible
set background=dark
colorscheme monokai


let g:xml_syntax_folding = 1
let g:conoline_auto_enable = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'
syntax on
filetype plugin on
set nofoldenable

"history and backup
set history=50
set backup
set backupdir=~/.vim/vimbackup/
set directory=~/.vim/vimswaps/

"tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set noexpandtab
"end tabs
set formatoptions=t
set encoding=utf-8
set hlsearch
set incsearch
set visualbell
set noerrorbells
"editor
set number
set ruler
set cursorline
set autoindent
set smartindent
set whichwrap=<,>,h,l
set backspace=2
set wildmenu
" matching brackets
set showmatch
set matchtime=3
"Remove all trailing whitespace by pressing F2
nnoremap <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
