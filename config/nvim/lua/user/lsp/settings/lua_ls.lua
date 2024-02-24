local nvim_lsp = require("lspconfig")

local lua_ls = {
  single_file_support = true,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

return lua_ls

