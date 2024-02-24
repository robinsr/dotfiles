-- nvim-lspconfig help: https://github.com/neovim/nvim-lspconfig/blob/master/doc/lspconfig.txt

local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end


local map = function(bufnum, type, key, value)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnum, type, key, value, opts);
end


local function lsp_keymaps(bufnr)
  map(bufnr, 'n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
  map(bufnr, 'n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
  map(bufnr, 'n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
  map(bufnr, 'n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
  map(bufnr, 'n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map(bufnr, 'n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
  map(bufnr, 'n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
  map(bufnr, 'n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  map(bufnr, 'n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
  map(bufnr, 'n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
  map(bufnr, 'n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
  map(bufnr, 'n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
  map(bufnr, 'n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
  map(bufnr, 'n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  map(bufnr, 'n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
  map(bufnr, 'n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
end


M.on_attach = function(client, bufno)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end

  lsp_keymaps(0)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not status_ok then
  print('cmp_nvim_lsp not OK!')
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M



