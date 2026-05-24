-- ── LSP capabilities shared by all servers ────────────────────────────────────
local function make_capabilities()
  local caps = vim.lsp.protocol.make_client_capabilities()
  -- Extend with blink.cmp completions if available
  local ok, blink = pcall(require, "blink.cmp")
  if ok then caps = blink.get_lsp_capabilities(caps) end
  return caps
end

-- ── on_attach: buffer-local LSP keymaps + inlay hints ─────────────────────────
local function on_attach(client, bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  map("gd",          vim.lsp.buf.definition,      "Go to definition")
  map("gD",          vim.lsp.buf.declaration,     "Go to declaration")
  map("gr",          vim.lsp.buf.references,      "References")
  map("gI",          vim.lsp.buf.implementation,  "Go to implementation")
  map("gy",          vim.lsp.buf.type_definition, "Type definition")
  map("K",           vim.lsp.buf.hover,           "Hover docs")
  map("<leader>lr",  vim.lsp.buf.rename,          "Rename symbol")
  map("<leader>la",  vim.lsp.buf.code_action,     "Code action")
  map("<leader>ls",  vim.lsp.buf.signature_help,  "Signature help")

  -- Inlay hints (Neovim 0.10+)
  if vim.lsp.inlay_hint and client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    map("<leader>lh", function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
        { bufnr = bufnr }
      )
    end, "Toggle inlay hints")
  end
end

-- ─────────────────────────────────────────────────────────────────────────────

return {
  -- ── Mason: LSP / linter / formatter installer ─────────────────────────────
  {
    "williamboman/mason.nvim",
    cmd   = "Mason",
    build = ":MasonUpdate",
    opts  = {
      ui = {
        border = "rounded",
        icons  = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- ── lazydev: better Lua LS for Neovim config files ────────────────────────
  {
    "folke/lazydev.nvim",
    ft   = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },

  -- ── nvim-lspconfig (required by mason-lspconfig) ──────────────────────────
  { "neovim/nvim-lspconfig", lazy = true },

  -- ── mason-lspconfig: bridges mason ↔ lspconfig ───────────────────────────
  -- Each server uses its own built-in `filetypes` list, so the Haskell LS
  -- will never attach to a Python buffer, etc.
  {
    "williamboman/mason-lspconfig.nvim",
    event        = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "folke/lazydev.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        -- These get auto-installed the first time you open Neovim.
        -- Add or remove servers here; they'll only ever attach to their
        -- correct filetypes.
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "html",
          "cssls",
          "gopls",
          "basedpyright",
          "ruff",
          "clangd",
          "marksman",
        },
        automatic_installation = false,
      })

      local lspconfig   = require("lspconfig")
      local capabilities = make_capabilities()

      -- Default handler — picks up any mason-installed server not listed below
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach    = on_attach,
          })
        end,

        -- ── Per-server overrides ──────────────────────────────────────────

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach    = on_attach,
            settings     = {
              Lua = {
                runtime    = { version = "LuaJIT" },
                workspace  = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
                completion = { callSnippet = "Replace" },
                hint       = { enable = true },
                diagnostics = { globals = { "vim" } },
                telemetry  = { enable = false },
              },
            },
          })
        end,

        ["gopls"] = function()
          lspconfig.gopls.setup({
            capabilities = capabilities,
            on_attach    = on_attach,
            settings     = {
              gopls = {
                gofumpt = true,
                hints   = {
                  assignVariableTypes     = true,
                  compositeLiteralFields  = true,
                  constantValues          = true,
                  functionTypeParameters  = true,
                  parameterNames          = true,
                  rangeVariableTypes      = true,
                },
              },
            },
          })
        end,

        ["basedpyright"] = function()
          lspconfig.basedpyright.setup({
            capabilities = capabilities,
            on_attach    = on_attach,
            settings     = {
              basedpyright = {
                analysis = {
                  typeCheckingMode    = "standard",
                  autoSearchPaths     = true,
                  useLibraryCodeForTypes = true,
                },
              },
            },
          })
        end,

        -- ruff handles Python formatting/linting; let basedpyright own hover
        ["ruff"] = function()
          lspconfig.ruff.setup({
            capabilities = capabilities,
            on_attach    = function(client, bufnr)
              client.server_capabilities.hoverProvider = false
              on_attach(client, bufnr)
            end,
          })
        end,

        ["ts_ls"] = function()
          lspconfig.ts_ls.setup({
            capabilities = capabilities,
            on_attach    = on_attach,
            settings     = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints            = "all",
                  includeInlayFunctionParameterTypeHints    = true,
                  includeInlayVariableTypeHints             = true,
                  includeInlayPropertyDeclarationTypeHints  = true,
                  includeInlayFunctionLikeReturnTypeHints   = true,
                },
              },
              javascript = {
                inlayHints = {
                  includeInlayParameterNameHints         = "all",
                  includeInlayFunctionParameterTypeHints = true,
                },
              },
            },
          })
        end,

        ["clangd"] = function()
          lspconfig.clangd.setup({
            -- clangd needs utf-16 offset encoding
            capabilities = vim.tbl_deep_extend("force", capabilities, {
              offsetEncoding = { "utf-16" },
            }),
            on_attach = on_attach,
            cmd       = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
            },
          })
        end,

        -- Haskell (only active when haskell-language-server is installed via Mason)
        ["hls"] = function()
          lspconfig.hls.setup({
            capabilities = capabilities,
            on_attach    = on_attach,
            filetypes    = { "haskell", "lhaskell", "cabal" },
          })
        end,

        -- Zig (only active when zls is installed via Mason)
        ["zls"] = function()
          lspconfig.zls.setup({
            capabilities = capabilities,
            on_attach    = on_attach,
          })
        end,
      })
    end,
  },
}
