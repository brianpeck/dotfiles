au BufRead,BufNewFile *.md set filetype=markdown

set encoding=utf-8
set number
syntax on

set nofoldenable
set foldmethod=indent

" Status Line Stuff
set laststatus=2
set display+=lastline

let g:airline_enable_branch = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'simple'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extension#tabline#fnamemod = ':t'

" Better line navigation with wrapped lines
nnoremap j gj
nnoremap k gk

" Vundle Setup
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-markdown'
Bundle 'airblade/vim-gitgutter'
Bundle 'flazz/vim-colorschemes'

set background=dark
set t_Co=256
colorscheme desert

" filetype back on
filetype on
