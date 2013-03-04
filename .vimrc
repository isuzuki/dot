"color
syntax on
colorscheme darkblue

"encode
set encoding=utf-8
set fileencoding=utf-8

"indent
set autoindent
set cindent
set shiftwidth=4
set tabstop=4

"search
set incsearch
set hlsearch

"key move
set nocompatible
set whichwrap=b,s,h,l,<,>,[,]

"display
set number
set ruler

"copy paste
set paste

"status line
set laststatus=2
set statusline=%F%m%r%h%w\ [ENCORDING=%{&enc}]\ [FORMAT=%{&fileformat}]

"for PHP syntax check
autocmd filetype php :set makeprg=php\ -l\ %
autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l

"set PHP dictionary
autocmd BufRead *.php\|*.tpl :set
set dictionary=~/.vim/dict/php.dict

"for NeoBundle
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/bundle/'))
endif

"get plugin from github
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/vimproc.git'

filetype plugin indent on
filetype indent on

"for neocomplcache
autocmd BufRead *.php\|*.ctp\|*.tpl
set dictionary=~/.vim/dict/php.dict filetype=php

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_caching_percent_in_statusline = 1
let g:neocomplcache_enable_skip_completion = 1
let g:neocomplcache_skip_input_time = '0.5'
