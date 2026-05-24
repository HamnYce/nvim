-- Leader must be set before lazy loads anything
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load core options early so they apply before plugins
require("core.options")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "plugins" }, {
  defaults = { lazy = true },
  change_detection = { notify = false },
  ui = {
    border = "rounded",
    backdrop = 60,
    icons = {
      cmd        = " ",
      config     = "",
      event      = " ",
      favorite   = " ",
      ft         = " ",
      init       = " ",
      import     = " ",
      keys       = " ",
      lazy       = "󰒲 ",
      loaded     = "●",
      not_loaded = "○",
      plugin     = " ",
      runtime    = " ",
      require    = "󰢱 ",
      source     = " ",
      start      = " ",
      task       = "✔ ",
      list       = { "●", "➜", "★", "‒" },
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin",
        "2html_plugin", "spellfile_plugin",
      },
    },
  },
})

require("core.autocmds")

vim.schedule(function()
  require("core.keymaps")
end)
