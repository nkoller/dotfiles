" Plugins

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


" Mappings

nmap <space> <nop>
let mapleader = "\<Space>"

" Window/buffer movement
nmap <leader>u :Buf<cr>
nmap <leader><tab> <C-^>
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l

" Buffer creation
nmap <leader>n :ene<cr>
nmap <leader>r :e<cr>
nmap <leader>f :Files 
nmap <leader>H :vnew<cr>
nmap <leader>J :new<cr><C-w><C-x><C-w>j
nmap <leader>K :new<cr>
nmap <leader>L :vnew<cr><C-w><C-x><C-w>l

" Window/buffer closing
nmap <leader>w :q<cr>
nmap <leader>W :qa<cr>
nmap <leader>q :bp<bar>sp<bar>bn<bar>bw<cr>
nmap <leader>!q :bp<bar>sp<bar>bn<bar>bw!<cr>
nmap <leader>Q :bw<cr>
nmap <leader>!Q :bw!<cr>

" Misc shortcuts
nmap <leader>ag :Ack 
nmap <leader>t :terminal<cr>
nmap <leader>z :BLines<cr>
nmap <leader>` :Tlist<cr>

" Make Y behave like C and D
map Y y$

" Remove search highlights on screen redraw
nnoremap <C-L> <C-L>:nohl<cr>


" Appearance

syntax on    " Syntax highlighting
set hlsearch " Search highlighting
set showcmd  " Show partial commands as they're typed

set number
set relativenumber
highlight CursorLineNr ctermfg=Grey     guifg=Grey
highlight LineNr       ctermfg=DarkGrey guifg=DarkGrey

let g:netrw_banner       = 0  " Remove netrw banner
let g:netrw_browse_split = 4  " Open selection in previous window
let g:netrw_liststyle    = 3  " Tree view by default
let g:netrw_winsize      = 25 " 25% width

let g:rainbow_active = 1 " Turn on rainbow brackets


" Tabs

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


" Other behaviour

set hidden       " Don't warn when hiding modified buffers
set tags=$S/tags " Temp (for my work repo)
