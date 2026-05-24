require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "lua_ls",
  "gopls",
  "ts_ls",
  "marksman",
  "clangd",
  "zls",
  "ruff",
  "basedpyright",
  "hls",
  "copilot",
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
