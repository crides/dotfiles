set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set nocompatible              " be iMproved, required
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

" === Completion ===
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'simrat39/rust-tools.nvim'

" Optional dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

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

Plug 'powerline/powerline'
" Plug 'datwaft/bubbly.nvim'
" let g:bubbly_palette = {
"     \ "background": "#3c3836",
"     \ "foreground": "#fbf1c7",
"     \ "black": "#1d2021",
"     \ "red": "#fb4934",
"     \ "green": "#b8bb26",
"     \ "yellow": "#fabd2f",
"     \ "blue": "#83a598",
"     \ "purple": "#d3869b",
"     \ "cyan": "#8ec07c",
"     \ "white": "#fbf1c7",
"     \ "lightgrey": "#d5c4a1",
"     \ "darkgrey": "#665c54",
"     \ }
" let g:bubbly_statusline = ['mode', 'truncate', 'path', 'branch', 'signify', 'coc', 'divisor', 'diff', 'filetype', 'progress']

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

let g:neovide_cursor_vfx_mode = "sonicboom"

" === Colorscheme ===
Plug 'glepnir/oceanic-material'
Plug 'jsit/toast.vim'
Plug 'flrnprz/plastic.vim'
Plug '~/.vim/bundle/helios.vim'
Plug 'projekt0n/github-nvim-theme'

Plug 'ayu-theme/ayu-vim'
let ayucolor = 'dark'

Plug 'glepnir/zephyr-nvim'
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
set guifont=Iosevka\ Term:h16
set signcolumn=auto:9
set wildmode=longest,full
set inccommand=nosplit

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

au BufRead,BufNewFile *.maude setfiletype maude
au BufRead,BufNewFile *.fm setfiletype maude
autocmd FileType maude source ~/.vim/maude.vim
augroup rust
    function Rust()
        set mps+=<:> tw=110
        " Code navigation shortcuts
        noremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
        noremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
        noremap <silent> gLD    <cmd>lua vim.lsp.buf.implementation()<CR>
        noremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
        noremap <silent> 1gLD   <cmd>lua vim.lsp.buf.type_definition()<CR>
        noremap <silent> gLR    <cmd>lua vim.lsp.buf.references()<CR>
        noremap <silent> gL0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
        noremap <silent> gLW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
        noremap <silent> gLd    <cmd>lua vim.lsp.buf.declaration()<CR>
        nnoremap <silent> gLa    <cmd>lua vim.lsp.buf.code_action()<CR>
        setl omnifunc=v:lua.vim.lsp.omnifunc
        " Show diagnostic popup on cursor hold
        " au CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

        " Goto previous/next diagnostic warning/error
        nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
        nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
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

lua << EOF
--require("nvim-treesitter.configs").setup {
--    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--    ignore_install = { }, -- List of parsers to ignore installing
--    highlight = {
--        enable = true,              -- false will disable the whole extension
--        disable = { },  -- list of language that will be disabled
--    },
--    indent = {
--        enable = true,
--    },
--}

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics {
--         virtual_text = true,
--         signs = true,
--         update_in_insert = true,
--     }
-- )

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--     capabilities = capabilities
-- }
require('rust-tools').setup {
    tools = { -- rust-tools options
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler
        -- default: true
        hover_with_actions = true,

        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = false,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<-",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "=>",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"}
            },
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        capabilities = capabilities,
        on_attach = function() end,
        settings = {
            ["rust-analyzer"] = {
                completion = {
                    addCallArgumentSnippets = true,
                },
                assist = {
                    importGranularity = "module",
                    importPrefix = "by_self",
                },
                cargo = {
                    loadOutDirsFromCheck = true
                },
                procMacro = {
                    enable = true
                },
            },
        },
    },
}

require("trouble").setup {}

require("todo-comments").setup {
    signs = true, -- show icons in the signs column
    -- keywords recognized as todo comments
    keywords = {
        FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
    },
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
        before = "", -- "fg" or "bg" or empty
        keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
        after = "fg", -- "fg" or "bg" or empty
        pattern = " (KEYWORDS)([: ].+|$)",
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
    colors = {
        error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
        warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
        info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
        hint = { "LspDiagnosticsDefaultHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
    },
    search = {
        command = "rg",
        args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
        },
        pattern = " (KEYWORDS)([: ].+|$)",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
}

local cmp = require 'cmp'
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
EOF
