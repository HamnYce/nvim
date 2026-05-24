local map = vim.keymap.set

-- ── Basics ────────────────────────────────────────────────────────────────────
map("n", ";",     ":",          { desc = "Enter command mode" })
map("i", "jk",   "<ESC>",      { desc = "Exit insert mode" })
map("n", "<ESC>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Save / Quit
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<CR><ESC>", { desc = "Save file" })
map("n", "<leader>w",  "<cmd>w<CR>",   { desc = "Save" })
map("n", "<leader>q",  "<cmd>q<CR>",   { desc = "Quit" })
map("n", "<leader>Q",  "<cmd>qa!<CR>", { desc = "Quit all" })

-- ── Windows ───────────────────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Increase window height" })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Decrease window height" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
map("n", "<leader>-", "<C-w>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-w>v", { desc = "Split window right" })

-- ── Buffers ───────────────────────────────────────────────────────────────────
map("n", "<Tab>",   "<cmd>bnext<CR>",  { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprev<CR>",  { desc = "Prev buffer" })
map("n", "<leader>x", function()
  require("mini.bufremove").delete()
end, { desc = "Close buffer" })

-- ── File Explorer (Oil) ───────────────────────────────────────────────────────
map("n", "<leader>e", "<cmd>Oil<CR>",  { desc = "File explorer (cwd)" })
map("n", "-",         "<cmd>Oil<CR>",  { desc = "Open Oil in current dir" })

-- ── Telescope ─────────────────────────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>",              { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",               { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>",                  { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>",               { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>",                { desc = "Recent files" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>",    { desc = "Document symbols" })
map("n", "<leader>fw", "<cmd>Telescope grep_string<CR>",             { desc = "Grep word under cursor" })
map("n", "<leader>ft", "<cmd>TodoTelescope<CR>",                     { desc = "Find todos" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>",             { desc = "Git commits" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>",            { desc = "Git branches" })

-- ── LSP (buffer-local ones are set in on_attach; these are global fallbacks) ──
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Diagnostics → loclist" })
map("n", "]d",         vim.diagnostic.goto_next,  { desc = "Next diagnostic" })
map("n", "[d",         vim.diagnostic.goto_prev,  { desc = "Prev diagnostic" })

-- ── Trouble ───────────────────────────────────────────────────────────────────
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",              { desc = "All diagnostics" })
map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer diagnostics" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>",                  { desc = "Location list" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>",                   { desc = "Quickfix list" })

-- ── Formatting ────────────────────────────────────────────────────────────────
map("n", "<leader>lf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })

-- ── Git ───────────────────────────────────────────────────────────────────────
map("n", "<leader>gB", "<cmd>GitBlameToggle<CR>",      { desc = "Toggle git blame" })
map("n", "<leader>gL", function()
  require("snacks").lazygit()
end, { desc = "Lazygit" })

-- ── Copilot ───────────────────────────────────────────────────────────────────
map("i", "<C-y>",  'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, desc = "Copilot accept" })
map("i", "<C-]>",  "<Plug>(copilot-next)",     { desc = "Copilot next suggestion" })
map("i", "<C-[>",  "<Plug>(copilot-prev)",     { desc = "Copilot prev suggestion" })
map("i", "<C-\\>", "<Plug>(copilot-dismiss)",  { desc = "Copilot dismiss" })

-- ── Motion helpers ────────────────────────────────────────────────────────────
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down (respects wrap)" })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up (respects wrap)" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<CR>==",       { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==",       { desc = "Move line up" })
map("i", "<A-j>", "<ESC><cmd>m .+1<CR>==gi",{ desc = "Move line down" })
map("i", "<A-k>", "<ESC><cmd>m .-2<CR>==gi",{ desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv",       { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv",       { desc = "Move selection up" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Paste without clobbering the register
map("v", "p", '"_dP', { desc = "Paste without yanking selection" })
