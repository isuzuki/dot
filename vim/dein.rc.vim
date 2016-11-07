" plugins {{{

if &compatible
  set nocompatible
endif

" install dein.vim
let s:cache_dir = expand('~/.vim/cache')
let s:dein_dir = s:cache_dir .'/dein'
let s:dein_repo_dir = s:dein_dir .'/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim '. shellescape(s:dein_repo_dir))
endif

let &runtimepath = s:dein_repo_dir .','. &runtimepath

" load plugins
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir = expand('~/.vim')
  let s:toml = g:rc_dir .'/dein.toml'
  let s:lazy_toml = g:rc_dir .'/dein_lazy.toml'

  " load toml, create cache
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

" install plugins
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

filetype plugin indent on

" }}}
