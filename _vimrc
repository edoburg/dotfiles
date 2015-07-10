" vim:set ts=8 sts=2 sw=2 tw=0:
set encoding=utf-8
scriptencoding utf-8

" ====== neobundle.vim {{{
set nocompatible
filetype plugin indent off

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
let g:neobundle_default_git_protocol="https"
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/unite-font'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'vim-scripts/surround.vim'
NeoBundle 'othree/eregex.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'Blackrush/vim-gocode'
NeoBundle 'dgryski/vim-godef'
NeoBundle 'vim-scripts/gtags.vim'
NeoBundle 'haya14busa/incsearch.vim'

" Color Scheme
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'

call neobundle#end()

filetype plugin indent on
NeoBundleCheck

" }}}

" {{{ ====== 非Plugin
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" タブの画面上での幅
set tabstop=4
set shiftwidth=4
" タブをスペースに展開する
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
set matchtime=1
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" tags
set tags=tags;/

" GUI固有ではない画面表示の設定:
" show line number
set number
" show ruler
set ruler
" display list characters (tab, return code, and more)
set list
" list characters setting
set listchars=tab:__,trail:@,eol:$
" 長い行を折り返して表示 (nowrap:折り返さない)
set nowrap
" show status line always
set laststatus=2
" number of lines to use for command line
set cmdheight=2
" show command in status line
set showcmd
" show title
set title
" ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" カーソルのある行を強調表示
set cursorline
" default file format
set fileformat=unix
" clipbordにヤンク
set clipboard=unnamed

" F1キー誤押下時にhelpを出さないようにする
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" omnicomplete
set nocompatible
syntax on
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType cpp setlocal omnifunc=ccomplete#Complete

" 自動折り返しを無効
autocmd FileType * set textwidth=0
" ファイル拡張子とFileTypeの関連付け
autocmd BufRead,BufNewFile *.txt set filetype=markdown
" ファイルタイプごとの設定
autocmd FileType c setlocal foldmethod=syntax
autocmd FileType cpp setlocal foldmethod=syntax

" コマンドラインでのキーバインドを Emacs スタイルにする
" 行頭へ移動
cnoremap <C-A>  <Home>
" 一文字戻る
cnoremap <C-B>  <Left>
" カーソルの下の文字を削除
cnoremap <C-D>  <Del>
" 行末へ移動
cnoremap <C-E>  <End>
" 一文字進む
cnoremap <C-F>  <Right>
" コマンドライン履歴を一つ進む
cnoremap <C-N>  <Down>
" コマンドライン履歴を一つ戻る
cnoremap <C-P>  <Up>
" 前の単語へ移動
cnoremap <Esc><C-B> <S-Left>
" 次の単語へ移動
cnoremap <Esc><C-F> <S-Right>
" expand path (カレントディレクトリの補完)
cmap <c-x> <c-r>=expand('%:p:h')<cr>/
" expand file (not ext)
cmap <c-z> <c-r>=expand('%:p:r')<cr>

let mapleader = "\<Space>"
nnoremap <Leader>t :tabe 
nnoremap <Leader>w :w<CR>

noremap <Space>j <C-f>
noremap <Space>k <C-b>


nnoremap Y y$
set pumheight=10

" increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>


" wrap時、行の上下移動を物理行ではなく表示行単位で行う
nnoremap j gj
nnoremap k gk

" backup/swapファイルを書き込むディレクトリの設定
set backup
set swapfile
if isdirectory($HOME.'/.vim/backup/vim_backup')
  set backupdir=>$HOME/.vim/backup/vim_backup
endif
if isdirectory($HOME.'/.vim/backup/vim_swap')
  set directory=>$HOME/.vim/backup/vim_swap
endif

" for cscope
if has("cscope")
  set cscopetag
  set csto=0
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  if filereadable("cscope.out")
    cs add cscope.out
  endif
  nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>S :scs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>G :scs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>C :scs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>T :scs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>E :scs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>F :scs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-\>I :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\>D :scs find d <C-R>=expand("<cword>")<CR><CR>
endif

