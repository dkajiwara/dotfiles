"jjでnormalモードに戻る
inoremap <silent> jj <ESC>

filetype plugin indent on
"コードの色分け
syntax on
set encoding=utf-8
" set clipboard=unnamedplus

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

"補完候補がステータスメニュー上に一覧表示
set wildmenu

"空白文字を可視化
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

map <C-n> :NERDTreeToggle<CR>

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
  set termguicolors
endif

" vim-gitgutter
set updatetime=100

set splitbelow
set termwinsize=15x0
set hlsearch

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'jacoborus/tender.vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

" Theme
syntax enable
colorscheme tender
let g:airline_theme = 'tender'
let macvim_skip_colorscheme=1
