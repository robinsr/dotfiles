call plug#begin("~/.vim/plugged")

" Plug 'freddiehaddad/feline.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' 
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'wuelnerdotexe/vim-astro'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'folke/which-key.nvim'
Plug 'numToStr/Comment.nvim'
" Plug 'folke/trouble.nvim'

call plug#end()

" ================
" General Settings
" ================

" Enable line numbers (absolute)
set number

" Enable Terminal Window Name
"  - uses format specified in 'titlestring'
set title                   
set titlestring=Vim:\ %F\ %a%r%m
set titlelen=70

" Enable Terminal GUI Colors 
"  - Enables 24-bit RGB colors (any modern emulator will support)
"  - Required by feline 
set termguicolors

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 

set showtabline=2           " always show tab bar (even if just one tab open)

" Enable mouse usage (do these two conflict?)
set mouse=v                 " middle-click paste with 
set mouse=a                 " enable mouse click

set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 

" Set tab/spaces settings
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set wildmode=longest,list   " get bash-like tab completions
set wildmenu 

" Enable column 'ruler' at 80 columns (looks bad, so I have it disabled)
" set cc=80 


" allow auto-indenting depending on file type
filetype plugin indent on

set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.


" ===================
" Syntax Highlighting
"

" Enable syntax highlighting
syntax on

" Options for installed syntax highlighters
let g:astro_typescript = 'enable'

" Heredoc highlighting
" - support embedded lua, python and ruby
"   (doesnt seem to fix the issue - there's two open GH issues on this)
let g:vimsyn_embed = 'lPr'

let g:airline_powerline_fonts = 1


""" Core plugin configuration (lua)
lua << EOF
require('user.theme')

-- require('feline').setup()
-- require('feline').winbar.setup()
-- Not sure how to theme feline yet; only ships with default theme
-- require('feline').useTheme()

-- nvim-tree - disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- nvim.tree - empty setup using defaults
require('nvim-tree').setup()

-- gitsigns for feline statusbar
require('gitsigns').setup()

-- my LSP config
require('user.lsp.mason')
require('user.cmp')

-- my keys file at ./lua/keys.lua
require('user.keys')

-- WhichKey - call after other modules have installed and registered bindings
require('user.which-key').setup()
EOF


