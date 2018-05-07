"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
" 	Lazar Jelic  
"   jelic.ecloga@gmail.com
"   http://ecloga.org
" 	https://github.com/jelic98
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
colorscheme PaperColor
set t_Co=256
set background=dark
set number
set laststatus=2
set tabstop=4
set autoindent
set smarttab
set smartindent
set nocompatible
set shiftwidth=4
set showmatch
set splitbelow
set splitright
set smarttab
set wrap
set linebreak
set nolist
set smartcase
set ignorecase
set incsearch
set magic
set lazyredraw
set wildmenu
set ruler
set showmode
set colorcolumn=120
set hlsearch
set ttyfast
set autoread
set scrolloff=5
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set pastetoggle=<F3>
let mapleader="/"
let g:netrw_liststyle=3
map <leader>w :w<Enter>
nnoremap <NUL> :E<Enter> 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

function GvrVimDiff()
	set guifont=Andale_Mono:h8:w4.5 columns=165
endfun

function GvrVimUnDiff()
	set guifont=Bitstream_Vera_Sans_Mono:h10 columns=80
endfun

if &diff
	call GvrVimDiff()
endif

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
	Plug 'dart-lang/dart-vim-plugin'
	Plug 'terryma/vim-multiple-cursors'
call plug#end()