" for golang
set runtimepath+=$GOPATH/src/github.com/nsf/gocode/vim
set path+=$GOPATH/src/**
let g:gofmt_command = 'goimports'
autocmd BufWritePre *.go Fmt
autocmd BufNewFile,BufRead *.go set shiftwidth=4 tabstop=4 softtabstop=4 completeopt=menu,preview
autocmd FileType go compiler go
" }}}}

" {{{ ====== Plugin
" {{{ ===== neocomplcache.vim
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 0
let g:neocomplcache_enable_underbar_completion = 0
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_max_list = 10
let g:neocomplcache_auto_completion_start_length = 4
let g:neocomplcache_enable_ignore_case = 0
let g:neocomplcache_enable_wildcard = 0
" 現在選択している候補を確定する
inoremap <expr><C-y> neocomplcache#close_popup()
" 現在選択している候補をキャンセルしてポップアップを閉じる
inoremap <expr><C-e> neocomplcache#cancel_popup()
" <C-h>や<BS>を押したときに確実にポップアップを削除する
inoremap <expr><C-h> neocomplcache#smart_close_popup().”\<C-h>”

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
" }}}

" {{{ ===== unite.vim
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
autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
autocmd FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
autocmd FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-Space> unite#do_action('tabopen')
autocmd FileType unite inoremap <silent> <buffer> <expr> <C-Space> unite#do_action('tabopen')
" }}}

" {{{ ===== QFixHowm
let GFixHowm_Key = 'g'
  let howm_dir = $HOME.'/.howm'
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'
let QFixHowm_FileType    = 'markdown'
let QFixHowm_Title       = '#'
let QFixHowm_FoldingPattern = '^[#] '
" }}}

" {{{ ===== unite-colorscheme unite-font
let g:unite_enable_start_insert = 1
let g:unite_enable_split_vertically = 1
if globpath(&rtp, 'plugin/unite.vim') != ''
  nnoremap sc :<C-u>Unite colorscheme font<Cr>
endif
" }}}

" {{{ ===== python-mode
let g:pymode_run = 0 " quickrunで実行するから不要
" }}}

" {{{ ===== quickrun
let g:quickrun_config = {}
let g:quickrun_config = {
      \ '-' : {
      \   'hook/close_unite_quickfix/enable_hook_loaded' : 1,
      \   'hook/unite_quickfix/enable_failure' : 1,
      \   'hook/close_quickfix/enable_exit' : 1,
      \   'hook/close_buffer/enable_failuer' : 1,
      \   'hook/close_buffer/enable_empty_data' : 1,
      \   'outputter' : 'multi:buffer:quickfix',
      \   'outputter/buffer/split' : ":botright 8sp",
      \   'outputter/buffer/into' : 1,
      \   'runner' : 'vimproc',
      \   'runner/vimproc/updatetime' : 40,
      \  },
      \ 'markdown' : {
      \   'outputter' : 'browser',
      \   'command'   : 'pandoc',
      \   'cmdopt'    : '--toc -S -s -c pandoc.css',
      \  },
      \ }
" }}}

" {{{ ===== open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}

" {{{ ===== quickhl.vim
nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)
nmap <Space>j <Plug>(quickhl-match)
" }}}

" {{{ ===== neosnippet.vim
let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" }}}

" {{{ ===== emmet.vim
" codaのデフォルトと同じキーバインドにする
imap <C-E> <C-Y>,
let g:user_zen_leader_key = '<C-Y>'
" 言語別に対応させる
let g:user_zen_settings = {
  \ 'lang' : 'ja',
  \ 'html' : {
  \ 'filters' : 'html',
  \ 'indentation' : ' '
  \ },
  \ 'css' : {
  \ 'filters' : 'fc',
  \ },
\}
" }}}

" {{{ ===== gitgutter.vim
let g:gitgutter_enabled=0
nnoremap <silent> ,gg : <C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh : <C-u>GitGutterLineHighlightsToggle<CR>
" }}}

" {{{ ===== lightline.vim
if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'mode_map': {'c': 'NORMAL'},
  \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'gitgutter', 'filename' ] ]
  \ },
  \ 'component_function': {
    \   'modified': 'MyModified',
    \   'readonly': 'MyReadonly',
    \   'fugitive': 'MyFugitive',
    \   'gitgutter': 'MyGitGutter',
    \   'filename': 'MyFilename',
    \   'fileformat': 'MyFileformat',
    \   'filetype': 'MyFiletype',
    \   'fileencoding': 'MyFileencoding',
    \   'mode': 'MyMode'
  \ }
\ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
    \  &ft == 'unite' ? unite#get_status_string() :
    \  &ft == 'vimshell' ? vimshell#get_status_string() :
    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
    \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
    \ || ! get(g:, 'gitgutter_enabled', 0)
    \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
    \ g:gitgutter_sign_added . ' ',
    \ g:gitgutter_sign_modified . ' ',
    \ g:gitgutter_sign_removed . ' '
    \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" }}}

" {{{ ===== over.vim
" カーソル下の単語をハイライト付きで置換
nnoremap sub :OverCommandLine<CR>%S/<C-r><C-w>//g<Left><Left>
" コピーした文字列をハイライト付きで置換
nnoremap subp y:OverCommandLine<CR>%S!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>
" }}}

" {{{ ===== yankround.vim
" キーマップ
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
" 履歴取得数
let g:yankround_max_history = 50
" 履歴一覧(kien/ctrlp.vim)
nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
" }}}

" {{{ ===== incsearch.vim
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" }}}

" {{{ ===== anzu.vim
" mapping
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" statusline
set statusline=%{anzu#search_status()}
" }}}
" }}}
"
" {{{ ====== ローカル環境依存
if 1 && filereadable($VIM . '/vimrc_local')
  source $VIM/vimrc_local
endif
if 1 && filereadable($HOME. '/vimrc_local')
  source $HOME/vimrc_local
endif
" }}}
" vim: fdm=marker:
