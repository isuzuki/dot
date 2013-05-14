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

"status line
set laststatus=2
set statusline=%F%m%r%h%w\ [ENCORDING=%{&enc}]\ [FORMAT=%{&fileformat}]

set visualbell

"tab
nnoremap <C-h> gt
nnoremap <C-l> gT
for i in range(1, 9)
	execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor

"=== for PHP setting 
"syntax check
autocmd filetype php :set makeprg=php\ -l\ %
autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l

"=== for NeoBundle
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/bundle/'))
endif

"get plugin from github
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'rking/ag.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tpope/vim-surround'

nmap <F1> :NeoBundleInstall<CR>

filetype plugin indent on
filetype indent on

"=== for vim plugin
"neocomplcache
autocmd BufRead *.php\|*.ctp\|*.tpl :set dictionary=~/.vim/dict/php.dict filetype=php

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_caching_percent_in_statusline = 1
let g:neocomplcache_enable_skip_completion = 1
let g:neocomplcache_skip_input_time = '0.5'

"vim-ref
let g:ref_phpmanual_path = $HOME . '/.vim/phpmanual'
nmap ,rp :<C-u>Ref phpmanual<Space>

"tagbar
"hide variables
let g:tagbar_type_php = {
	\ 'ctagstype' : 'php',
	\ 'kinds' : [
		\ 'i:interfaces:0:1',
		\ 'c:classes:0:1',
		\ 'd:constant definitions:0:0',
		\ 'f:functions:0:1',
		\ 'j:javascript functions:0:1'
	\ ]
\ }

nmap <F8> :TagbarToggle<CR>


"unite.vim
" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q


"vimfiler
nnoremap <F2> :VimFiler -buffer-name=explorer -split -winwidth=45 -toggle -no-quit<Cr>
autocmd! FileType vimfiler call g:my_vimfiler_settings()
function! g:my_vimfiler_settings()
	nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
	nnoremap <buffer>s          :call vimfiler#mappings#do_action('my_split')<Cr>
	nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<Cr>
endfunction

"Edit file by tabedit.
let g:vimfiler_edit_action = 'tabopen'

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
	wincmd p
	exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', s:my_action)

let s:my_action = { 'is_selectable' : 1 }                     
function! s:my_action.func(candidates)
	wincmd p
	exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', s:my_action)
