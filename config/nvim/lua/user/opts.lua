local opt = vim.opt
local cmd = vim.api.nvim_command

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ","
vim.g.maplocalleader = ','

opt.number = true
opt.relativenumber = true
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

opt.laststatus = 3


