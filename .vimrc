set nocompatible " For consistency when used as system-wide vimrc or with -u

" --- Appearance ---

syntax on    " Syntax highlighting
set showcmd  " Show partial commands as they're typed
set wildmenu wildmode=longest:full,full " Show a visual tab completion list

" Line numbers
set number relativenumber
hi CursorLineNr ctermfg=Grey     guifg=Grey
hi LineNr       ctermfg=DarkGrey guifg=DarkGrey

" Window split
hi VertSplit    cterm=NONE
hi VertSplit    ctermfg=Grey     guifg=Grey

" Search result highlighting
set hlsearch
hi Search ctermbg=LightYellow guibg=LightYellow

" Netrw appearance
let g:netrw_banner       = 0  " Remove banner
let g:netrw_browse_split = 4  " Open selection in previous window
let g:netrw_bufsettings  = 'noma nomod nu nobl nowrap ro' " Show line numbers
let g:netrw_liststyle    = 3  " Tree view by default
let g:netrw_winsize      = 25 " 25% width


" --- Behaviour ---

filetype indent plugin on      " Enable filetype-specific indents and plugins
set backspace=indent,eol,start " Usually automatic, must set for some systems
set hidden                     " Disable warning when hiding modified buffers
set notimeout ttimeout ttimeoutlen=200 " No timeout on maps, only on keycodes
set splitbelow splitright      " Always place new window below / to the right

" Indentation
set autoindent " When filetype is unknown, just copy indentation of prev line
set expandtab  " Tab key inserts spaces
set shiftwidth=4 softtabstop=4


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
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#formatter = 'unique_tail'
  let g:airline_section_y = ''       " Disable file encoding section
  let g:airline_section_warning = '' " Disable warnings section

Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme = 'light'

Plug 'junegunn/fzf'

Plug 'junegunn/fzf.vim'
  let g:fzf_action = {
    \ 'ctrl-n': 'split',
    \ 'ctrl-l': 'vsplit',
    \ 'ctrl-t': 'tab split' }

Plug 'frazrepo/vim-rainbow'
  let g:rainbow_active = 1

Plug 'vim-scripts/taglist.vim'

call plug#end()


" --- Mappings ---

nmap <space> <nop>
let mapleader = "\<Space>"

" Window movement
nmap <leader>h <c-w>h
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>l <c-w>l
nmap <leader>p <c-w>p
nmap <silent> <leader>i :Win<cr>

" Window placement
nmap <leader>H <c-w>H
nmap <leader>J <c-w>J
nmap <leader>K <c-w>K
nmap <leader>L <c-w>L
nmap <leader>: <c-w>x
nmap <leader>T <c-w>T

" Window sizing
nmap <leader>- 10<c-w>-
nmap <leader>= 10<c-w>+
nmap <leader>[ 10<c-w><
nmap <leader>] 10<c-w>>
nmap <leader>_ <c-w>-
nmap <leader>+ <c-w>+
nmap <leader>{ <c-w><
nmap <leader>} <c-w>>
nmap <leader>\ <c-w>=

" Tab movement
nmap <leader>` gt
for i in range(1, 9)
  execute "nmap <leader>" . i . " " . i . "gt"
endfor
nmap <leader>0 :tabl<cr>

" Buffer movement
nmap <silent> <leader><tab> :bn<cr>
nmap <leader>o <c-^>
nmap <silent> <leader>u :Buf<cr>

" Buffer creation (new)
nmap <silent> <leader>nn :ene<cr>
nmap <silent> <leader>nh :abo vnew<cr>
nmap <silent> <leader>nj :bel new<cr>
nmap <silent> <leader>nk :abo new<cr>
nmap <silent> <leader>nl :bel vnew<cr>

" Buffer creation (from file)
nmap <silent> <leader>r :e<cr>
nmap <leader>ee :e 
nmap <leader>eh :abo vsp 
nmap <leader>ej :bel sp 
nmap <leader>ek :abo sp 
nmap <leader>el :bel vsp 
nmap <leader>f :Files<cr>
nmap <leader>F :Files 

" Window/buffer saving and closing
nmap <silent> <leader>s :w<cr>
nmap <leader>S :w 
nmap <silent> <leader>w :q<cr>
nmap <silent> <leader>W :bw<cr>
nmap <silent> <leader>q :bp<bar>sp<bar>bn<bar>bw<cr>
nmap <silent> <leader>x :qa<cr>
nmap <silent> <leader>!w :q!<cr>
nmap <silent> <leader>!W :bw!<cr>
nmap <silent> <leader>!q :bp<bar>sp<bar>bn<bar>bw!<cr>
nmap <silent> <leader>!x :qa!<cr>

" Misc shortcuts
nmap <leader>a :Ack 
nmap <leader>c :source $MYVIMRC<cr>
nmap <silent> <leader>/ :BLines<cr>
nmap <silent> <leader>~ :Tlist<cr>
nmap <silent> <leader><leader> :Vexplore<cr>

" Make Y behave like C and D
map Y y$

" Remove search highlights on screen redraw
nnoremap <silent> <c-L> <c-L>:nohl<cr>
