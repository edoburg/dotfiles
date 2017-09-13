" vim:set ts=8 sts=2 sw=2 tw=0:
set encoding=utf-8
scriptencoding utf-8

" ====== dein.vim {{{
filetype plugin indent off

if &compatible
    set nocompatible
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

let g:dein_default_git_protocol="https"

let s:dein_dir = expand('~/.vim/bundle/')

if dein#load_state( s:dein_dir )
  call dein#begin( s:dein_dir )
  " プラグインリストを収めたTOMLファイル
  let g:toml_dir = expand('~/.vim/toml')
  let s:toml = g:toml_dir . '/dein.toml'
  let s:lazy_toml = g:toml_dir . '/dein_lazy.toml'

  " TOMLを読み込みキャッシュしておく
  call dein#load_toml(s:toml, {'lazy':0})
  call dein#load_toml(s:lazy_toml, {'lazy':1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
" }}}

" {{{ ====== 非Plugin
set ignorecase
set smartcase
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
" 補完候補を表示する
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" tags
set tags=tags;/

" GUI固有ではない画面表示の設定
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

syntax on

" F1キー誤押下時にhelpを出さないようにする
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" 自動折り返しを無効
autocmd FileType * set textwidth=0

" ファイル拡張子とFileTypeの関連付け
autocmd BufRead,BufNewFile *.txt set filetype=markdown

" expand path (カレントディレクトリの補完)
cmap <c-x> <c-r>=expand('%:p:h')<cr>/
" expand file (not ext)
cmap <c-z> <c-r>=expand('%:p:r')<cr>

let mapleader = "\<Space>"
noremap <Leader>j <C-f>
noremap <Leader>k <C-b>

nnoremap Y y$

" maximum number of items to show in the popup menu
set pumheight=10

" increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" wrap時、行の上下移動を物理行ではなく表示行単位で行う
nnoremap j gj
nnoremap k gk

" backup/swap/undoファイルを書き込むディレクトリの設定
set backup
set swapfile
set undofile
if isdirectory($HOME.'/.vim/backup')
  set backupdir=$HOME/.vim/backup
endif
if isdirectory($HOME.'/.vim/backup')
  set directory=$HOME/.vim/backup
endif
if isdirectory($HOME.'/.vim/backup')
  set undodir=$HOME/.vim/backup
endif

" }}}}

" {{{ ====== Plugin

" {{{ ===== unite.vim
nnoremap    [unite]   <Nop>
nmap    <Space>u [unite]

" 入力モードで開始する
" let g:unite_enable_start_insert=1
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]u :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif
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


" {{{ ===== neosnippet.vim
let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
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

" {{{ ===== yankround.vim
" キーマップ
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
" 履歴取得数
let g:yankround_max_history = 50
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

" {{{ ===== vim-auto-save
" enable auto save
let g:auto_save = 1
" do not save while in insert mode
let g:auto_save_in_insert_mode = 0
" do not display auto-save notification
let g:auto_save_silent = 1
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
