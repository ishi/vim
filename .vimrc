" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" 	This is the personal .vimrc file of Radosław Zieliński
" 	based on ultimate .vimrc by Steve Francia (http://spf13.com).
" }

" Setup Bundle Support {
" The next two lines ensure that the ~/.vim/bundle/ system works
	runtime! autoload/pathogen.vim
	silent! call pathogen#runtime_append_all_bundles()
" }

" Basics {
	set nocompatible            " must be first line
	set hidden                  " buffer becomes hidden when it is abandoned
" }
 
" General {
	set history=1000            " how many lines of history to remember
	set undolevels=1000
	set confirm                 " ask what to do about unsaved/read-only files
	"set viminfo+=!             " save global variables that consists of upper case letters
	set iskeyword+=_,$,@,#,-    " none of these should be word dividers, so make them not be
	set report=0                " tell us when any line is changed via : commands
	set noerrorbells            " don't make noise on error messages
	set novisualbell            " don't blink

	filetype on
	filetype plugin indent on   " Automatically detect file types.
	syntax on                   " syntax highlighting
	set mouse=a                 " automatically enable mouse usage
	scriptencoding utf-8
	set autowrite
	set shortmess+=filmnrxoOtT  " abbrev. of messages (avoids 'hit enter')
	set shortmess+=I            " dont show intro
	" set spell                 " spell checking on
	" autocmd BufEnter * let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
	" set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{$USER}@%{hostname()}
	if &term == "screen"
		set t_ts=^[k
		set t_fs=^[\
	endif
	set titlestring=%{$USER}@%{hostname()}:\ %-25.55F\ %a%r%m titlelen=70
	set title
	" Setting up the directories {
	"set backup                      " backups are nice ...
		" set backupdir=$HOME/.vim/backup  " but not when they clog .
		" set directory=$HOME/.vim/swap    " Same for swap files
		
		" Creating directories if they don't exist
		" silent execute '!mkdir -p $HOME/.vim/backup'
		" silent execute '!mkdir -p $HOME/.vim/swap'
		
		set nobackup
		set noswapfile
	" }
" }

" Vim UI {
	color peaksea               " load a colorscheme, for gvim in GUI settings
	set background=dark         " Assume a dark background
	set showmode                " display the current mode
	set cursorline              " highlight current line

	if has('cmdline_info')
		set ruler                 " show the ruler
		set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
		set showcmd               " show partial commands in status line and
		                          " selected characters/lines in visual mode
	endif

	if has('statusline')
		set laststatus=2          " always show statusline
		set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P " a statusline, also on steroids
	endif

	set lazyredraw              " do not redraw while running macros (much faster) (LazyRedraw)
	set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$ " what to show when I hit :set list
	set list

	set backspace=indent,eol,start  " make backspace work normal (indent, eol, start)
	set linespace=0             " could be < 0
	set number                  " Line numbers on
	set showmatch               " show matching brackets/parenthesis
	set incsearch               " find as you type search
	set hlsearch                " highlight search terms
	set wrapscan                " When searching, will wrap from bottom of buffer to top when 'nexting'
	set winminheight=0          " windows can be 0 line high 
	set ignorecase              " case insensitive search
	set smartcase               " case sensitive when uc present
	set wildmenu                " show list instead of just completing
	set wildmode=list:longest,full  " comand <Tab> completion, list matches, then longest common part, then all.
	set whichwrap+=<,>,[,]      " allow backspace and cursor keys to cross line boundaries
	"set whichwrap=b,s,h,l,<,>,[,]  " backspace and cursor keys wrap to
	set scrolljump=0            " lines to scroll when cursor leaves screen
	set scrolloff=5             " minimum lines to keep above and below cursor
	set foldenable              " auto fold code
	set gdefault                " the /g flag on :s substitutions by default
	set colorcolumn=121
" }

" Formatting {
	set wrap                    " wrap long lines
	set autoindent              " indent at the same level of the previous line
	set smartindent             " smart autoindenting for C programs
	set shiftwidth=2            " use indents of 2 spaces
	set noexpandtab               " dont use tabs
	set tabstop=2               " an indentation every two columns
	set softtabstop=0
	set smarttab

	"set matchpairs+=<:>        " match, to be used with % 
	set pastetoggle=<F12>       " pastetoggle (sane indentation on pastes)
	"set comments=sl:/*,mb:*,elx:*/ " auto format comment blocks
	set formatoptions+=n
" }

" Folding {
	set foldenable              " Turn on folding
	set foldmethod=syntax       " Make folding 'indent' sensitive or not
	set foldlevel=100           " Don't autofold anything (but I can still fold manually)
	"set foldopen-=search        " don't open folds when you search into them
	set foldopen-=undo          " don't open folds when you undo stuff
" }

" Key Mappings {

	" Easier moving in tabs and windows
	map <C-J> <C-W>j<C-W>_
	map <C-K> <C-W>k<C-W>_
	map <C-L> <C-W>l<C-W>_
	map <C-H> <C-W>h<C-W>_

	" Cursor Movement
	" Make cursor move by visual lines instead of file lines (when wrapping)
	map <up> gk
	map k gk
	imap <up> <C-o>gk
	map <down> gj
	map j gj
	imap <down> <C-o>gj
	map E ge

	map <Enter> o<ESC> 	" insert new line after (without leaving command mode)

	" Stupid shift key fixes
	"cmap W w
	"cmap WQ wq
	"cmap wQ wq
	"cmap Q q

	" Yank from the cursor to the end of the line, to be consistent with C and D.
	nnoremap Y y$

	nmap <leader>w :w<cr>       " Fast saving

	" Shortcuts
	" Change Working Directory to that of the current file
	cmap cwd lcd %:p:h

	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis

	augroup vimrcEx
	au!

	au BufNewFile,BufRead *.less set filetype=less
	au BufNewFile,BufRead *.phtml set filetype=php
	au BufNewFile,BufRead *.mxml set filetype=mxml
	au BufNewFile,BufRead *.as set filetype=actionscript

	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\ 	exe "normal! g`\"" |
		\ endif

	augroup END
" }

" GUI Settings {
	" GVIM- (here instead of .gvimrc)
	if has('gui_running')
		color ir_black
		set guioptions-=T         " remove the toolbar
		set lines=40              " 40 lines of text instead of 24,
	endif
" }
