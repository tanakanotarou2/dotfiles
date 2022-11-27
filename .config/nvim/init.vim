call plug#begin()

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'matsui54/denops-signature_help'
Plug 'matsui54/denops-popup-preview.vim'
 
" ddc
Plug 'Shougo/ddc.vim' " 補完
Plug 'vim-denops/denops.vim' " Deno 
Plug 'Shougo/pum.vim' " popup 表示
Plug 'Shougo/ddc-ui-pum'
Plug 'Shougo/ddc-around' " カーソル周辺の既出単語を補完
Plug 'Shougo/ddc-source-nextword'
Plug 'Shougo/ddc-matcher_head' " 入力中の単語を補完の対象にするfilter
Plug 'Shougo/ddc-sorter_rank' " 補完候補を適切にソートするfilter
Plug 'Shougo/ddc-converter_remove_overlap' " 補完候補の重複を防ぐためのfilter
Plug 'Shougo/ddc-source-nvim-lsp'


Plug 'tpope/vim-commentary' " コメントアウト
Plug 'kana/vim-textobj-entire' " 全体を選択するモーション ae,ie
Plug 'kana/vim-textobj-user' " (vim-textobj-entire に必要)

call plug#end()
" " Add or remove your plugins here like this:
" call dein#add('Shougo/ddc.vim') " 補完
" call dein#add('vim-denops/denops.vim') " Deno 
" call dein#add('Shougo/pum.vim') " popup 表示
" call dein#add('Shougo/ddc-ui-pum')
" 
" " ddc
" call dein#add('Shougo/ddc-around') " カーソル周辺の既出単語を補完
" call dein#add('Shougo/ddc-source-nextword')
" call dein#add('Shougo/ddc-matcher_head') " 入力中の単語を補完の対象にするfilter
" call dein#add('Shougo/ddc-sorter_rank') " 補完候補を適切にソートするfilter
" call dein#add('Shougo/ddc-converter_remove_overlap') " 補完候補の重複を防ぐためのfilter

" LSP

" call dein#add('prabirshrestha/vim-lsp')
" call dein#add('mattn/vim-lsp-settings')
" call dein#add('neovim/nvim-lspconfig')
" call dein#add('williamboman/mason.nvim')
" call dein#add('williamboman/mason-lspconfig.nvim')
" call dein#add('folke/lsp-colors.nvim')

" call dein#add('Shougo/neosnippet.vim')
" call dein#add('Shougo/neosnippet-snippets')

" Required:
" filetype plugin indent on
syntax enable


" ここのコピペ
" https://zenn.dev/kawarimidoll/scraps/b1e5b44d304704
lua << EOF
local mason = require('mason')
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

local nvim_lsp = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup_handlers({ function(server_name)
-----------------------
-- Mappings.
-----------------------
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  end

  -- 言語ごとに設定分けたりもできるっぽい?
  -- https://github.com/neovim/nvim-lspconfig#suggested-configuration
  opts.on_attach=on_attach


  nvim_lsp[server_name].setup(opts)
end })
EOF

" -- local nvim_lsp = require('lspconfig')
" -- local mason_lspconfig = require('mason-lspconfig')
" -- mason_lspconfig.setup_handlers({ function(server_name)
" --   local opts = {}
" --   opts.on_attach = function(_, bufnr)
" --     local bufopts = { silent = true, buffer = bufnr }
" --     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
" --     vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
" --     vim.keymap.set('n', 'gtD', vim.lsp.buf.type_definition, bufopts)
" --     vim.keymap.set('n', 'grf', vim.lsp.buf.references, bufopts)
" --     vim.keymap.set('n', '<space>p', vim.lsp.buf.format, bufopts)
" --  end
" --   nvim_lsp[server_name].setup(opts)
" -- end })


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

" LSP
call popup_preview#enable()
call signature_help#enable()

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
set backspace=2 "indent, eolをbackspaceで削除可に
set incsearch "インクリメンタルサーチ有効 
set hidden "バッファ切り替え時警告しない

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

" コマンドラインのマッピング。p, n でフィルタリングをした履歴をたどる
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

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
" %% でアクティブなファイルのディレクトリを展開(実践vim p.136)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" アクティブファイルパスを表示
command! Pwf echo expand('%:p')


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color 設定
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme molokai
set termguicolors
"set pumblend=10 " pop-up menu が半透明になる

" 背景透明にする(colorschema 指定後にセットすること)
highlight Normal ctermbg=none guibg=NONE
highlight NonText ctermbg=none guibg=NONE
highlight LineNr ctermbg=none guibg=NONE
highlight Folded ctermbg=none guibg=NONE
highlight EndOfBuffer ctermbg=none guibg=NONE
