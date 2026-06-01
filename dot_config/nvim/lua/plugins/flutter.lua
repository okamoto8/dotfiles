return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("flutter-tools").setup({
        debugger = {
          enabled = true,
        },
        lsp = {
          color = {
            enabled = true,
            virtual_text = true,
          },
        },
      })
    end,
  },
}
