" vimrc for rush
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" delimitor completion plugin
Plugin 'Raimondi/delimitMate'

call vundle#end()            " required
filetype plugin indent on    " required

" delimitor completion
let delimitMate_expand_cr = 1

" line number on the left
set number

" syntax coloration
syntax on

" more pertinant indentation?
set smartindent

" automatic indentation
set autoindent

" cursor position in status bar
set ruler

" tabulation length
set shiftwidth=4
set tabstop=4

" put all backup and swap in one place
set backupdir=~/.vim/tmp,~/.tmp,~/tmp,/tmp
set directory=~/.vim/tmp,~/.tmp,~/tmp,/tmp
