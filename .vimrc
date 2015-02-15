"NeoBundleで管理しているpluginの読み込み
source ~/.vimrc.bundle

"基本設定
source ~/.vimrc.basic

"プラグイン設定
source ~/.vimrc.plugins_config


"tab
nnoremap <C-h> gt
nnoremap <C-l> gT
for i in range(1, 9)
	execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor

"C-w gf をtgで開けるようにする
nnoremap <silent> tg <C-w>gf
nnoremap vg :vertical wincmd f<CR>
nnoremap <silent> sg <C-w>f

"=== for PHP setting
"syntax check
autocmd filetype php :set makeprg=php\ -l\ %
autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
