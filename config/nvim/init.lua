local vim = vim
local opt = vim.opt
local cmd = vim.api.nvim_command
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

-- Status/tabline
Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')

-- Adds file icons to various things (tree, registers, etc)
Plug('nvim-tree/nvim-web-devicons')

-- Git integration (gutter icons/color)
Plug('lewis6991/gitsigns.nvim')

-- File tree
Plug('nvim-tree/nvim-tree.lua')

-- Theme
Plug('catppuccin/nvim', { ['as'] = 'catppuccin' })

-- AstroJS support
Plug('wuelnerdotexe/vim-astro')

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = 'TSUpdate' })

-- LSP and completions
Plug('neovim/nvim-lsp')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')

-- Snippets
Plug('L3MON4D3/LuaSnip', { tag = 'v2.*', ['do'] = 'make install_jsregexp' })

-- Keyboard shortcut help window
Plug('folke/which-key.nvim')

-- Auto comment/uncomment
Plug('numToStr/Comment.nvim')

-- Telescope
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.5' })

vim.call('plug#end')


opt.number = true
opt.title = true
opt.titlestring = 'Vim: %F %a%r%m'
opt.showtabline = 2
opt.termguicolors = true
opt.compatible = false
opt.showmatch = true
opt.ignorecase = true

-- Enable mouse support per-mode (n=normal, v=visual, i=insert, a=all, ... see `:h mouse`) 
opt.mouse = 'n'

opt.hlsearch = true
opt.incsearch = true

-- tabstop: Determines how '\t' is displayed (how many columns of whitespace is a \t char worth?)
opt.tabstop = 2

-- softtabstop: How many columns of whitespace is a tab keypress or a backspace keypress worth?
opt.softtabstop = 2

-- expandtab: Pressing `tab` will insert spaces rather than \t
opt.expandtab = true

-- Referred to for “levels of indentation” used in shift left/right commands and formatting
opt.shiftwidth = 2

opt.autoindent = true
opt.wildmode = { 'longest', 'list' }

opt.clipboard = 'unnamedplus'
opt.cursorline = true
opt.ttyfast = true

-- This is actually the default in neovim; just leaving it here for reference
cmd('filetype plugin indent on')
cmd('syntax on')


vim.g.astro_typescript = 'enable'
vim.g.airline_powerline_fonts = 1

require('nvim-tree').setup()
require('gitsigns').setup()
require('Comment').setup()
require('user.plugins.telescope')
require('user.lsp.mason')
require('user.cmp')
require('user.keys').setup()
require('user.which-key').setup()
require('user.theme')



