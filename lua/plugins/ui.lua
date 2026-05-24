return {
  -- ── Colorscheme ─────────────────────────────────────────────────────────────
  {
    "catppuccin/nvim",
    name     = "catppuccin",
    priority = 1000,
    lazy     = false,
    opts = {
      flavour    = "mocha",
      background = { light = "latte", dark = "mocha" },
      transparent_background = false,
      show_end_of_buffer     = false,
      term_colors            = true,
      dim_inactive = { enabled = false },
      styles = {
        comments    = { "italic" },
        conditionals = { "italic" },
        keywords    = {},
        functions   = {},
        variables   = {},
      },
      integrations = {
        blink_cmp        = true,
        gitsigns         = true,
        treesitter       = true,
        notify           = true,
        telescope        = { enabled = true },
        lsp_trouble      = true,
        which_key        = true,
        indent_blankline = { enabled = true },
        mini             = { enabled = true },
        noice            = true,
        snacks           = true,
        bufferline       = true,
        mason            = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },

  -- ── Icons ────────────────────────────────────────────────────────────────────
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ── Status line ──────────────────────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event        = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    opts = {
      options = {
        theme                = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
        globalstatus         = true,
        disabled_filetypes   = { statusline = { "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { { "mode", icon = "" } },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          { "encoding", show_bomb = true },
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- ── Buffer tabs ──────────────────────────────────────────────────────────────
  {
    "akinsho/bufferline.nvim",
    event        = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        diagnostics           = "nvim_lsp",
        always_show_bufferline = false,
        separator_style        = "slant",
        show_buffer_close_icons = true,
        show_close_icon         = false,
        color_icons             = true,
      },
    },
  },

  -- ── Noice: beautiful cmdline, search, LSP messages ───────────────────────────
  {
    "folke/noice.nvim",
    event        = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"]                = true,
          ["cmp.entry.get_documentation"]                  = true,
        },
        progress  = { enabled = true },
        hover     = { enabled = true },
        signature = { enabled = true },
      },
      presets = {
        bottom_search        = true,
        command_palette      = true,
        long_message_to_split = true,
        lsp_doc_border       = true,
      },
      messages = { enabled = true },
      notify   = { enabled = true },
    },
  },

  -- ── Notification toasts ──────────────────────────────────────────────────────
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout   = 3000,
      render    = "wrapped-compact",
      stages    = "fade",
      max_width = 60,
      top_down  = false,
    },
  },

  -- ── Indent guides ─────────────────────────────────────────────────────────────
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main  = "ibl",
    opts  = {
      indent  = { char = "│", tab_char = "│" },
      scope   = { enabled = true, show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "help", "lazy", "mason", "notify",
          "toggleterm", "trouble", "snacks_dashboard",
        },
      },
    },
  },

  -- ── Snacks: dashboard, lazygit, big-file handler, scratch ────────────────────
  {
    "folke/snacks.nvim",
    priority = 900,
    lazy     = false,
    opts = {
      bigfile   = { enabled = true },
      lazygit   = { enabled = true },
      notifier  = { enabled = false }, -- using nvim-notify via noice
      quickfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset  = {
          header = [[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
          keys = {
            { icon = " ", key = "f", desc = "Find File",    action = ":Telescope find_files" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
            { icon = " ", key = "g", desc = "Live Grep",    action = ":Telescope live_grep" },
            { icon = " ", key = "e", desc = "Explorer",     action = ":Oil" },
            { icon = "󰒲 ", key = "l", desc = "Lazy",        action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit",         action = ":qa" },
          },
        },
      },
    },
  },

  -- ── Which-key: keymap discovery ───────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts  = {
      preset = "modern",
      spec   = {
        { "<leader>f", group = "Find / Files" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>x", group = "Diagnostics / Trouble" },
      },
    },
  },
}
