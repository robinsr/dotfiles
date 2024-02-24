local nvim_lsp = require("lspconfig")

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

local tsserver = {
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  single_file_support = false,
}

return tsserver

