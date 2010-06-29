filetype off

call pathogen#runtime_append_all_bundles()

syntax on
filetype plugin indent on
set ofu=syntaxcomplete#Complete
set tabstop=2
set smarttab
set title
set scrolloff=3
set shiftwidth=2
set autoindent
set expandtab
set number
set ruler
set hidden
set history=1000
set wildmode=list:longest
set ignorecase 
set smartcase
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set shortmess=atI
set visualbell

colorscheme vividchalk

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
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>

let mapleader = ","

map <Leader>] <Plug>MakeGreen 
autocmd BufNewFile,BufRead *_spec.rb compiler rspec

nmap <silent> <leader>n :silent :nohlsearch<CR>

set listchars=tab:>-,trail:·,eol:¬,extends:>
nmap <silent> <leader>s :set nolist!<CR>

let g:rsenseHome = "/usr/lib/rsense-0.2"

autocmd User Rails nnoremap <buffer> <D-r> :<C-U>Rake<CR>
autocmd User Rails nnoremap <buffer> <D-R> :<C-U>.Rake<CR>
