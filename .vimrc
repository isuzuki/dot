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
set whichwrap=b,s,h,l,<,>,[,]

"display
set number
set ruler

"status line
set laststatus=2
set statusline=%F%m%r%h%w\ [ENCORDING=%{&enc}]\ [FORMAT=%{&fileformat}]


"for PHP syntax check
autocmd filetype php :set makeprg=php\ -l\ %
autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l
