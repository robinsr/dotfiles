-- =================
-- My Vim Keys setup
-- =================

local merge = vim.tbl_deep_extend

vim.g.mapleader = ","
vim.g.maplocalleader = ','

local whichmap = {}

whichmap.ctrl = { name = '+Ctrl' }
whichmap.leader = { name = '<leader>+' }
whichmap.top = { name = 'Custom' }
whichmap.g = { name = 'Goto' }
whichmap.a = { name = 'Goto (ex)' }
whichmap.insert = { name = 'Insert' }
whichmap.visual = { name = 'Visual' }

whichmap.top['j'] = "which_key_ignore"

local sym = '★  '

local mapkey = function(mode, group, desc, key, value)
  local sym_desc = sym .. desc
	local opts = { buffer = 0, remap = false, desc = sym_desc }

	vim.keymap.set(mode, key, value, opts)
	group[key] = sym_desc
end


local nmapkey = function(group, desc, key, value)
	mapkey("n", group, desc, key, value)
end

local imapkey = function(group, desc, key, value)
  mapkey("i", group, desc, key, value)
end

local vmapkey = function(group, desc, key, value)
  mapkey("v", group, desc, key, value)
end

-- ============
-- Key Bindings
-- ============

-- Toggle nvim-tree
nmapkey(whichmap.ctrl, "Toggle nvim-tree", "<C-h>", ":NvimTreeToggle<cr>")

-- Open fzf finder (git-files) with Ctrl-p (kinda like Cmd+p in sublime/vscode/webstorm)
nmapkey(whichmap.ctrl, "Open Fuzzy Finder", "<C-p>", ":GFiles<cr>")

-- Insert single space character
nmapkey(whichmap.top, "Insert single space", "ss", "i<space><esc>")

-- Insert single space character with <C-a> 
-- nmapkey(whichmap.ctrl, "Insert single character", "<C-a>", "a <ESC>r")

-- Maps Alt-{jk} to swap line up/down
nmapkey(whichmap.top, "Swap line down", "<A-j>", ":m .+1<CR>")
nmapkey(whichmap.top, "Swap line up", "<A-k>", ":m .-2<CR>")


-- Maps Alt-{jk} to swap selected lines up/down in insert-mode
imapkey(whichmap.insert, "Swap line down", "<A-j>", "<Esc>:m .+1<CR>==gi")
imapkey(whichmap.insert, "Swap line up", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Maps Alt-{jk} to swap block up/down in VISUAL mode
vmapkey(whichmap.visual, "Swap line down", "<A-j>", ":m '>+1<CR>gv=gv")
vmapkey(whichmap.visual, "Swap line up", "<A-k>", ":m '<-2<CR>gv=gv")


-- Mappings for completions (registered per buffer in lsp/handlers.lua)
-- map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
whichmap.g.D = { 'Declaration' }

-- map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
whichmap.g.d = { 'Definition' }

-- map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
whichmap.K = 'Open Hover'

-- map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
whichmap.g.r = { 'List References' }

-- map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
whichmap.g.s = { 'Show Signature' }

-- map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
whichmap.g.i = { 'List Implementations' }

-- map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
whichmap.g.t = { 'Type Definition' }

-- map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
whichmap.g.w = { 'List File Symbols' }

-- map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
whichmap.g.W = { 'List Project Sumbols' }

-- map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
whichmap.a.h = 'Open Hober'

-- map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
whichmap.g.D = { 'List Code Actions (?)' }

-- map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
whichmap.leader.ee = { 'Show Diagnostics' }

-- map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
whichmap.a.r = { 'Rename Symbol' }

-- map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
whichmap.leader['='] = { 'Formatting' }

-- map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
whichmap.a.i = { 'List Callers' }

-- map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
whichmap.a.o = { 'List Calls' }

local register = require('user.which-key').register

local setup = function ()
  register(whichmap.ctrl, '', 'n')
  register(whichmap.top, '', 'n')
  register(whichmap.g, '<leader>g', 'n')
  register(whichmap.a, '<leader>a', 'n')
  register(whichmap.insert, '', 'i')
  register(whichmap.visual, '', 'v')
end

return {
  setup = setup,
  nmapkey = nmapkey,
  vmapkey = vmapkey,
  imapkey = imapkey,
}

