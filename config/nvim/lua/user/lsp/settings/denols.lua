local nvim_lsp = require("lspconfig")

local M = {
  root_dir = nvim_lsp.util.root_pattern("deno.json"),
  enable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true
        }
      }
    }
}

return M
