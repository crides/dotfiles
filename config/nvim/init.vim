filetype off                  " required
set helplang=en
lang en_US.utf8
let mapleader = " "

call plug#begin("~/.vim/bundle")

" === Language & filetype plugins ===
Plug '~/gitproj/k/vim-k', {'frozen': 1}
Plug 'sirtaj/vim-openscad'
Plug 'chrisbra/Colorizer'
Plug 'urbit/hoon.vim'
Plug 'leafo/moonscript-vim'
Plug 'hylang/vim-hy'
let g:hy_enable_conceal = 1

Plug 'vmchale/ion-vim'
Plug 'thyrgle/vim-dyon'
Plug 'sheerun/vim-polyglot'
let g:python_highlight_space_errors = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['c=c', 'bash=sh']
let g:vim_markdown_math = 1

Plug 'vito-c/jq.vim'
Plug 'lervag/vimtex'
let g:vimtex_quickfix_mode=0
autocmd FileType tex :set conceallevel=1
autocmd FileType tex :hi Conceal ctermfg=7 ctermbg=236
autocmd FileType tex :set iskeyword-=$
let g:tex_conceal='mgs'
let g:latex_to_unicode_auto = 1
let g:tex_flavor = "latex"

Plug 'gluon-lang/vim-gluon'
Plug 'LhKipp/nvim-nu', {'do': ':TSInstall nu'}
Plug 'derekelkins/agda-vim'
Plug 'whonore/Coqtail'
augroup CoqtailHighlights
  autocmd!
  autocmd ColorScheme *
    \  hi def CoqtailSent guibg=#002800
    \| hi def CoqtailChecked guibg=#003000
augroup END

Plug '~/gitproj/noulith/vim'
Plug 'nvim-neorg/neorg'
Plug 'terrastruct/d2-vim'
Plug 'folke/neodev.nvim'

" === Completion ===
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'simrat39/rust-tools.nvim'

" Optional dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'wookayin/semshi', {'do': ':UpdateRemotePlugins'}

" === Moving arround & Editing ===
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_keys = "asdfjkl;ghqwerquioptyzxcvm,./bn1234789056"
" map <Leader> <Plug>(easymotion-prefix)
map <Leader>/ <Plug>(easymotion-sn)
map <Leader>; <Plug>(easymotion-repeat)
map <Leader>n <Plug>(easymotion-n)
map <Leader>N <Plug>(easymotion-N)

Plug 'AndrewRadev/splitjoin.vim'
Plug 'majutsushi/tagbar'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'liuchengxu/vista.vim'
Plug 'machakann/vim-sandwich'
autocmd Filetype rust let b:sandwich_magicchar_f_patterns = [
                          \   {
                          \     'header' : '\%(\H\|\K\|^\)\zs\h\k*!\?',
                          \     'bra'    : '(',
                          \     'ket'    : ')',
                          \     'footer' : '',
                          \   },
                          \ ]

Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 250
highlight HighlightedyankRegion gui=reverse cterm=reverse

Plug 'junegunn/vim-peekaboo'
Plug 'wellle/targets.vim'
let g:targets_aiAI = 'aIAi'

Plug 'vim-scripts/ReplaceWithRegister'
Plug 'kana/vim-textobj-user'
Plug 'adriaanzon/vim-textobj-matchit'
Plug 'chaoren/vim-wordmotion'
let g:wordmotion_nomap = 1
nmap gw          <Plug>WordMotion_w
nmap gb          <Plug>WordMotion_b
nmap ge          <Plug>WordMotion_e
nmap gh          <Plug>WordMotion_ge
omap agw         <Plug>WordMotion_aw
omap igw         <Plug>WordMotion_iw

Plug 'chrisgrieser/nvim-various-textobjs'

" === UI ===
Plug 'junegunn/goyo.vim'
let g:goyo_width = 120
let g:goyo_height = "75%"
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowcmd
  set scrolloff=999
  if executable('awesome-client')
    silent !awesome-client 'client.focus.fullscreen = true'
  endif
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showcmd
  set scrolloff=5
  if executable('awesome-client')
    silent !awesome-client 'client.focus.fullscreen = false'
  endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
let g:lens#animate = 1

Plug 'Yggdroot/indentLine'
let g:indentLine_setConceal = 0

Plug 'nvim-lualine/lualine.nvim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "?",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "x",
    \ "Dirty"     : "U",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "??"
    \ }

Plug 'nvim-lua/plenary.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'axieax/urlview.nvim'

" === Colorscheme ===
Plug 'glepnir/oceanic-material'
Plug 'jsit/toast.vim'
Plug 'flrnprz/plastic.vim'
Plug '~/.vim/bundle/helios.vim'
Plug 'projekt0n/github-nvim-theme'

Plug 'ayu-theme/ayu-vim'
let ayucolor = 'dark'

Plug 'humanoid-colors/vim-humanoid-colorscheme'

Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "hard"

Plug 'arcticicestudio/nord-vim'
let g:nord_italic_comments = 1
let g:nord_italic = 1

" === Other stuff ===
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'rbong/vim-flog'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0

Plug 'airblade/vim-rooter'
let g:rooter_manual_only = 1

Plug 'joshdick/onedark.vim'
let g:onedark_termcolors = 16
highlight GitGutterAdd    ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1

Plug 'mhinz/vim-startify'
" source ~/.vim/bundle/fzf/plugin/fzf.vim
Plug 'johmsalas/text-case.nvim'

call plug#end()

runtime macros/matchit.vim

filetype plugin indent on
syntax on
" Custom settings
set laststatus=2
set shiftwidth=4
set tabstop=4
set expandtab
set hlsearch
set incsearch
set scrolloff=3
set number relativenumber
set showcmd
set splitright
set backspace=indent,eol,start
set mouse=a
set modeline
set timeout timeoutlen=3000 ttimeoutlen=50
set conceallevel=1
set autochdir
set t_Co=256
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
set guicursor=
set cursorline
set title titlestring=%{expand(\"%:~\")}%(\ %M%)%(\ %a%)
set noshowmode
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set clipboard=unnamedplus,unnamed
set magic
set guifont=Iosevka\ Term:h11
set signcolumn=auto:9
set wildmode=longest,full
set inccommand=nosplit
set scrollback=100000

" Colorscheme
set bg=dark
set termguicolors
colorscheme gruvbox

" Custom mappings
map Y y$
noremap  :noh
noremap <Up> gk
noremap <Down> gj
inoremap <Up> gk
inoremap <Down> gj
" Make n & N and , & ; always search forward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]
nnoremap <expr> ; ',;'[getcharsearch().forward]
nnoremap <expr> , ';,'[getcharsearch().forward]
" au CursorHold * lua vim.diagnostic.show_line_diagnostics()
nnoremap <silent> <leader>( <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>) <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>K  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>i  <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>k  <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>D  <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <leader>r  <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>W  <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>d  <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>o  <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> <leader>[ <Plug>(GitGutterPrevHunk)
nnoremap <silent> <leader>] <Plug>(GitGutterNextHunk)
nnoremap <silent> <leader>e <cmd>Telescope git_files<CR>
onoremap ih <Plug>(GitGutterTextObjectInnerPending)
onoremap ah <Plug>(GitGutterTextObjectOuterPending)
xnoremap ih <Plug>(GitGutterTextObjectInnerVisual)
xnoremap ah <Plug>(GitGutterTextObjectOuterVisual)
nnoremap <leader>hp <Plug>(GitGutterPreviewHunk)
nnoremap <leader>hs <Plug>(GitGutterStageHunk)
nnoremap <leader>hu <Plug>(GitGutterUndoHunk)
for i in range(1, 9)
    exe "noremap <leader>" . i . " " . i . "gt"
endfor
noremap <leader>0 10gt

packadd termdebug

" gl to switch to last active tab
if !exists('g:lasttab')
  let g:lasttab = 1
endif
noremap <silent> <leader>l <cmd>exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" avoid mispress of <SHIFT> when writing and quiting
com -nargs=0 Q q
com -nargs=0 Qa qa
com -nargs=0 W w
com -nargs=0 Wq wq
com -nargs=0 Wqa wqa

au BufRead,BufNewFile *.maude setfiletype maude
au BufRead,BufNewFile *.fm setfiletype maude
autocmd FileType maude source ~/.vim/maude.vim
augroup rust
    function Rust()
        set mps+=<:> tw=110
        " Code navigation shortcuts
        setl omnifunc=v:lua.vim.lsp.omnifunc

        " Goto previous/next diagnostic warning/error
        " Enable type inlay hints
    endfunction
    au!
    au FileType rust call Rust()
augroup end
autocmd FileType dart set sw=2 ts=2
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" ZMK keymap
au BufRead,BufNewFile *.overlay,*.keymap,*.dtsi setfiletype dts
au FileType dts set iskeyword+=-

" MLIR
au BufRead,BufNewFile *.mlir setfiletype mlir
au BufRead,BufNewFile *.ll setfiletype llvm

hi link TSPunctDelimiter Normal
hi link TSPunctBracket Normal
hi link pythonTSKeywordOperator Conditional
hi! link DiagnosticError GruvboxRed
hi! link semshiErrorChar GruvboxRed
hi! link semshiErrorSign GruvboxRed

exe "luafile " . split(&rtp, ",")[0] . "/config.lua"

let g:neovide_cursor_vfx_mode = "torpedo"
