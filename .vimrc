set nocompatible " For consistency when used as system-wide vimrc or with -u


" --- Script constants ---

let s:is_macos_light_theme =
  \ system('defaults read -g AppleInterfaceStyle 2>&1') =~ 'does not exist'

if s:is_macos_light_theme
  let s:soft_grey = 249 " Xterm Grey70 (#b2b2b2)
else
  let s:soft_grey = 241 " Xterm Grey39 (#626262)
endif


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
if s:is_macos_light_theme
  let g:airline_theme = 'google_light'
else
  let g:airline_theme = 'zenburn'
endif

Plug 'dense-analysis/ale'
let g:ale_completion_enabled = 1
let g:ale_echo_msg_format = '[%linter%] %severity%: %s'
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'javascript': ['eslint', 'prettier'],
\ 'javascriptreact': ['eslint', 'prettier'],
\ 'json': ['prettier'],
\ 'python': ['black'],
\ 'typescript': ['eslint', 'prettier'],
\ 'typescriptreact': ['eslint', 'prettier'],
\ 'vim': [],
\}
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
set omnifunc=ale#completion#OmniFunc

Plug 'github/copilot.vim'

Plug 'junegunn/fzf'

Plug 'junegunn/fzf.vim'
let g:fzf_action = {
\ 'ctrl-n': 'split',
\ 'ctrl-l': 'vsplit',
\ 'ctrl-t': 'tab split',
\}

Plug 'fatih/vim-go'

Plug 'Yggdroot/indentLine'
let g:indentLine_char = '¦'
let g:indentLine_defaultGroup = 'linenr' " Use the same colour as line numbers

Plug 'mzlogin/vim-markdown-toc'

Plug 'andymass/vim-matchup'

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
if s:is_macos_light_theme
  set background=light
endif
hi normal     ctermbg=none " Remove the colorscheme background colours. Note
hi linenr     ctermbg=none " that we don't care about guibg because we're in
hi signcolumn ctermbg=none " 8-bit mode.
hi aleerrorsign   ctermbg=none
hi alewarningsign ctermbg=none

" Line numbers
set number relativenumber
execute 'hi linenr ctermfg='.s:soft_grey

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
set shiftwidth=2 tabstop=2 " Tabs appear 2 spaces long

" Markdown
autocmd Filetype markdown setlocal textwidth=80 " Automatic line breaks at 80


" --- Mappings ---

let mapleader = "\<space>"

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
  execute 'nmap <leader>'.i.' '.i.'gt'
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

" Misc command shortcuts
nmap <leader>c :source $MYVIMRC<cr>
nmap <silent> <leader><leader> :Vexplore<cr>

" ALE shortcuts
nmap <silent> <c-n> :ALENextWrap<cr>
nmap <silent> <c-p> :ALEPreviousWrap<cr>
nmap <silent> fd :ALEGoToDefinition<cr>
nmap <silent> <leader>dd :ALEGoToDefinition<cr>
nmap <silent> <leader>dj :ALEGoToDefinition -split<cr>
nmap <silent> <leader>dl :ALEGoToDefinition -vsplit<cr>
nmap <silent> <leader>dt :ALEGoToDefinition -tab<cr>
nmap <silent> <leader>R :ALEFindReferences<cr>
nmap <leader>g :ALERename<cr>
nmap <leader>G :ALEFileRename<cr>

" Other plugin shortcuts
nmap <leader>a :Ack 
nmap <silent> <leader>m :MatchupWhereAmI<cr>
nmap <silent> <leader>/ :BLines<cr>

" In insert mode, make tab trigger omnicompletion and also cycle through options
imap <expr> <tab> pumvisible() ? '<c-n>' : '<c-x><c-o>'

" Make V and Y behave like C and D
nmap V v$
nmap Y y$

" Remove search highlights on screen redraw
nnoremap <silent> <c-l> <c-l>:nohl<cr>


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
