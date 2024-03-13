local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

------------------------- Setup Lazy Plugins -------------------------

require('lazy').setup({
  -- Status/tabline
  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',

  -- Adds file icons to various things (tree, registers, etc)
  'nvim-tree/nvim-web-devicons',

  -- Git integration (gutter icons/color)
  'lewis6991/gitsigns.nvim',

  -- File tree
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      { "<C-h>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" }
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require('nvim-tree').setup()
    end,
  },

  -- Theme
  require('user.theme'),

  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
            "lua", "vim", "vimdoc",
            "javascript", "typescript", "css", "astro", "vue",
            "bash"
          },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
  },

  -- Better inline errors
  'folke/trouble.nvim',

  -- Snippets
  {
    'L3MON4D3/LuaSnip',
    tag = 'v2.2.0',
    build = 'make install_jsregexp'
  },

  -- Surround text
  {
    "kylechui/nvim-surround",
    branch = "main",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup()
    end
  },

  -- Auto comment/uncomment
  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },

  -- AstroJS support
  'wuelnerdotexe/vim-astro',

  -- Move language support here:
  require('user.plugins.lang'),

  -- LSP
  'neovim/nvim-lsp',
  'neovim/nvim-lspconfig',
  require('user.lsp.mason'),

  -- Completions
  require('user.cmp'),

  -- Telescope
  require('user.plugins.telescope'),
  
  -- Keyboard shortcut help window
  require('user.plugins.which-key'),
})
