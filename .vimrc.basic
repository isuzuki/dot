" generic options {{{
set nobackup
set noswapfile

" display
let g:hybrid_custom_term_colors = 1
syntax enable
set t_Co=256
set background=dark
colorscheme hybrid
set laststatus=2

filetype plugin indent on
filetype indent on
set list
set listchars=tab:▸\ ,eol:¬
set number
set ruler


" search
set ignorecase
set incsearch
set hlsearch
set smartcase
set wrapscan

"indent
set autoindent
set cindent
set shiftwidth=4
set tabstop=4

"key move
set whichwrap=b,s,h,l,<,>,[,]

set backspace=2

" }}}

" custom settings {{{
" タブ切り替えのキーマッピング
nnoremap <C-h> gt
nnoremap <C-l> gT
for i in range(1, 9)
	execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor

" カレントラインをハイライト
set cursorline
hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine term=none cterm=none ctermfg=none ctermbg=233

" カレントウィンドウのみ罫線を引く
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END

" 全角スペースをハイライトさせる
function! TwoByteCharSpace()
	highlight TwoByteCharSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
	augroup TwoByteCharSpace
		autocmd!
		autocmd ColorScheme       * call TwoByteCharSpace()
		autocmd VimEnter,WinEnter * match TwoByteCharSpace /　/
	augroup END
	call TwoByteCharSpace()
endif

" 末尾スペースのハイライト
augroup HighlightTrailingSpaces
	autocmd!
	autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Blue ctermbg=Blue
	autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" 保存時に行末の空白を除去する
function! s:remove_dust()
	let cursor = getpos(".")
	" 保存時に行末の空白を除去する
	%s/\s\+$//ge
	call setpos(".", cursor)
	unlet cursor
endfunction
autocmd BufWritePre * call <SID>remove_dust()

" 独自設定ファイルを読み込ませる
augroup vimrc-local
	autocmd!
	autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
	let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
	for i in reverse(filter(files, 'filereadable(v:val)'))
		source `=i`
	endfor
endfunction

" }}}
