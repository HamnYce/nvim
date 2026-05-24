return {
  -- ── Gitsigns: inline git decorations ─────────────────────────────────────────
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts  = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      current_line_blame      = false,
      current_line_blame_opts = {
        virt_text     = true,
        virt_text_pos = "eol",
        delay         = 600,
      },
      on_attach = function(bufnr)
        local gs  = package.loaded.gitsigns
        local map = function(mode, l, r, opts)
          opts        = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Hunk navigation
        map("n", "]g", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(gs.next_hunk)
          return "<Ignore>"
        end, { expr = true, desc = "Next git hunk" })

        map("n", "[g", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(gs.prev_hunk)
          return "<Ignore>"
        end, { expr = true, desc = "Prev git hunk" })

        -- Hunk actions
        map("n", "<leader>gs", gs.stage_hunk,   { desc = "Stage hunk" })
        map("n", "<leader>gr", gs.reset_hunk,   { desc = "Reset hunk" })
        map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>gd", gs.diff_this,    { desc = "Diff this" })
        map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage selected hunks" })
        map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset selected hunks" })
      end,
    },
  },

  -- ── Git blame: virtual text on the current line ───────────────────────────────
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts  = {
      enabled          = false,  -- toggle with <leader>gB
      message_template = " <summary> • <date> • <author>",
      date_format      = "%Y-%m-%d",
      virtual_text_column = 1,
    },
  },
}
