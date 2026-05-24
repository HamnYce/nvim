return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd   = { "ConformInfo" },
    opts  = {
      formatters_by_ft = {
        lua        = { "stylua" },
        python     = { "ruff_format" },
        go         = { "gofumpt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        jsx        = { "prettier" },
        tsx        = { "prettier" },
        css        = { "prettier" },
        html       = { "prettier" },
        json       = { "prettier" },
        yaml       = { "prettier" },
        markdown   = { "prettier" },
        c          = { "clang_format" },
        cpp        = { "clang_format" },
        -- Fallback: any filetype without an explicit formatter
        ["_"]      = { "trim_whitespace" },
      },
      format_on_save = {
        timeout_ms   = 500,
        lsp_fallback = true,
      },
    },
  },
}
