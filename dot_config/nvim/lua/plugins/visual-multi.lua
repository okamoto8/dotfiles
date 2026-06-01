return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      -- Keep <C-n> for nvim-tree and use <C-d> to add next match like VS Code.
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
      }
    end,
  },
}
