return {
  -- ── Telescope: fuzzy finder ──────────────────────────────────────────────────
  {
    "nvim-telescope/telescope.nvim",
    cmd          = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond  = function() return vim.fn.executable("make") == 1 end,
      },
    },
    opts = {
      defaults = {
        prompt_prefix   = "  ",
        selection_caret = "  ",
        border          = true,
        layout_strategy = "horizontal",
        layout_config   = {
          horizontal   = { prompt_position = "top", preview_width = 0.55 },
          width        = 0.87,
          height       = 0.80,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-q>"] = "send_to_qflist",
            ["<Esc>"] = "close",
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },

  -- ── Oil: edit the filesystem like a buffer ───────────────────────────────────
  {
    "stevearc/oil.nvim",
    lazy         = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      columns = { "icon", "permissions", "size", "mtime" },
      buf_options = { buflisted = false, bufhidden = "hide" },
      view_options = {
        show_hidden    = false,
        natural_order  = true,
      },
      keymaps = {
        ["<CR>"] = "actions.select",
        ["-"]    = "actions.parent",
        ["_"]    = "actions.open_cwd",
        ["`"]    = "actions.cd",
        ["g."]   = "actions.toggle_hidden",
        ["g?"]   = "actions.show_help",
        ["<C-p>"] = "actions.preview",
        ["<C-r>"] = "actions.refresh",
      },
      float = {
        padding     = 2,
        border      = "rounded",
      },
    },
  },

  -- ── Mini.nvim: tiny focused utilities ────────────────────────────────────────
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      -- Auto pairs
      require("mini.pairs").setup()

      -- Surround: gs* prefix keeps it out of the way
      require("mini.surround").setup({
        mappings = {
          add            = "gsa",
          delete         = "gsd",
          find           = "gsf",
          find_left      = "gsF",
          highlight      = "gsh",
          replace        = "gsr",
          update_n_lines = "gsn",
        },
      })

      -- Buffer deletion that preserves window layout
      require("mini.bufremove").setup()

      -- Commenting (gc / gcc)
      require("mini.comment").setup()

      -- Enhanced text-objects (around/inside function, class, arg…)
      require("mini.ai").setup({ n_lines = 500 })

      -- Move lines / selections with Alt+hjkl
      require("mini.move").setup()
    end,
  },

  -- ── Todo comments ─────────────────────────────────────────────────────────────
  {
    "folke/todo-comments.nvim",
    event        = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs        = true,
      sign_priority = 8,
      keywords = {
        FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning",  alt = { "WARNING", "XXX" } },
        PERF = { icon = " ",                    alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint",    alt = { "INFO" } },
      },
    },
  },

  -- ── Trouble: proper diagnostic panel (goodbye ugly bottom bar) ───────────────
  {
    "folke/trouble.nvim",
    cmd  = "Trouble",
    opts = {
      modes = {
        diagnostics = { auto_close = true },
      },
    },
  },

  -- ── Flash: lightning-fast motions ─────────────────────────────────────────────
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts  = {},
    keys  = {
      { "s",     function() require("flash").jump() end,              mode = { "n", "x", "o" }, desc = "Flash jump" },
      { "S",     function() require("flash").treesitter() end,        mode = { "n", "x", "o" }, desc = "Flash treesitter" },
      { "r",     function() require("flash").remote() end,            mode = "o",               desc = "Remote flash" },
      { "R",     function() require("flash").treesitter_search() end, mode = { "o", "x" },      desc = "Treesitter search" },
      { "<C-s>", function() require("flash").toggle() end,            mode = "c",               desc = "Toggle flash search" },
    },
  },
}
