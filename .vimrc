syntax on
colorscheme PaperColor
set encoding=utf-8
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

autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Map leader key
let mapleader="/"

" Easy write, quit and remove highlights
map <leader>w :w<cr>
map <leader>q :q<cr>
map <leader>h :noh<cr>

" Cursor navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Tab navigation
map <leader>t :tabnew<cr>
map <leader>a :tabprevious<cr>
map <leader>d :tabnext<cr>

" Directory tree
let g:netrw_liststyle=3
nnoremap <C-T> :NERDTreeToggle<cr>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Web search
nnoremap <C-W> :WebSearchCursor<cr>

" Vim-Diff
function GvrVimDiff()
	set guifont=Andale_Mono:h8:w4.5 columns=165
endfun

function GvrVimUnDiff()
	set guifont=Bitstream_Vera_Sans_Mono:h10 columns=80
endfun

if &diff
	call GvrVimDiff()
endif

" Undotree
nnoremap <F5> :UndotreeToggle<cr>

if has("persistent_undo")
    set undodir=$HOME."/.vim/undos"
    set undofile
endif

" Whitespace
function TrimWhitespace()
	let l:save = winsaveview()
	try
		" Remove trailing whitespace
		keeppatterns %s/\s\+$//g
		" Replace 4 spaces with tabs
		keeppatterns %s/ \{4}/\t/g
		" Remove multiple spaces
		keeppatterns %s/ \{2,}/ /g
	catch
	endtry
	call winrestview(l:save)
endfun

noremap <leader>e :call TrimWhitespace()<cr>

" enable cursorline (L) and cmdline help (H)
let g:quickmenu_options = "LH"

" clear all the items
call g:quickmenu#reset()

" bind to F12
noremap <silent><F12> :call quickmenu#toggle(0)<cr>

" section 1, text starting with "#" represents a section (see the screen capture below)
call g:quickmenu#append('# Develop', '')

call g:quickmenu#append('item 1.1', 'echo "1.1 is selected"', 'select item 1.1')
call g:quickmenu#append('item 1.2', 'echo "1.2 is selected"', 'select item 1.2')
call g:quickmenu#append('item 1.3', 'echo "1.3 is selected"', 'select item 1.3')

" section 2
call g:quickmenu#append('# Misc', '')

call g:quickmenu#append('item 2.1', 'echo "2.1 is selected"', 'select item 2.1')
call g:quickmenu#append('item 2.2', 'echo "2.2 is selected"', 'select item 2.2')
call g:quickmenu#append('item 2.3', 'echo "2.3 is selected"', 'select item 2.3')
call g:quickmenu#append('item 2.4', 'echo "2.4 is selected"', 'select item 2.4')

" Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
	Plug 'dart-lang/dart-vim-plugin'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'linluk/vim-websearch'
	Plug 'Valloric/YouCompleteMe'
	Plug 'scrooloose/nerdtree'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'airblade/vim-gitgutter'
	Plug 'chrisbra/vim-commentary'
	Plug 'sirver/ultisnips'
	Plug 'skywind3000/quickmenu.vim'
	Plug 'mbbill/undotree'
	Plug 'tpope/vim-surround'
	Plug 'auxiliary/vim-layout'
call plug#end()
