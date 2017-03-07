" options {{{

set nobackup
set noswapfile

" display
let g:hybrid_custom_term_colors = 1
syntax enable
set t_Co=256
set background=dark
colorscheme dracula
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
set expandtab
set shiftwidth=4
set tabstop=4

"key move
set whichwrap=b,s,h,l,<,>,[,]
set backspace=2

" }}}

" key mapping for tab switch {{{

nnoremap <C-h> gt
nnoremap <C-l> gT
for i in range(1, 9)
  execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor

" }}}

" cursor current line {{{

set cursorline
hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine term=none cterm=none ctermfg=none ctermbg=233

" cursor only current window
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" }}}

" highlight two byte char space {{{

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

" }}}

" highlight trailing spaces {{{

augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Blue ctermbg=Blue
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" }}}

" remove trailing spaces on save {{{

function! s:remove_trailing_spaces()
  let cursor = getpos(".")
  %s/\s\+$//ge
  call setpos(".", cursor)
  unlet cursor
endfunction
autocmd BufWritePre * call <SID>remove_trailing_spaces()

" }}}

" load project vimrc {{{

augroup LoadProjectVimrc
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:load_project_vimrc(expand('<afile>:p:h'))
augroup END

function! s:load_project_vimrc(loc)
  let files = findfile('.project.rc.vim', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

" }}}
