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

" Reload vimrc on save
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Map leader key
let mapleader="/"

" Easy write, quit and remove highlights
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>n :noh<cr>

" Cursor navigation
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>

" Tab navigation
map <leader>t :tabnew<cr>
map <leader>c :tabclose<cr>
map <leader>a :tabprevious<cr>
map <leader>d :tabnext<cr>

" Directory tree
nnoremap <c-t> :NERDTreeToggle<cr>
let g:netrw_liststyle=3
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Web search
nnoremap <c-w> :WebSearchCursor<cr>

" Vim diff
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

" Trimming whitespace
noremap <leader>e :call TrimWhitespace()<cr>
function TrimWhitespace()
	let l:save = winsaveview()
	try
		keeppatterns %s/\s\+$//g
		keeppatterns %s/ \{4}/\t/g
		keeppatterns %s/ \{2,}/ /g
	catch
	endtry
	call winrestview(l:save)
endfun

" Quick menu
noremap <silent><F12> :call quickmenu#toggle(0)<cr>
let g:quickmenu_options = "LH"
call g:quickmenu#reset()
call g:quickmenu#append('# Develop', '')
call g:quickmenu#append('item 1.1', 'echo "1.1 is selected"', 'select item 1.1')
call g:quickmenu#append('item 1.2', 'echo "1.2 is selected"', 'select item 1.2')
call g:quickmenu#append('item 1.3', 'echo "1.3 is selected"', 'select item 1.3')
call g:quickmenu#append('# Misc', '')
call g:quickmenu#append('item 2.1', 'echo "2.1 is selected"', 'select item 2.1')
call g:quickmenu#append('item 2.2', 'echo "2.2 is selected"', 'select item 2.2')
call g:quickmenu#append('item 2.3', 'echo "2.3 is selected"', 'select item 2.3')
call g:quickmenu#append('item 2.4', 'echo "2.4 is selected"', 'select item 2.4')

" Ultisnips
let g:SuperTabCrMapping=0
let g:SuperTabDefaultCompletionType='<C-n>'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:ycm_key_list_select_completion=['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-k>', '<C-p>', '<Up>']
let g:UltiSnipsSnippetDirectories=['~/.vim/UltiSnips', 'UltiSnips']

" Plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
	Plug 'airblade/vim-gitgutter'
	Plug 'auxiliary/vim-layout'
	Plug 'chrisbra/vim-commentary'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'dart-lang/dart-vim-plugin'
	Plug 'linluk/vim-websearch'
	Plug 'mbbill/undotree'
	Plug 'scrooloose/nerdtree'
	Plug 'sirver/ultisnips'
	Plug 'skywind3000/quickmenu.vim'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'tpope/vim-surround'
	Plug 'Valloric/YouCompleteMe'
call plug#end()
