return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      sidebars = { "qf", "help", "NvimTree", "neo-tree" },
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl)
        hl.NvimTreeNormal = { bg = "NONE" }
        hl.NvimTreeNormalNC = { bg = "NONE" }
        hl.NvimTreeEndOfBuffer = { bg = "NONE" }
        hl.NvimTreeWinSeparator = { bg = "NONE" }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
