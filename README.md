# nvim

Personal Neovim configuration — standalone, no NvChad dependency.

## Requirements

- Neovim ≥ 0.10
- Git, `make` (for telescope-fzf-native)
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal
- Optional: `ripgrep` (live grep), `fd` (file search), `lazygit`

## Install

```sh
git clone https://github.com/Hamnyce/nvim ~/.config/nvim
nvim   # lazy.nvim bootstraps itself and installs all plugins on first launch
```

## Structure

```
init.lua                  -- entry point: leader, lazy bootstrap, core load
lua/
  core/
    options.lua           -- vim.opt settings, diagnostic config
    keymaps.lua           -- global keymaps
    autocmds.lua          -- autocommands (yank highlight, cursor restore, …)
  plugins/
    init.lua              -- colorscheme (catppuccin), icons, UI chrome
    ui.lua                -- lualine, bufferline, noice, nvim-notify, snacks, which-key
    editor.lua            -- telescope, oil, mini.nvim, todo-comments, trouble, flash
    lsp.lua               -- mason, mason-lspconfig, nvim-lspconfig, lazydev
    completion.lua        -- blink.cmp + friendly-snippets
    formatting.lua        -- conform.nvim (format-on-save)
    treesitter.lua        -- nvim-treesitter + text-objects
    git.lua               -- gitsigns, git-blame, lazygit via snacks
    ai.lua                -- github/copilot.vim
```

## Plugins

| Category    | Plugin(s) |
|-------------|-----------|
| Theme       | catppuccin/nvim (mocha) |
| UI          | lualine, bufferline, noice, nvim-notify, indent-blankline, snacks dashboard |
| Navigation  | Telescope + fzf-native, Oil (filesystem-as-buffer), Flash (motions) |
| Editor      | mini.nvim (pairs, surround, bufremove, comment, ai, move), todo-comments, Trouble |
| LSP         | mason → mason-lspconfig → nvim-lspconfig; lazydev for Lua config |
| Completion  | blink.cmp + friendly-snippets |
| Formatting  | conform.nvim (format-on-save; stylua, ruff, gofumpt, prettier, clang-format) |
| Syntax      | nvim-treesitter + treesitter-textobjects |
| Git         | gitsigns, git-blame, lazygit (via snacks) |
| AI          | github/copilot.vim |

## LSP servers (auto-installed via Mason)

`lua_ls` · `ts_ls` · `html` · `cssls` · `gopls` · `basedpyright` · `ruff` · `clangd` · `marksman`

Additional servers (`hls`, `zls`) are configured but not auto-installed — install them manually via `:Mason`.

## Key mappings (leader = `<Space>`)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>e` / `-` | File explorer (Oil) |
| `<leader>lf` | Format file |
| `<leader>lr` | Rename symbol |
| `<leader>la` | Code action |
| `<leader>xx` | Toggle diagnostics panel |
| `<leader>gL` | Lazygit |
| `<leader>gB` | Toggle git blame |
| `<Tab>` / `<S-Tab>` | Next / prev buffer |
| `<leader>x` | Close buffer |
| `<C-y>` | Accept Copilot suggestion |
| `s` / `S` | Flash jump / treesitter jump |

## Formatting style

Default indent: **2 spaces**. Overridden to **4 spaces + tabs** for Go/C/C++/Python/Rust via autocmd.
