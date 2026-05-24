return {
  {
    "github/copilot.vim",
    lazy   = false,
    config = function()
      -- Don't hijack Tab — blink.cmp owns it
      vim.g.copilot_no_tab_map      = true
      vim.g.copilot_assume_mapped   = true
      vim.g.copilot_tab_fallback    = ""

      -- Opt out of suggestions in files where they get in the way
      vim.g.copilot_filetypes = {
        ["*"]        = true,
        ["markdown"]  = false,
        ["text"]      = false,
        ["gitcommit"] = false,
      }

      -- Accept with <C-y>, cycle with <C-]> / <C-[>, dismiss with <C-\>
      -- These are set in core/keymaps.lua
    end,
  },
}
