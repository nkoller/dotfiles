" Appearance

syntax on

set number
set relativenumber
highlight CursorLineNr ctermfg=Grey     guifg=Grey
highlight LineNr       ctermfg=DarkGrey guifg=DarkGrey

let g:netrw_banner       = 0  " Remove netrw banner
let g:netrw_browse_split = 4  " Open selection in previous window
let g:netrw_liststyle    = 3  " Tree view by default
let g:netrw_winsize      = 25 " 25% width


" Tabs

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


" Ctags

set tags=$S/tags


" Plugins

" Install vim-plug if it's not there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'luochen1990/rainbow'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-airline/vim-airline'
call plug#end()

let g:rainbow_active = 1 " Turn on rainbow brackets

" Use the silver searcher (if it's installed) instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
