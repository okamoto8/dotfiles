return {
  {
    "ellisonleao/glow.nvim",
    cmd = { "Glow", "GlowInstall" },
    ft = { "markdown" },
    opts = {
      border = "rounded",
      width = 120,
    },
    keys = {
      { "<leader>mg", "<cmd>Glow<cr>", desc = "Markdown Glow Preview" },
    },
  },
}
