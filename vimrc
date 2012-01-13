filetype off

call pathogen#infect()

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
set undodir=~/.vim-tmp/undo,~/.tmp,~/tmp,/var/tmp,/tmp
set laststatus=2

set background=light
colorscheme solarized

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
nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>
nnoremap <Up>    <NOP>
nnoremap <Down>  <NOP>
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
nnoremap <leader>, :b#<CR>

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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

function! SolarizeDegrade()
  let g:solarized_termcolors=256
  exec ":colorscheme solarized"
endfunction

command! Solarize256 call SolarizeDegrade()

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" Open files with <leader>f
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping found below.
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>

map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT public/stylesheets<cr>

map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>

function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . _ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>

set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

function! SetRspec1()
  let t:st_rspec_command="spec"
endfunction

function! SetRspec2()
  let t:st_rspec_command="rspec"
endfunction

function! RunTests(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !echo;echo;echo;echo;echo
  if !exists("t:st_rspec_command")
    call SetRspec2()
  endif
  exec ":!" . t:st_rspec_command . " " . a:filename
endfunction

function! SetTestFile()
  " Set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " Run the tests for the previously-marked file.
  let in_spec_file = match(expand("%"), '_spec.rb$') != -1
  if in_spec_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>t :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>T :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>

command! Rspec1 :call SetRspec1()
command! Rspec2 :call SetRspec2()

function! SetCucumberFile()
  " Set the spec file that tests will be run for.
  let t:st_cucumber_file=@%
endfunction

function! RunCucumbers(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !echo;echo;echo;echo;echo
  exec ":!" . "cucumber" . " " . a:filename . " -f pretty"
endfunction

function! RunCucumberFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " Run the tests for the previously-marked file.
  let in_cucumber_file = match(expand("%"), '.feature$') != -1
  if in_cucumber_file
    call SetCucumberFile()
  elseif !exists("t:st_cucumber_file")
    return
  end
  call RunCucumbers(t:st_cucumber_file . command_suffix)
endfunction

function! RunNearestCucumber()
  let feature_line_number = line('.')
  call RunCucumberFile(":" . feature_line_number)
endfunction

" Run this file
map <leader>c :call RunCucumberFile()<cr>
" Run only the example under the cursor
map <leader>C :call RunNearestCucumber()<cr>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
