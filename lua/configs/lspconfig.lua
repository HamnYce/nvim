require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "lua_ls",
  "gopls",
  "ts_ls",
  "marksman",
  "nim_langserver",
  "clangd",
  "zls",
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
