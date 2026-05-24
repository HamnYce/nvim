local opt = vim.opt

-- UI
opt.number         = true
opt.relativenumber = true
opt.cursorline     = true
opt.signcolumn     = "yes"
opt.scrolloff      = 8
opt.sidescrolloff  = 8
opt.wrap           = false
opt.colorcolumn    = "100"
opt.termguicolors  = true
opt.showmode       = false   -- lualine handles this
opt.cmdheight      = 1
opt.laststatus     = 3       -- single global statusline
opt.splitbelow     = true
opt.splitright     = true
opt.list           = true
opt.listchars      = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars      = {
  foldopen  = "▾",
  foldclose = "▸",
  fold      = " ",
  foldsep   = " ",
  diff      = "╱",
  eob       = " ",
}

-- Editing
opt.expandtab   = true
opt.shiftwidth  = 2
opt.tabstop     = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent  = true
opt.shiftround  = true

-- Search
opt.ignorecase = true
opt.smartcase  = true
opt.hlsearch   = true
opt.incsearch  = true

-- Files
opt.undofile  = true
opt.swapfile  = false
opt.backup    = false
opt.autoread  = true
opt.updatetime = 200
opt.timeoutlen = 300

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight   = 10

-- Folding (treesitter-based)
opt.foldlevel      = 99
opt.foldlevelstart = 99
opt.foldenable     = true
opt.foldmethod     = "expr"
opt.foldexpr       = "nvim_treesitter#foldexpr()"

-- Misc
opt.clipboard      = "unnamedplus"
opt.mouse          = "a"
opt.virtualedit    = "block"
opt.inccommand     = "split"   -- live preview of :s
opt.conceallevel   = 2
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Diagnostic display: clean floating windows, no full-screen popup nonsense
vim.diagnostic.config({
  virtual_text = {
    prefix  = "●",
    spacing = 4,
  },
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
    suffix = "",
    focusable = false,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN]  = " ",
      [vim.diagnostic.severity.HINT]  = "󰠠 ",
      [vim.diagnostic.severity.INFO]  = " ",
    },
  },
  underline        = true,
  update_in_insert = false,
  severity_sort    = true,
})
