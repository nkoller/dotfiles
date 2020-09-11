set nocompatible " For consistency when used as system-wide vimrc or with -u


" --- Plugins ---

" Install vim-plug if it's not there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'
  " Use silver searcher (if it's installed) instead of ack
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif

Plug 'vim-airline/vim-airline'

Plug 'junegunn/fzf'

Plug 'junegunn/fzf.vim'
  let g:fzf_action = {'ctrl-h': 'split'} " Custom hsplit key

Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1 " Toggle rainbow brackets on

Plug 'vim-scripts/taglist.vim'

call plug#end()


" --- Mappings ---

nmap <space> <nop>
let mapleader = "\<Space>"

" Window/buffer movement
nmap <leader>h <c-w>h
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>l <c-w>l
nmap <leader><tab> <c-^>
nmap <silent> <leader>u :Buf<cr>

" Buffer creation
nmap <leader>f :Files 
nmap <silent> <leader>n :ene<cr>
nmap <silent> <leader>r :e<cr>
nmap <silent> <leader>H :vnew<cr>
nmap <silent> <leader>J :new<cr><c-w><c-x><c-w>j
nmap <silent> <leader>K :new<cr>
nmap <silent> <leader>L :vnew<cr><c-w><c-x><c-w>l

" Window/buffer closing
nmap <silent> <leader>w :q<cr>
nmap <silent> <leader>W :qa<cr>
nmap <silent> <leader>q :bp<bar>sp<bar>bn<bar>bw<cr>
nmap <silent> <leader>Q :bw<cr>
nmap <silent> <leader>!w :q!<cr>
nmap <silent> <leader>!W :qa!<cr>
nmap <silent> <leader>!q :bp<bar>sp<bar>bn<bar>bw!<cr>
nmap <silent> <leader>!Q :bw!<cr>

" Misc shortcuts
nmap <leader>a :Ack 
nmap <silent> <leader>s :source ~/.vimrc<cr>
nmap <silent> <leader>t :terminal<cr>
nmap <silent> <leader>z :BLines<cr>
nmap <silent> <leader>` :Tlist<cr>

" Make Y behave like C and D
map Y y$

" Remove search highlights on screen redraw
nnoremap <silent> <c-L> <c-L>:nohl<cr>


" --- Appearance ---

syntax on    " Syntax highlighting
set hlsearch " Search result highlighting
set showcmd  " Show partial commands as they're typed
set wildmenu wildmode=longest:full,full " Show a visual tab completion list

" Line numbers
set number relativenumber
highlight CursorLineNr ctermfg=Grey     guifg=Grey
highlight LineNr       ctermfg=DarkGrey guifg=DarkGrey

" Netrw appearance
let g:netrw_banner       = 0  " Remove banner
let g:netrw_browse_split = 4  " Open selection in previous window
let g:netrw_liststyle    = 3  " Tree view by default
let g:netrw_winsize      = 25 " 25% width


" --- Misc behaviour options ---

filetype indent plugin on      " Enable filetype-specific indents and plugins
set backspace=indent,eol,start " Usually automatic, must set for some systems
set hidden                     " Disable warning when hiding modified buffers
set notimeout ttimeout ttimeoutlen=200 " No timeout on maps, only on keycodes
set tags=$S/tags               " Temp (for my work repo)

" Indentation
set autoindent " When filetype is unknown, just copy indentation of prev line
set expandtab  " Tab key inserts spaces
set shiftwidth=4 softtabstop=4
