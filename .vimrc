set number
set spell spelllang=en_us
setlocal spell spelllang=en_us

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

:ab bb #!/bin/bash
:ab bbr #!/usr/bin/Rscript

filetype indent on


" Spelling
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline



set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'ekalinin/Dockerfile.vim'
	
	Plugin 'vim-pandoc/vim-pandoc-syntax'
	Plugin 'vim-pandoc/vim-rmarkdown'
	Plugin 'Vim-R-plugin'
	Plugin 'chase/vim-ansible-yaml'
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

















