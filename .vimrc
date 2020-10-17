"jjでnormalモードに戻る
inoremap <silent> jj <ESC>

"コードの色分け
syntax on

"行番号を表示
set number

"ターミナルにタイトルを表示
set title

"バックアップファイルを作らない
set nobackup

"タブ幅をスペース4つ文にする
set tabstop=4

"tabを半角スペースで表示
set expandtab

"空白文字を可視化
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

let g:deoplete#enable_at_startup = 1

" Use neocomplete.vim
let g:neocomplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}

" Set async completion.
let g:monster#completion#rcodetools#backend = "async_rct_complete"

" With deoplete.nvim
let g:monster#completion#rcodetools#backend = "async_rct_complete"
let g:deoplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}
