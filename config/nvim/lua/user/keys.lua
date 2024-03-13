-- =================
-- My Vim Keys setup
-- =================

local M = {}

M.normal = {
  g = {
    l =            { "$", "➡️ Go to end-of-line" },
    h =            { "^", "⬅️ Go to start-of-line" },
  },
  s = {
    name =         '+Space',
    s =            { "i<space><esc>", "Insert single space" },
  },
  ["<leader>f"] = {
    name  =        '+TelescopeCmd',
    ["f"] =        { ":Telescope find_files<cr>", "🔭 Find File" },
    ["r"] =        { ":Telescope oldfiles<cr>", "🔭 Recent Files" },
    ["g"] =        { ':Telescope live_grep<cr>', "🔭 live grep" },
    ["b"] =        { ':Telescope buffers<cr>', "🔭 Open files (buffers0" },
    ["h"] =        { ':Telescope help_tags<cr>', "🔭 Help" },
    ["h"] =        { ":Telescope themes<CR>",  '🔭 Themes' },
    ["c"] =        { ':Telescope current_buffer_fuzzy_find<cr>', "🔭 Find in file" },
  },
  ["<C-p>"] =      { ":Telescope find_files<cr>", "🔭 Find File" },
  ["<leader>nf"] = { ':enew<cr>', "✨ New File" },
  ["<A-j>"] =      { ':m .+1<CR>', "🔁 Swap line down" },
  ["<A-k>"] =      { ':m .-2<CR>', "🔁 Swap line up" },
}

M.visual = {
  ["<A-j>"] =      { ":m '>+1<CR>gv=gv", "🔁 Swap line down" },
  ["<A-k>"] =      { ":m '<-2<CR>gv=gv", "🔁 Swap line up" },
}

M.insert = {
  ["<A-j>"] =      { "<Esc>:m .+1<CR>==gi", "🔁 Swap line down" },
  ["<A-k>"] =      { "<Esc>:m .-2<CR>==gi", "🔁 Swap line up" },
}

M.colemakdh = {
  ["m"] = { "h" },
  ["M"] = { "H" },
  ["n"] = { "j" },
  ["N"] = { "J" },
  ["e"] = { "k" },
  ["E"] = { "K" },
  ["i"] = { "l" },
  ["I"] = { "L" },
}



-- Mappings for LSP Completions
local lsp_gkey = {
  d = { '<cmd>lua vim.lsp.buf.declaration()<CR>', 'LSP: Go to declaration' },
  D = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'LSP: Go to def' },
  r = { '<cmd>lua vim.lsp.buf.references()<CR>', 'List References' },
  s = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Show Signature' },
  i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'List Implementations' },
  t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type Definition' },
  w = { '<cmd>lua vim.lsp.buf.document_symbol()<CR>', 'List File Symbols' },
  W = { '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>','List Project Sumbols' },
}

local lsp_K = {
  ['K'] = { '<cmd>lua vim.lsp.buf.hover()<CR>', 'Open Hover' },
}

local lsp_akey = {
  h = { '<cmd>lua vim.lsp.buf.hover()<CR>', 'Open Hober' },
  f = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'List Code Actions (?)' },
  e = { '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', 'Show Diagnostics' },
  r = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename Symbol' },
  i = { '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', 'List Callers' },
  o = { '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', 'List Calls' },
}

local lsp_other = {
  ['='] = { '<cmd>lua vim.lsp.buf.formatting()<CR>', 'Formatting' },
} 

return M
