return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local function on_attach(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)
        -- ファイル操作
        vim.keymap.set("n", "c", api.fs.copy.node,        opts("Copy"))
        vim.keymap.set("n", "x", api.fs.cut,              opts("Cut"))
        vim.keymap.set("n", "p", api.fs.paste,            opts("Paste"))
        vim.keymap.set("n", "r", api.fs.rename,           opts("Rename"))
        vim.keymap.set("n", "d", api.fs.remove,           opts("Delete"))
        vim.keymap.set("n", "a", api.fs.create,           opts("Create"))
      end

      require("nvim-tree").setup({
        on_attach = on_attach,
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
          git_ignored = false,
        },
      })

      local function set_tree_transparent()
        vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { bg = "NONE" })
      end

      set_tree_transparent()
      local group = vim.api.nvim_create_augroup("user_nvimtree_transparent", { clear = true })
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        callback = set_tree_transparent,
      })
    end,
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
      { "<leader>fe", "<cmd>NvimTreeFocus<cr>", desc = "Focus file tree" },
    },
  },
}
