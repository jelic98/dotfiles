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
set pastetoggle=<f3>

" Reload vimrc on save
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Map leader key
let mapleader="/"

" Window resizing
nnoremap <silent><leader>+ :exe "resize +10"<cr>
nnoremap <silent><leader>- :exe "resize -10"<cr>

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

" Flutter commands
nnoremap <leader>fl :FlutterEmulatorsLaunch<space>
nnoremap <leader>fe :FlutterEmulators<cr>
nnoremap <leader>fr :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fs :FlutterSplit<cr>
nnoremap <f9> :FlutterHotRestart<cr>
nnoremap <f10> :FlutterHotReload<cr>

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
nnoremap <f5> :UndotreeToggle<cr>
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
noremap <silent><f12> :call quickmenu#toggle(0)<cr>
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

" Clang format
noremap <leader>f :ClangFormat<cr>
let g:clang_format#detect_style_file = 1

" Prettier
let g:prettier#autoformat=1
let g:prettier#exec_cmd_async=0
let g:prettier#quickfix_enabled=1
let g:prettier#quickfix_auto_focus=1
let g:prettier#config#print_width=120
let g:prettier#config#tab_width=4
let g:prettier#config#use_tabs='true'
let g:prettier#config#single_quote='true'
let g:prettier#config#bracket_spacing='true'
let g:prettier#config#semi='true'
let g:prettier#config#jsx_bracket_same_line='false'
let g:prettier#config#arrow_parens='avoid'
let g:prettier#config#trailing_comma='none'
let g:prettier#config#parser='babylon'

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
	Plug 'prettier/vim-prettier', { 'do': 'npm install' }
	Plug 'rhysd/vim-clang-format'
	Plug 'scrooloose/nerdtree'
	Plug 'sirver/ultisnips'
	Plug 'skywind3000/quickmenu.vim'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'thosakwe/vim-flutter'
	Plug 'tpope/vim-surround'
	Plug 'Valloric/YouCompleteMe'
call plug#end()
