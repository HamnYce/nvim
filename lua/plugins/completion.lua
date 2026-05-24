return {
  -- ── blink.cmp: blazing-fast completion ───────────────────────────────────────
  {
    "saghen/blink.cmp",
    lazy         = false,
    version      = "*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = {
        preset    = "default",
        ["<Tab>"]   = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"]    = { "accept", "fallback" },
        ["<C-e>"]   = { "cancel" },
        ["<C-k>"]   = { "show_documentation", "hide_documentation" },
        ["<C-f>"]   = { "scroll_documentation_down" },
        ["<C-b>"]   = { "scroll_documentation_up" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant       = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      completion = {
        documentation = {
          auto_show          = true,
          auto_show_delay_ms = 200,
          window             = { border = "rounded" },
        },
        menu = {
          border = "rounded",
          draw   = { treesitter = { "lsp" } },
        },
        -- Disable ghost text — Copilot provides inline suggestions
        ghost_text = { enabled = false },
      },
      signature = {
        enabled = true,
        window  = { border = "rounded" },
      },
    },
  },
}
