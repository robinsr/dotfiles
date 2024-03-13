local nvim_lsp = require("lspconfig")

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

return {
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  single_file_support = true,
}

