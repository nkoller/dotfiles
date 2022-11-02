set nocompatible " For consistency when used as system-wide vimrc or with -u


" --- Constants --- 

let dark_grey = 235 " Xterm Grey15 (#262626)


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
  let g:airline_theme = 'zenburn'

Plug 'junegunn/fzf'

Plug 'junegunn/fzf.vim'
  let g:fzf_action = {
    \ 'ctrl-n': 'split',
    \ 'ctrl-l': 'vsplit',
    \ 'ctrl-t': 'tab split' }

Plug 'fatih/vim-go'

Plug 'Yggdroot/indentLine'
  let g:indentLine_char = '¦'
  let g:indentLine_color_term = dark_grey

Plug 'mzlogin/vim-markdown-toc'

Plug 'sheerun/vim-polyglot'

Plug 'frazrepo/vim-rainbow'
  let g:rainbow_active = 1

Plug 'junegunn/seoul256.vim'

Plug 'lervag/vimtex'
  let g:vimtex_view_method = 'skim'

call plug#end()


" --- Appearance ---

set showcmd " Show partial commands as they're typed
set wildmenu wildmode=longest:full,full " Show a visual tab completion list

" Enable colours/highlighting
syntax on
set cursorline
set hlsearch

" Colour scheme
set notermguicolors  " Use 8-bit colour (Terminal.app doesn't support 24-bit)
colorscheme seoul256 " This is a nice 8-bit colour scheme
hi normal     ctermbg=none " Remove the colorscheme background colours. Note
hi linenr     ctermbg=none " that we don't care about guibg because we're in
hi signcolumn ctermbg=none " 8-bit mode.

" Line numbers
set number relativenumber
execute 'hi linenr ctermfg='.dark_grey

" Netrw appearance
let g:netrw_banner       = 0  " Remove banner
let g:netrw_browse_split = 4  " Open selection in previous window
let g:netrw_liststyle    = 3  " Tree view by default
let g:netrw_list_hide    = '.*\.swp$'
let g:netrw_winsize      = 25 " 25% width


" --- Behaviour ---

filetype indent plugin on      " Enable filetype-specific indents and plugins
set backspace=indent,eol,start " Usually automatic, must set for some systems
set hidden                     " Disable warning when hiding modified buffers
set re=0                       " Quicker regex engine for syntax highlighting
set splitbelow splitright      " Always place new window below / to the right
set notimeout ttimeout ttimeoutlen=200 " No timeout on maps, only on keycodes

" Indentation
set autoindent " For unknown filetypes, just copy indentation from prev. line
set expandtab  " Tab key inserts spaces by default
set shiftwidth=4 tabstop=4 " Tabs appear 4 spaces long

" Markdown
autocmd Filetype markdown setlocal textwidth=80 " Automatic line breaks at 80


" --- Mappings ---

nmap <space> <nop>
let mapleader = "\<Space>"

" Window movement
nmap <leader>h <c-w>h
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>l <c-w>l
nmap <leader>p <c-w>p
nmap <silent> <leader>u :Win<cr>

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
nmap <silent> <leader>i :Buf<cr>

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
nmap <silent> <leader>d :GoDef<cr>
nmap <silent> <leader>/ :BLines<cr>
nmap <silent> <leader>~ :Tlist<cr>
nmap <silent> <leader><leader> :Vexplore<cr>

" Make Y behave like C and D
map Y y$

" Remove search highlights on screen redraw
nnoremap <silent> <c-L> <c-L>:nohl<cr>


" --- Filetype-specific mappings ---

" Latex
autocmd Filetype tex call SetLatexMappings()
function SetLatexMappings()
  imap ; \
  imap [ {
  imap { [

  imap <c-a> \begin{align*}<cr>
  imap <c-b> \begin{bmatrix}
  imap <c-e> \begin{equation*}<cr>
  imap <c-n> \begin{enumerate}<cr>\item 
  imap <c-p> \left\{ \begin{array}{ll}<cr>
endfunction
