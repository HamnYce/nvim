local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Briefly highlight yanked text
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

-- Equalise splits when the terminal is resized
autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Close these filetypes quickly with <q>
autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = { "qf", "help", "man", "notify", "lspinfo", "checkhealth", "startuptime", "tsplayground" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Auto-create parent directories when saving a new file
autocmd("BufWritePre", {
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Restore last cursor position when re-opening a file
autocmd("BufReadPost", {
  group = augroup("restore_cursor", { clear = true }),
  callback = function(event)
    local mark   = vim.api.nvim_buf_get_mark(event.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Per-filetype indent overrides
autocmd("FileType", {
  group = augroup("filetype_indent_4", { clear = true }),
  pattern = { "go", "c", "cpp", "python", "rust" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop    = 4
  end,
})

autocmd("FileType", {
  group = augroup("filetype_noexpand", { clear = true }),
  pattern = { "go", "c", "cpp" },
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- Wrap + spell in text/markdown files
autocmd("FileType", {
  group = augroup("wrap_spell", { clear = true }),
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap  = true
    vim.opt_local.spell = true
  end,
})
