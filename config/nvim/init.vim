set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set nocompatible              " be iMproved, required
filetype off                  " required
set helplang=en
lang en_US.utf8
let mapleader = " "

call plug#begin("~/.vim/bundle")

" === Language & filetype plugins ===
Plug 'leafo/moonscript-vim'
Plug 'hylang/vim-hy'
let g:hy_enable_conceal = 1

Plug 'vmchale/ion-vim'
Plug 'thyrgle/vim-dyon'
Plug 'sheerun/vim-polyglot'
let g:python_highlight_space_errors = 0

Plug 'euclio/vim-markdown-composer'
let g:markdown_composer_open_browser = 0 " Automatically start the preview server, but not
                                         " open the browser until :ComposerOpen

Plug 'plasticboy/vim-markdown'
let g:vim_markdown_fenced_languages = ['c=c', 'bash=sh']
let g:vim_markdown_math = 1

Plug 'vito-c/jq.vim'
Plug 'lervag/vimtex'
let g:vimtex_quickfix_mode=0
autocmd FileType tex :set conceallevel=1
autocmd FileType tex :hi Conceal ctermfg=7 ctermbg=236
let g:tex_conceal='abdmg'
let g:latex_to_unicode_auto = 1

Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/VimWiki/', 'ext': '.wiki'}]
autocmd FileType vimwiki :set concealcursor+=n

Plug 'gluon-lang/vim-gluon'

" === Completion ===
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Plug 'w0rp/ale'
" let g:ale_completion_enabled = 1
" let g:ale_linters = {'c': ['gcc']}
" let g:ale_c_clang_options = '-std=gnu11 -Wall'
" let g:ale_c_gcc_options = '-std=gnu11 -Wall -I/usr/avr/include -mmcu=atmega328p'

" Plug 'racer-rust/vim-racer'
" let g:racer_cmd = "~/.cargo/bin/racer"
" let g:racer_experimental_completer = 0
" let g:racer_disable_errors = 1

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" let g:deoplete#check_stderr = 1
" let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" === Moving arround & Editing ===
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_keys = "asdfjkl;ghqwerquioptyzxcvm,./bn1234789056"
" map <Leader> <Plug>(easymotion-prefix)
map <Leader>/ <Plug>(easymotion-sn)
map <Leader>; <Plug>(easymotion-repeat)
map <Leader>n <Plug>(easymotion-n)
map <Leader>N <Plug>(easymotion-N)

Plug 'majutsushi/tagbar'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
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

Plug 'michaeljsmith/vim-indent-object'
Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 250
highlight HighlightedyankRegion gui=reverse cterm=reverse

Plug 'junegunn/vim-peekaboo'
Plug 'wellle/targets.vim'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'kana/vim-textobj-user'
Plug 'adriaanzon/vim-textobj-matchit'

" === UI ===
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
let g:lens#animate = 1

Plug 'flrnprz/plastic.vim'
Plug 'Yggdroot/indentLine'
" Plug 'nathanaelkane/vim-indent-guides'
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_auto_colors = 1
" " autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=238
" " autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=239

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightlineFilename',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

Plug '~/.vim/bundle/helios.vim'
Plug 'powerline/powerline'
Plug 'ayu-theme/ayu-vim'
let ayucolor = 'dark'

Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "hard"

Plug 'arcticicestudio/nord-vim'
let g:nord_italic_comments = 1
let g:nord_italic = 1

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
let g:NERDTreeIndicatorMapCustom = {
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


" === Other stuff ===
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'airblade/vim-gitgutter'

Plug 'joshdick/onedark.vim'
let g:onedark_termcolors = 16
highlight GitGutterAdd    ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1

Plug 'mhinz/vim-startify'
" source ~/.vim/bundle/fzf/plugin/fzf.vim

call plug#end()

runtime macros/matchit.vim

filetype plugin indent on
syntax on
" Custom settings
set textwidth=100
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
set conceallevel=0
set autochdir
set t_Co=256
set foldmethod=marker    " Save folds by marker
set foldmarker=[--[,]--]
set guicursor=
set cursorline
set title titlestring=%{expand(\"%:~\")}%(\ %M%)%(\ %a%)
set noshowmode
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set clipboard=unnamedplus,unnamed
set magic
set guifont=Iosevka:h8

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
" nnoremap <expr> n 'Nn'[v:searchforward]
" nnoremap <expr> N 'nN'[v:searchforward]
nnoremap <expr> ; ',;'[getcharsearch().forward]
nnoremap <expr> , ';,'[getcharsearch().forward]

packadd termdebug

" gl to switch to last active tab
if !exists('g:lasttab')
  let g:lasttab = 1
endif
nmap gl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" avoid mispress of <SHIFT> when writing and quiting
com -nargs=0 Q q
com -nargs=0 Qa qa
com -nargs=0 W w
com -nargs=0 Wq wq
com -nargs=0 Wqa wqa

autocmd FileType rust :set mps+=<:>
autocmd FileType dart :set sw=2 ts=2
autocmd FileType markdown :set conceallevel=0
