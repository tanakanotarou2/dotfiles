if &compatible
  set nocompatible " Be iMproved
endif

" Required:
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('~/.cache/nvim/dein')

" Let dein manage dein
call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

" Add or remove your plugins here like this:
call dein#add('Shougo/ddc.vim') " 補完
call dein#add('vim-denops/denops.vim') " Deno 
call dein#add('Shougo/pum.vim') " popup 表示
call dein#add('Shougo/ddc-ui-pum')

" ddc
call dein#add('Shougo/ddc-around') " カーソル周辺の既出単語を補完
call dein#add('Shougo/ddc-source-nextword')
call dein#add('Shougo/ddc-matcher_head') " 入力中の単語を補完の対象にするfilter
call dein#add('Shougo/ddc-sorter_rank') " 補完候補を適切にソートするfilter
call dein#add('Shougo/ddc-converter_remove_overlap') " 補完候補の重複を防ぐためのfilter

" LSP
call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')
call dein#add('Shougo/ddc-source-nvim-lsp')

" call dein#add('Shougo/neosnippet.vim')
" call dein#add('Shougo/neosnippet-snippets')


" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable


" If you want to install not installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

" コメントアウトしたプラグインを削除できるようにする (https://taaiyoo.hateblo.jp/entry/2019/08/04/163036)
if len(dein#check_clean()) != 0
  call map(dein#check_clean(), "delete(v:val, 'rf')")
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ddc 設定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ddc.vim とpum.vim の連携
" https://zenn.dev/shougo/articles/ddc-vim-pum-vim#ddc.vim-%2B-pum.vim-%E3%81%AE%E9%80%A3%E6%90%BA%E6%96%B9%E6%B3%95
call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global('sources', ['around', 'nextword', 'nvim-lsp'])
call ddc#custom#patch_global('sourceOptions', {
      \ 'around': {'mark': 'A'},
      \ 'nextword': {'mark': 'nextword'},
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ 'nvim-lsp': {
      \   'matchers': ['matcher_head'],
      \   'mark': 'lsp',
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*|::\w*',
      \ }
      \ })

call ddc#custom#patch_global('sourceParams', {
      \ 'nvim-lsp': { 'kindLabels': { 'Class': 'c' } },
      \ })

call ddc#enable()

" ddc keymap
inoremap <silent><expr> <TAB>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#map#manual_complete()

inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

" エラーの表示設定
" https://qiita.com/kitagry/items/216c2cf0066ff046d200#lspdocumentdiagnostics
let g:lsp_signs_enabled = 1
"let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1

" TODO: 反映されない.よくわからず.
let g:lsp_signs_error = {'text': '✗'}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 設定いろいろ
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set number
set clipboard=unnamed ",autoselect
set ignorecase
set smartcase
" 検索強調
set hls
" 加減算10進強制
set nrformats=

"indent, eolをbackspaceで削除可に
set backspace=2

"インクリメンタルサーチ有効 
set incsearch

"バッファ切り替え時警告しない
set hidden

" tmp files 
set directory=~/.vim/tmp
set backupdir=~/.vim/tmp
set undodir=~/.vim/tmp
set backupskip=/tmp/*,/private/tmp/*

" 自動的にコメント文字列が挿入されるのをやめる 
" https://hyuki.hatenablog.com/entry/20140122/vim#c
augroup auto_comment_off
autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

set modeline
" 3行目までをモードラインとして検索する
set modelines=3

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" キーマップ 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" カーソル移動
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" 引数リスト移動
nnoremap <silent> [a :previous!<CR>
nnoremap <silent> ]a :next!<CR>
nnoremap <silent> [A :first!<CR>
nnoremap <silent> ]A :last!<CR>

" バッファリスト移動
nnoremap <silent> [b :bprevious!<CR>
nnoremap <silent> ]b :bnext!<CR>
nnoremap <silent> [B :bfirst!<CR>
nnoremap <silent> ]B :blast!<CR>
" quickfixリスト移動
nnoremap <silent> [c :cprev!<CR>
nnoremap <silent> ]c :cnext!<CR>
nnoremap <silent> [C :cfirst!<CR>
nnoremap <silent> ]C :clast!<CR>

" ctrl-l で検索ハイライトを消す
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" 検索very magicをデフォルトに
nnoremap / /\v
" アクティブなファイルのディレクトリを展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" アクティブファイルパスを表示
command! Pwf echo expand('%:p')


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color 設定
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme desert256
" colorscheme ambient
colorscheme molokai
set pumblend=10 " pop-up menu が半透明になる
set termguicolors

" 背景透明にする(colorschema 指定後にセットすること)
highlight Normal ctermbg=none guibg=NONE
highlight NonText ctermbg=none guibg=NONE
highlight LineNr ctermbg=none guibg=NONE
highlight Folded ctermbg=none guibg=NONE
highlight EndOfBuffer ctermbg=none guibg=NONE

