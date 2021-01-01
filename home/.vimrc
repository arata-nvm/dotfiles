
" --------------------
"  shell
" --------------------

set shell=/usr/bin/fish


" --------------------
"  plugins
" --------------------

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'cocopon/iceberg.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'preservim/nerdtree', { 'on': 'NERDTree' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim', { 'on': 'TComment' } 
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'simeji/winresizer'
Plug 'junegunn/fzf.vim'

call plug#end()


" --------------------
"  encoding
" --------------------

set encoding=utf8
scriptencoding utf8
set fileencoding=utf-8
set termencoding=utf8
set fileencodings=utf-8,ucs-boms,euc-jp,qp932
set fileformats=unix,dos,mac
set ambiwidth=double
set nobomb
set t_Co=256


" --------------------
"  vim options
" --------------------

" --- 操作 ---

" オートリロードを有効にする
set autoread

" ファイルを別のバッファに開く
set hidden

" バックアップファイルを作成しない
set nobackup

" スワップファイルを作成しない
set noswapfile 

" 大文字と小文字を区別しない
set ignorecase

" 大文字と小文字が使用されていれば区別する
set smartcase

" インクリメンタルサーチをする
set incsearch

" 最後まで検索したら先頭に戻る
set wrapscan

" ヤンクに*レジスタを使用する
set clipboard=unnamed

" カーソルを行末まで移動できるようにする
set virtualedit=onemore

" コマンドラインで補完を有効にする
set wildmode=list:longest

" 300ms 毎に更新する
set updatetime=300

" ファイルを閉じても操作履歴を保持する
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" コマンド入力のタイムアウトを早める
set timeout timeoutlen=200

" --- 見た目 ---

" 行番号を表示する
set number

" カーソル行を強調する
set cursorline

" ステータス行を表示させたままにする
set laststatus=2

" ステータス表示欄を2行にする
set cmdheight=2

" 対応する括弧を強調する
set showmatch

" 検索文字列をハイライトする
set hlsearch

" タブ文字をスペースにする
set expandtab

" 行頭以外ののタブ文字を2文字にする
set tabstop=2

" 行頭のタブ文字を2文字にする
set shiftwidth=2

" 前の行に合わせてインデントを設定する
set smartindent

" ビープ音を消す
set belloff=all

" コマンドをステータスに表示する
set showcmd

" シンタックスハイライトを有効にする
syntax enable

" ins-completion-menu 関連のメッセージを表示しない
set shortmess+=c

" 補完ウィンドウを設定
set completeopt=menuone,noinsert


" --------------------
"  look and feel
" --------------------

" カラースキーム
colorscheme iceberg

" ダーク系のカラースキームを設定する
set background=dark


" --------------------
"  key mapping
" --------------------

" 折返し表示されているときに、表示行単位で移動する
nnoremap j gj
nnoremap k gk

" xでヤンクしない
nnoremap x "_x

" -で行頭 ^で行末
nnoremap - ^
nnoremap ^ $

" インデント調整を連続してできるようにする
vnoremap > >gv
vnoremap < <gv

" s+hjklで移動する
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap ss :<C-u>sp<CR><C-w>j
nnoremap sv :<C-u>vs<CR><C-w>

tnoremap sh <C-w>h
tnoremap sj <C-w>j
tnoremap sk <C-w>k
tnoremap sl <C-w>l

" 十字キー死すべし
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

inoremap <silent> <Up> <Nop>
inoremap <silent> <Down> <Nop>
inoremap <silent> <Left> <Nop>
inoremap <silent> <Right> <Nop>

" Esc+Escでハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" :w!! でroot権限でファイルを書き込む
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

inoremap <expr><CR> pumvisible() ? "<C-y>" : "<CR>"

" --------------------
"  plugin settings
" --------------------

" --- NERDTree ---

" NERDTreeで隠しファイルを表示する
let NERDTreeShowHidden=1

" Ctrl+aでNERDTreeを表示する
nnoremap <silent> <C-a> :NERDTree<CR>

" --- vim-airline ---

" bdでバッファを削除する
nnoremap bd :bd<CR>

let g:airline_theme = 'bubblegum'

" バッファタブを有効にする
let g:airline#extensions#tabline#enabled = 1

" タブに番号を表示する
let g:airline#extensions#tabline#buffer_idx_mode = 1

" タブに表示する名前
let g:airline#extensions#tabline#fnamemod = ':t'

" ,と.でバッファを移動する
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>

" --- vim-indent-guides ---

" 起動時に有効にする
let g:indent_guides_enable_on_vim_startup = 1

" ヘルプとNERDTreeでは有効にしない
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" 色の設定
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236

" --- vim-gitgutter ---

" signを有効にする
set signcolumn=yes

" 非同期で実行する
let g:gitgutter_async = 1

" 色の設定
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow

" --- tcomment_vim ---

" ヴィジュアルモードで?を押すとコメントアウトされる
vnoremap ? :'<,'>TComment<CR>

" --- rainbow ---

let g:rainbow_active = 1

" --- fzf.vim ---

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \ : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \ <bang>0)

nnoremap <C-g> :Rg<Space>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-h> :History<CR>
nnoremap <C-f> :Files<CR>

" --- coc.nvim ---

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

