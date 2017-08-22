" vim:set ts=8 sts=2 sw=2 tw=0:
set encoding=utf-8
scriptencoding utf-8

" ====== dein.vim {{{
set nocompatible
filetype plugin indent off

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/dein
endif
let g:dein_default_git_protocol="https"

call dein#begin( expand('~/.vim/bundle/') )
call dein#add( 'Shougo/neocomplete' )
call dein#add( 'Shougo/vimproc.vim', { 'build' : 'make' } )
call dein#add( 'Shougo/unite.vim' )
call dein#add( 'Shougo/neomru.vim' )
call dein#add( 'Shougo/vimfiler' )
call dein#add( 'Shougo/vimshell' )
call dein#add( 'Shougo/neosnippet' )
call dein#add( 'Shougo/neosnippet-snippets' )
call dein#add( 'Shougo/unite-outline' )
call dein#add( 'ujihisa/unite-colorscheme' )
call dein#add( 'ujihisa/unite-font' )
call dein#add( 'osyo-manga/unite-quickfix' )
call dein#add( 'osyo-manga/shabadou.vim' )
call dein#add( 'thinca/vim-quickrun' )
call dein#add( 'mattn/emmet-vim' )
call dein#add( 'kien/ctrlp.vim' )
call dein#add( 'fuenor/qfixhowm' )
call dein#add( 'rcmdnk/vim-markdown' )
call dein#add( 'vim-scripts/surround.vim' )
call dein#add( 'othree/eregex.vim' )
call dein#add( 'tpope/vim-fugitive' )
call dein#add( 'gregsexton/gitv' )
call dein#add( 'airblade/vim-gitgutter' )
call dein#add( 'itchyny/lightline.vim' )
call dein#add( 'scrooloose/syntastic' )
call dein#add( 'osyo-manga/vim-over' )
call dein#add( 'nathanaelkane/vim-indent-guides' )
call dein#add( 'LeafCage/yankround.vim' )
call dein#add( 'osyo-manga/vim-anzu' )
call dein#add( 'vim-jp/vim-go-extra' )
call dein#add( 'Blackrush/vim-gocode' )
call dein#add( 'dgryski/vim-godef' )
call dein#add( 'vim-scripts/gtags.vim' )
call dein#add( 'haya14busa/incsearch.vim' )
call dein#add( 'vim-scripts/vim-auto-save' )
call dein#add( 'rking/ag.vim' )

" Color Scheme )
call dein#add( 'chriskempson/vim-tomorrow-theme' )
call dein#add( 'altercation/vim-colors-solarized' )
call dein#add( 'nanotech/jellybeans.vim' )

call dein#end()

filetype plugin indent on
if dein#check_install()
  call dein#install()
endif

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

noremap <Space>j <C-f>
noremap <Space>k <C-b>

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
if isdirectory($HOME.'/.vim/backup/backup')
  set backupdir=$HOME/.vim/backup/backup
endif
if isdirectory($HOME.'/.vim/backup/swap')
  set directory=$HOME/.vim/backup/swap
endif
if isdirectory($HOME.'/.vim/backup/undo')
  set undodir=$HOME/.vim/backup/undo
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
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType cpp setlocal omnifunc=ccomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}}

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

" {{{ ===== vim-auto-save
" enable auto save
let g:auto_save = 1
" do not save while in insert mode
let g:auto_save_in_insert_mode = 0
" do not display auto-save notification
let g:auto_save_silent = 1
" }}}

" {{{ ==== vim_markdown
" disable folding
let g:vim_markdown_folding_disabled = 1
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
