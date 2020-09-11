set nocompatible " For consistency when used as system-wide vimrc or 'vim -u'


" --- Plugins ---

" Install vim-plug if it's not there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'luochen1990/rainbow'
Plug 'vim-scripts/taglist.vim'
call plug#end()

" Use silver searcher (if it's installed) instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:rainbow_active = 1 " Toggle rainbow brackets on


" --- Mappings ---

nmap <space> <nop>
let mapleader = "\<Space>"

" Window/buffer movement
nmap <leader>u :Buf<cr>
nmap <leader><tab> <c-^>
nmap <leader>h <c-w>h
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>l <c-w>l

" Buffer creation
nmap <leader>n :ene<cr>
nmap <leader>r :e<cr>
nmap <leader>f :Files 
nmap <leader>H :vnew<cr>
nmap <leader>J :new<cr><c-w><c-x><c-w>j
nmap <leader>K :new<cr>
nmap <leader>L :vnew<cr><c-w><c-x><c-w>l

" Window/buffer closing
nmap <leader>w :q<cr>
nmap <leader>W :qa<cr>
nmap <leader>q :bp<bar>sp<bar>bn<bar>bw<cr>
nmap <leader>Q :bw<cr>
nmap <leader>!w :q!<cr>
nmap <leader>!W :qa!<cr>
nmap <leader>!q :bp<bar>sp<bar>bn<bar>bw!<cr>
nmap <leader>!Q :bw!<cr>

" Misc shortcuts
nmap <leader>a :Ack 
nmap <leader>s :source ~/.vimrc<cr>
nmap <leader>t :terminal<cr>
nmap <leader>z :BLines<cr>
nmap <leader>` :Tlist<cr>

" Make Y behave like C and D
map Y y$

" Remove search highlights on screen redraw
nnoremap <c-L> <c-L>:nohl<cr>


" --- Appearance ---

syntax on    " Syntax highlighting
set hlsearch " Search result highlighting
set showcmd  " Show partial commands as they're typed

" Line numbers
set number
set relativenumber
highlight CursorLineNr ctermfg=Grey     guifg=Grey
highlight LineNr       ctermfg=DarkGrey guifg=DarkGrey

" Command line completion (displays a little visual list)
set wildmenu              
set wildmode=longest:full,full

" Netrw appearance
let g:netrw_banner       = 0  " Remove banner
let g:netrw_browse_split = 4  " Open selection in previous window
let g:netrw_liststyle    = 3  " Tree view by default
let g:netrw_winsize      = 25 " 25% width


" --- Misc behaviour options ---

filetype indent plugin on      " Enable filetype-specific indents and plugins
set backspace=indent,eol,start " Usually automatic, must set for some systems
set hidden                     " Disable warning when hiding modified buffers
set notimeout ttimeout         " Timeout on partial keycodes but not mappings
set tags=$S/tags               " Temp (for my work repo)

" Indentation
set autoindent " When filetype is unknown, just copy indentation of prev line
set expandtab  " Tab key inserts spaces
set shiftwidth=4
set softtabstop=4
