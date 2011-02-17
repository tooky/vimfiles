filetype off

call pathogen#runtime_append_all_bundles()

syntax on
filetype plugin indent on
set shell=/bin/sh
set nocompatible
set modelines=0
set ofu=syntaxcomplete#Complete
set tabstop=2
set smarttab
set title
set scrolloff=3
set encoding=utf-8
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
set showmode
set showcmd
set number
set ruler
set hidden
set history=1000
set wildmenu
set wildmode=list:longest

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set showmatch
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=+5,+6

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set shortmess=atI
set visualbell
set cursorline
set ttyfast
set undofile
set laststatus=2

colorscheme lettuce
set fillchars=vert:\ ,fold:\ 

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Highlight search terms...
set hlsearch
set incsearch " ...dynamically as they are typed.

nnoremap ' `
nnoremap ` '
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Disable arrow keys in insert - training wheels mode
"inoremap <Left>  <NOP>
"inoremap <Right> <NOP>
"inoremap <Up>    <NOP>
"inoremap <Down>  <NOP>
"nnoremap <Left>  <NOP>
"nnoremap <Right> <NOP>
"nnoremap <Up>    <NOP>
"nnoremap <Down>  <NOP>
nnoremap j gj
nnoremap k gk

inoremap jj <ESC>

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

let mapleader = ","

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>a :Ack
nnoremap <leader>V V`]
nnoremap <leader>sb :b#<CR>

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"insert text from osx pastebuffer
nnoremap <leader>v :.!pbpaste<CR>

map <Leader>] <Plug>MakeGreen
autocmd BufNewFile,BufRead *_spec.rb compiler rspec

nmap <silent> <leader>n :silent :nohlsearch<CR>

set listchars=tab:▸\ ,trail:·,eol:¬
set list!
nmap <silent> <leader>s :set nolist!<CR>

autocmd User Rails nnoremap <buffer> <D-r> :<C-U>Rake<CR>
autocmd User Rails nnoremap <buffer> <D-R> :<C-U>.Rake<CR>

" expand %% to current file path in command mode
cabbr <expr> %% expand('%:p:h')
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

au BufRead,BufNewFile *.pl    set filetype=prolog

" Understand :W to be the same thing as :w
command! W :w
command! Wq :wq

