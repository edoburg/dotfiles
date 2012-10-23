" vim:set ts=8 sts=2 sw=2 tw=0:
"
"-----------------------------------------------------------
" neobundle.vim
"
set nocompatible
filetype plugin indent off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif
let g:neobundle_default_git_protocol="https"
call neobundle#rc(expand('~/.vim/bundle'))

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'ZenCoding.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/quickrun.vim'
NeoBundle 'thinca/vim-poslist'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/unite-font'
NeoBundle 'klen/python-mode'
NeoBundle 'mikewest/vim-markdown'
NeoBundle 'msanders/snipmate.vim'
NeoBundle 'vim-scripts/surround.vim'
NeoBundle 'vim-scripts/eregex.vim'

" Color Scheme
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'altercation/vim-colors-solarized'

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
    \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif
filetype plugin indent on


"###########################################################
" 非Plugin
"###########################################################
"-----------------------------------------------------------
" 検索
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

" windowsならgrepコマンドに外部grepを使用する
if has('win32')
	set grepprg=grep.exe\ -inrHE
endif
"-----------------------------------------------------------
" 編集に関する設定:
" タブの画面上での幅
set tabstop=4
set sw=4
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

"-----------------------------------------------------------
" GUI固有ではない画面表示の設定:
" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set nowrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

set cursorline

"----------------------------------------------------------
" コマンドラインでのキーバインドを Emacs スタイルにする
" Ctrl+Aで行頭へ移動
:cnoremap <C-A>		<Home>
" Ctrl+Bで一文字戻る
:cnoremap <C-B>		<Left>
" Ctrl+Dでカーソルの下の文字を削除
:cnoremap <C-D>		<Del>
" Ctrl+Eで行末へ移動
:cnoremap <C-E>		<End>
" Ctrl+Fで一文字進む
:cnoremap <C-F>		<Right>
" Ctrl+Nでコマンドライン履歴を一つ進む
:cnoremap <C-N>		<Down>
" Ctrl+Pでコマンドライン履歴を一つ戻る
:cnoremap <C-P>		<Up>
" Alt+Ctrl+Bで前の単語へ移動
:cnoremap <Esc><C-B>	<S-Left>
" Alt+Ctrl+Fで次の単語へ移動
:cnoremap <Esc><C-F>	<S-Right>
" expand path (カレントディレクトリの補完)
cmap <c-x> <c-r>=expand('%:p:h')<cr>/
" expand file (not ext)
cmap <c-z> <c-r>=expand('%:p:r')<cr>

"----------------------------------------------------------
" default file format
:set fileformat=unix

"----------------------------------------------------------
" clipbordにヤンク
:set clipboard=unnamed

"----------------------------------------------------------
" backup/swapを書き込むディレクトリ
set backup
set swapfile
if has('win32')
	if isdirectory($VIM.'/backup/vim_backup')
		set backupdir=>$VIM/backup/vim_backup
	endif
	if isdirectory($VIM.'/backup/vim_swap')
		set directory=>$VIM/backup/vim_swap
	endif
else
	if isdirectory($HOME.'/backup/vim_backup')
		set backupdir=>$HOME/backup/vim_backup
	endif
	if isdirectory($HOME.'/backup/vim_swap')
		set directory=>$HOME/backup/vim_swap
	endif
endif

"----------------------------------------------------------
" for omnicomplete
set nocompatible
syntax on
filetype on
filetype indent on
filetype plugin on
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType c set fdm=syntax
autocmd FileType cpp set fdm=syntax
autocmd FileType cpp set omnifunc=ccomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set fenc=utf-8
autocmd FileType python set fdm=syntax
autocmd FileType ruby,eruby :map <F2> :w<ENTER>:!ruby %<ENTER>

"----------------------------------------------------------
" tags
:set tags=tags;/

"-----------------------------------------------------------
" for session
autocmd SessionLoadPost so $VIM/gvimrc

"###########################################################
" Plugin用設定
"###########################################################
"-----------------------------------------------------------
" for neocomplcache.vim
if filereadable($HOME . '/.vim/vimrc_neocomplcache.vim')
	source $HOME/.vim/vimrc_neocomplcache.vim
endif

"let g:neocomplcache_enable_at_startup = 1
"function! InsertTabWrapper()
"    if pumvisible()
"        return "\<c-n>"
"    endif
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
"        return "\<tab>"
"    elseif exists('&omnifunc') && &omnifunc == ''
"        return "\<c-n>"
"    else
"        return "\<c-x>\<c-o>"
"    endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>

"-----------------------------------------------------------
" for unite.vim
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
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

au FileType unite nnoremap <silent> <buffer> <expr> <C-Space> unite#do_action('tabopen')
au FileType unite inoremap <silent> <buffer> <expr> <C-Space> unite#do_action('tabopen')
"-----------------------------------------------------------
" for cscope (プラグインではないが)
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
	" 'CTRL-spacebar' を使うと結果を新しいウインドウで表示する。
	nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>
endif
"-----------------------------------------------------------
" for QFixHowm
let GFixHowm_Key = 'g'
	let howm_dir = $HOME.'/.howm'
if has('win32')
	let howm_dir = $USERPROFILE.'/My Documents/My Dropbox/howm'
elseif has('mac')
	let howm_dir = $HOME.'/Dropbox/howm'
endif
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'
let QFixHowm_FileType    = 'markdown'
let QFixHowm_Title       = '#'


"-----------------------------------------------------------
" for unite-colorscheme unite-font
let g:unite_enable_start_insert = 1
let g:unite_enable_split_vertically = 1
if globpath(&rtp, 'plugin/unite.vim') != ''
  nnoremap sc :<C-u>Unite colorscheme font<Cr>
endif

"-----------------------------------------------------------
" for python-mode
let g:pymode_run = 0 " quickrunで実行するから不要


"###########################################################
" ローカル環境依存
"###########################################################
if 1 && filereadable($VIM . '/vimrc_local')
  source $VIM/vimrc_local
endif
if 1 && filereadable($HOME. '/vimrc_local')
  source $HOME/vimrc_local
endif
